#include <jluna.hpp>
#include <string>
#include <stdlib.h>

using namespace jluna;

int main() {
    initialize();
    Base["println"]("hello julia");
    
    Module module = Main.safe_eval_file("../src/juliaThesis.jl");
    auto func = module["greet_your_package_name"];

    std::string result = func();
    std::cout << result << std::endl;

    return 0;
}