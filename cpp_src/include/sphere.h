#ifndef SPHERE_H
#define SPHERE_H

#include <cmath>
#include <functional>
#include <array>
#include "aabb.h"
#include "hittable.h"
#include "material.h"
#include <jluna.hpp>

class Sphere {
    public:
        std::vector<double> center;
        double radius;
        double r_squared;
        material mat;
        aabb bbox;
};


std::function<jluna::Bool(const Sphere&, const ray_itval&, HitRecord&)> create_sphere_hit_func();

set_usertype_enabled(Sphere);

#endif // SPHERE_H