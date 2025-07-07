#ifndef TRIANGLE_H
#define TRIANGLE_H
#include <functional>
#include <iostream>
#include <jluna.hpp>
#include <vector>

#include "hittable.h"

class Triangle : public Hittable {
public:
    std::array<double, 3> v1{0.0, 0.0, 0.0};
    std::array<double, 3> v2{0.0, 0.0, 0.0};
    std::array<double, 3> v3{0.0, 0.0, 0.0};
    std::shared_ptr<Material> mat;
    AABB bbox;

    bool hit(const Ray&, const Interval&, HitRecord&) const override;
};

set_usertype_enabled(Triangle);

#endif // !TRIANGLE_H