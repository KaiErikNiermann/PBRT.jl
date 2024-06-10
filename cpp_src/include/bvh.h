#ifndef BVH_H
#define BVH_H

#include <vector>
#include <iostream>
#include <functional>
#include <string>

#include <jluna.hpp>

class ray {
    std::vector<double> at(double t) {
        return {origin[0] + t * direction[0], origin[1] + t * direction[1], origin[2] + t * direction[2]};
    }

    public:
        std::vector<double> origin;
        std::vector<double> direction;
};

class interval {
    public:
        double lo;
        double hi;
};

class aabb {
    public:
        interval x;
        interval y;
        interval z;
};

set_usertype_enabled(ray);
set_usertype_enabled(interval);
set_usertype_enabled(aabb);


// lambda function to check if a ray hits a box
std::function<jluna::Bool(const aabb&, const ray&, const interval&)> create_hit_function();

#endif // BVH_H