#ifndef AABB_H
#define AABB_H

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

    ray() : 
        origin({0.0, 0.0, 0.0}), direction({0.0, 0.0, 0.0}) {}
};

class interval {
    public:
        double lo;
        double hi;
        
        interval() :
            lo(0.0), hi(0.0) {}

        interval(double lo, double hi) :
            lo(lo), hi(hi) {}
};

class ray_itval {
    public:
        interval t;
        ray r;
        ray_itval() :
            t(0.0, 0.0), r() {}
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
set_usertype_enabled(ray_itval);

// lambda function to check if a ray hits a box
std::function<jluna::Bool(const aabb&, const ray&, const interval&)> create_aabb_hit_func();

#endif // AABB_H