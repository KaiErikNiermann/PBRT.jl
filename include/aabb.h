#ifndef AABB_H
#define AABB_H

#include <vector>
#include <iostream>
#include <functional>
#include <string>
#include <jluna.hpp>

class Ray {
    std::vector<double> at(double t) {
        return {
            origin[0] + t * direction[0], origin[1] + t * direction[1], origin[2] + t * direction[2]
        };
    }

public:
    std::vector<double> origin;
    std::vector<double> direction;

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

class RayData {
public:
    Interval interval;
    Ray ray;
    RayData()
        : interval(0.0, 0.0)
        , ray() { }
    RayData(Interval t, Ray r)
        : interval(t)
        , ray(r) { }
};

class AABB {
public:
    Interval x;
    Interval y;
    Interval z;
};

set_usertype_enabled(Ray);
set_usertype_enabled(Interval);
set_usertype_enabled(AABB);
set_usertype_enabled(RayData);

bool AABB_hit(const AABB& bbox, const Ray& ray, const Interval& ray_it);

#endif // AABB_H