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
    std::cout << "cpp hit" << std::endl;
    std::cout << "box: " << box.x.lo << " " << box.x.hi << " " << box.y.lo << " " << box.y.hi << " " << box.z.lo << " " << box.z.hi << std::endl;
    std::cout << "ray: " << r.origin[0] << " " << r.origin[1] << " " << r.origin[2] << " " << r.direction[0] << " " << r.direction[1] << " " << r.direction[2] << std::endl;
    std::cout << "ray_t: " << ray_t.lo << " " << ray_t.hi << std::endl;

    float r_lo = ray_t.lo;
    float r_hi = ray_t.hi;

    std::cout << "here1" << std::endl;

    for (int axis = 0; axis < 3; axis++) {
        std::cout << "here_start" << std::endl;
        auto ax = std::vector<interval> {box.x, box.y, box.z}[axis];
        float invD = r.direction[axis] != 0.0 ? 1.0 / r.direction[axis] : 0.0; 
        std::cout << "here2" << std::endl;

        float t0 = (ax.lo - r.origin[axis]) * invD;
        float t1 = (ax.hi - r.origin[axis]) * invD;
        std::cout << "here3" << std::endl;
        
        if (invD < 0.0) 
            std::swap(t0, t1);

        std::cout << "here4" << std::endl;
        r_lo = t0 > r_lo ? t0 : r_lo;
        r_hi = t1 < r_hi ? t1 : r_hi;

        std::cout << "here5" << std::endl;
        if (r_hi <= r_lo) 
            return false;
    }
    return true;
};

#endif // BVH_H