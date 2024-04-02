#include <jluna.hpp>
#include <string>
#include <stdlib.h>

using namespace jluna;

int main() {
    initialize();
    Base["println"]("hello julia");
    Main.safe_eval("using Pkg; Pkg.activate(\"..\")");
    Main.safe_eval("using PBRT");
    
    auto module = Main["PBRT"];

    auto func = module["greet_your_package_name"];

    std::string result = func();
    std::cout << result << std::endl;

    return 0;
}