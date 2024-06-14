#ifndef HITTABLE_H
#define HITTABLE_H

#include <vector>
#include <jluna.hpp>
#include <array>
#include "aabb.h"
#include "material.h"
#include "math_util.h"

class HitRecord {
    public:
        mutable double t;
        mutable std::vector<double> p;
        mutable std::vector<double> normal;
        mutable bool front_face;
        mutable material mat;
        mutable double u;
        mutable double v;
};

class Hittable {
    public: 
        Hittable() = default;
        virtual ~Hittable() = default;
};

std::vector<double> scale(std::vector<double> v, double s);

set_usertype_enabled(Hittable);
set_usertype_enabled(HitRecord);

#endif // HITTABLE_H
