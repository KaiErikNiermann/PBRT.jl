#include <iostream>
#include "my_template.h"

int main() {
    MyTemplate<int> intObj(42);
    MyTemplate<double> doubleObj(3.14);

    std::cout << "Int Value: " << intObj.getValue() << std::endl;
    std::cout << "Double Value: " << doubleObj.getValue() << std::endl;

    return 0;
}