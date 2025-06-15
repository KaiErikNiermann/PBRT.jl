#ifndef sphere_H
#define sphere_H

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
        std::shared_ptr<Material> mat;
        AABB bbox;
        bool hit(const Ray&, const Interval&, HitRecord&) const override;
};

set_usertype_enabled(Sphere);

#endif // sphere_H