#ifndef AABB_H
#define AABB_H

#include <vector>
#include <iostream>
#include <functional>
#include <string>
#include <jluna.hpp>

class Ray {
    std::array<double, 3> at(double t) {
        return {
            origin[0] + t * direction[0], origin[1] + t * direction[1], origin[2] + t * direction[2]
        };
    }

public:
    std::array<double, 3> origin;
    std::array<double, 3> direction;

    Ray()
        : origin({0.0, 0.0, 0.0})
        , direction({0.0, 0.0, 0.0}) { }
};

class Interval {
public:
    double lo;
    double hi;

    Interval()
        : lo(0.0)
        , hi(0.0) { }

    Interval(double lo, double hi)
        : lo(lo)
        , hi(hi) { }
};

class RayPath {
public:
    Interval interval;
    Ray ray;
    RayPath()
        : interval(0.0, 0.0)
        , ray() { }
    RayPath(Interval t, Ray r)
        : interval(t)
        , ray(r) { }
};

class AABB {
public:
    Interval x;
    Interval y;
    Interval z;
};

bool hit_bbox(const AABB& bbox, const Ray& ray, const Interval& interval);

set_usertype_enabled(Ray);
set_usertype_enabled(Interval);
set_usertype_enabled(AABB);
set_usertype_enabled(RayPath);


#endif // AABB_H