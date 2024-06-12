#ifndef HITTABLE_H
#define HITTABLE_H

#include <vector>
#include <jluna.hpp>
#include <array>
#include "aabb.h"
#include "material.h"

class Hittable {
};

class HittableList {
    public:
        std::vector<Hittable> objects;
        aabb bbox;
};

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

set_usertype_enabled(Hittable);
set_usertype_enabled(HitRecord);

#endif // HITTABLE_H
