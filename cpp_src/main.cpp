#include <jluna.hpp>
#include <string>
#include <stdlib.h>

using namespace jluna;

struct Point {
    double _x; 
    double _y;

    // constructor
    Point(double x, double y) : _x(x), _y(y) {}

    // default constructor
    Point() : _x(0), _y(0) {}
};
set_usertype_enabled(Point);

int main() {
    jluna::initialize();
    
    Main.safe_eval("using Pkg; Pkg.activate(\"..\")");
    Main.safe_eval("using PBRT");
    
    Usertype<Point>::add_property<double>(
        "_x", 
        [](Point& p) -> double { return p._x; },
        [](Point& p, double x) -> void { p._x = x; }
    );

    Usertype<Point>::add_property<double>(
        "_y", 
        [](Point& p) -> double { return p._y; },
        [](Point& p, double y) -> void { p._y = y; }
    );

    Usertype<Point>::implement(); 

    auto module = Main["PBRT"];

    auto func2 = module["data_pass_test"];

    Point point = func2();


    std::cout << "Point: " << point._x << ", " << point._y << std::endl;

    return 0;
}