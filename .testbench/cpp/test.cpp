#include <iostream>

class A {
    public:
        virtual void foo() = 0;
};

class B : public A {
    public:
        void foo() override {
            std::cout << "B::foo()" << std::endl;
        }
        void bar() {
            std::cout << "B::bar()" << std::endl;
        }
};

class C : public A {
    void foo() override {
        std::cout << "C::foo()" << std::endl;
    }
};



int main() {
    A *a = new B();
    a->foo();

    if (B *b = dynamic_cast<B *>(a)) {
        b->bar();
    }
    
    return 0;
}