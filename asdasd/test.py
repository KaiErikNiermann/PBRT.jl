from cffi import FFI
import traceback

ffi = FFI()

# Define the function prototypes
ffi.cdef("""
    typedef struct {
        int a;
        int b;
    } MyStruct;

    void foo(int *a);
    void say_hello();
    void bar(MyStruct *s);
""")

# Load the shared library
my_lib = ffi.dlopen('./libmylib.so')  # Use '.dll' on Windows

a = ffi.new("int *", 10)
struct = ffi.new("MyStruct *")
struct.a = 10
struct.b = 20

# print all members of the struct class 
print(struct.__class__.__dict__)

# print the memory address of the pointer
print(ffi.cast("void *", struct))

my_lib.bar(struct)
        