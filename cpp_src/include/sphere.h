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

class sphere : public Hittable {
    public:
        std::vector<double> center;
        double radius;
        double r_squared;
        std::shared_ptr<material> mat;
        aabb bbox;
        bool hit(const ray_itval&, HitRecord* rec) const override;
};

set_usertype_enabled(sphere);
set_usertype_enabled(sphere*);

#endif // sphere_H