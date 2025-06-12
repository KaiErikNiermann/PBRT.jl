#include "mylib.h"

void print_person(const Person* person) {
    printf("Name: %s, Age: %d\n", person->name, person->age);
}

Person create_person(int age, const char* name) {
    Person person;
    person.age = age;
    strncpy(person.name, name, sizeof(person.name) - 1);
    person.name[sizeof(person.name) - 1] = '\0'; // Ensure null termination
    return person;
}

int add(int a, int b) {
    return a + b;
}

void greet(const char* name) {
    printf("Hello, %s!\n", name);
}

