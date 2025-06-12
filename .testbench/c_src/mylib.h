#ifndef MYLIB_H
#define MYLIB_H

typedef struct {
    int age; 
    char name[50];
} Person;


void print_person(const Person* person);

Person create_person(int age, const char* name);

int add(int a, int b);

void greet(const char* name);

#endif // MYLIB_H