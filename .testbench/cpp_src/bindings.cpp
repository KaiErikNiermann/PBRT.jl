#include <pybind11/pybind11.h>
#include <iostream>
#include <string>

using namespace pybind11::literals; // for the `_a` literal
namespace py = pybind11;

typedef struct _Person {
    int age; 
    std::string name;
    _Person* self;  // self-reference for demonstration
    _Person(int a, std::string n) : age(a), name(n) {
        std::cout << "Location of self: " << this << std::endl;
        self = this;  // initialize self-reference
    }
    _Person(_Person&& other) noexcept : age(other.age), name(std::move(other.name)) {
        other.age = -1;  // mark moved-from
    }
} Person;

PYBIND11_MODULE(my_module, m) {
    py::class_<Person>(m, "Person")
        .def(py::init<int, std::string>(), "age"_a, "name"_a)
        .def_readwrite("age", &Person::age)
        .def_readwrite("name", &Person::name)
        .def_property_readonly("self", [](const Person& p) { return p.self; });
}
