#ifndef BVH_H
#define BVH_H

#include <vector>
#include <iostream>
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
auto hit = [](const aabb& box, const ray& r, const interval& ray_t) -> jluna::Bool {
    float r_lo = ray_t.lo;
    float r_hi = ray_t.hi;

    for (int axis = 0; axis < 3; axis++) {
        auto ax = std::vector<interval> {box.x, box.y, box.z}[axis];
        float invD = r.direction[axis] != 0.0 ? 1.0 / r.direction[axis] : 0.0; 

        float t0 = (ax.lo - r.origin[axis]) * invD;
        float t1 = (ax.hi - r.origin[axis]) * invD;
        
        if (invD < 0.0) 
            std::swap(t0, t1);

        r_lo = t0 > r_lo ? t0 : r_lo;
        r_hi = t1 < r_hi ? t1 : r_hi;

        if (r_hi <= r_lo) 
            return false;
    }
    return true;
};

#endif // BVH_H