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
        double t;
        std::vector<double> p;
        std::vector<double> normal;
        bool front_face;
        material mat;
        double u;
        double v;
};

set_usertype_enabled(Hittable);
set_usertype_enabled(HitRecord);

#endif // HITTABLE_H
