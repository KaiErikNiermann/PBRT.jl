import inspect
import cppyy
import gc
import sys
import my_module
import ctypes

import my_module.my_module

cppyy.cppdef(
    """    
    #include <string>

    typedef struct _Person {
        int age; 
        std::string name;
        _Person* self;  // self-reference for demonstration
        _Person(int a, std::string n) : age(a), name(n) {
            self = this;  // initialize self-reference
        }
        _Person(_Person&& other) noexcept : age(other.age), name(std::move(other.name)) {
            other.age = -1;  // mark moved-from
        }
    } Person;
    """
)


def print_meta(obj):
    address = id(obj)
    size = sys.getsizeof(obj)
    raw = (ctypes.c_ubyte * size).from_address(address)

    print(f"Object: {repr(obj)}")
    print(f"Type: {type(obj)}")
    print(f"Address: {hex(address)}")
    print(f"Total size: {size} bytes\n")

    print("🧱 CPython Memory Layout (64-bit)")

    def dump_section(name, start, end, desc):
        hex_dump = " ".join(f"{raw[i]:02x}" for i in range(start, min(end, size)))
        print(f"{name:12} [{start:>3}-{end - 1:>3}] : {desc}")
        print(f"               Hex: {hex_dump}")
        if end - start == 8:
            val = int.from_bytes(raw[start:end], byteorder="little")
            print(f"               Int: {val}")
        print()

    # CPython header
    dump_section("ob_refcnt", 0, 8, "Reference count")
    dump_section("ob_type", 8, 16, "Type pointer")

    # Payload breakdown
    print("🧩 Payload Breakdown")

    def payload(start=16):
        if isinstance(obj, int):
            # Python small int (varies by implementation)
            int_val = obj
            print(f"int_value    [{start:>3}-{size - 1:>3}] : Integer payload")
            print(f"               Value: {int_val}\n")

        elif isinstance(obj, str):
            str_bytes = obj.encode("utf-8")
            dump_section("length", start, start + 8, "Length field (guessed)")
            dump_section("hash", start + 8, start + 16, "Hash (cached)")
            char_start = start + 16
            char_end = min(size, char_start + len(str_bytes))
            dump_section(
                "char_data", char_start, char_end, "String characters (utf-8 guess)"
            )
            print(f"               Decoded: {str_bytes.decode('utf-8')}\n")

        elif isinstance(obj, list):
            dump_section("ob_size", start, start + 8, "List length")
            dump_section(
                "allocated", start + 8, start + 16, "Allocated slots (guessed)"
            )
            dump_section("ob_item", start + 16, start + 24, "Pointer to item array")
            print(f"               List contents: {obj}\n")

        elif isinstance(obj, dict):
            print(
                f"dict_data    [{start:>3}-{size - 1:>3}] : Dict layout varies per version"
            )
            print(f"               Keys: {list(obj.keys())}")
            print(f"               Values: {list(obj.values())}\n")

        elif hasattr(obj, "__dict__"):
            print(
                f"object_data  [{start:>3}-{size - 1:>3}] : Instance of user-defined class"
            )
            dump_section("ob_dict", start, size, "field hex")
            print(f"               Fields: {obj.__dict__}\n")

        else:
            dump_section("ptr", start, start + 4, "cpp instance pointer")

    payload()


Person = cppyy.gbl.Person
move = cppyy.gbl.std.move


class _Person:
    def __init__(self, age, name):
        self.age = age
        self.name = name
        self.self = self


p = Person(30, "Alice")

p2 = _Person(30, "Alice")

p3 = my_module.my_module.Person(30, "Alice")

# print_meta(p)
# print_meta(p2)
print(p.self)
print_meta(p)
