#ifndef SPHERE_H
#define SPHERE_H

#include <cmath>
#include <functional>
#include <array>
#include <jluna.hpp>
#include "aabb.h"
#include "hittable.h"
#include "material.h"
#include "math_util.h"

class Sphere {
    public:
        std::vector<double> center;
        double radius;
        double r_squared;
        material mat;
        aabb bbox;
};


std::function<jluna::Bool(const Sphere&, const ray_itval&, const HitRecord&)> create_sphere_hit_func();

set_usertype_enabled(Sphere);

#endif // SPHERE_H