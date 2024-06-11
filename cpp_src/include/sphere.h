#ifndef SPHERE_H
#define SPHERE_H

#include <cmath>
#include <array>
#include "aabb.h"
#include "hittable.h"
#include "material.h"

class Sphere : public Hittable {
    public:
        std::vector<double> center;
        double radius;
        double r_squared;
        material mat;
        aabb bbox;
};

std::function<jluna::Bool(const Sphere&, const ray&, const interval&, HitRecord&)> create_sphere_hit_func();

#endif // SPHERE_H