#ifndef COLOR_H
#define COLOR_H
#include <jluna.hpp>

class RGBVec3 {
    public:
        std::array<double, 3> data{0.0, 0.0, 0.0};

        RGBVec3(double r, double g, double b) : data({r, g, b}) {}
        RGBVec3() : data({0.0, 0.0, 0.0}) {}    
};

set_usertype_enabled(RGBVec3);
#endif // !COLOR_H