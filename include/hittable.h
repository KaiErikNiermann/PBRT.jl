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
    std::array<double, 3> p;
    std::array<double, 3> normal;
    std::shared_ptr<Material> mat;
    double t;
    bool front_face;
    double u;
    double v;
    bool hit;

    friend std::ostream& operator<<(std::ostream& os, const HitRecord& hr) {
        os << "HitRecord(p: [ ";
        for (const auto& val : hr.p) {
            os << val << " ";
        }
        os << "], normal: [ ";
        for (auto& val : hr.mat.get()->get_albedo().data) {
            os << val << " ";
        } 
        for (const auto& val : hr.normal) {
            os << val << " ";
        }

        os << "], t: " << hr.t << ", front_face: " << hr.front_face << ", u: " << hr.u
           << ", v: " << hr.v << ", hit: " << hr.hit << ")";
        return os;
    }
};

class Hittable {
public:
    Hittable()                                                                          = default;
    virtual ~Hittable()                                                                 = default;
    virtual bool hit(const Ray& ray, const Interval& interval, HitRecord& record) const = 0;
};

set_usertype_enabled(Hittable);
set_usertype_enabled(HitRecord);

#endif // HITTABLE_H
