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
        mutable std::vector<double> p;
        mutable std::vector<double> normal;
        mutable std::shared_ptr<material> mat;
        mutable double t;
        mutable bool front_face;
        mutable double u;
        mutable double v;
        mutable bool hit;
};

class Hittable {
    public: 
        Hittable() = default;
        virtual ~Hittable() = default;
        virtual bool hit(const ray_itval& rt, HitRecord* rec) const = 0;
};

std::vector<double> scale(std::vector<double> v, double s);

set_usertype_enabled(Hittable);
set_usertype_enabled(Hittable*);
set_usertype_enabled(HitRecord);
set_usertype_enabled(HitRecord*);

#endif // HITTABLE_H
