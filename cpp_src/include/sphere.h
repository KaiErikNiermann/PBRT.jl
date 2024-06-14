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

class Sphere : public Hittable {
    public:
        std::vector<double> center;
        double radius;
        double r_squared;
        material mat;
        aabb bbox;
        bool hit(const ray_itval&, const HitRecord& rec) const;
};

set_usertype_enabled(Sphere);

#endif // SPHERE_H