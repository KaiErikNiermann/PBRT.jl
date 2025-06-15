#ifndef TRIANGLE_H
#define TRIANGLE_H
#include <functional>
#include <iostream>
#include <jluna.hpp>
#include <vector>

#include "hittable.h"

class Triangle : public Hittable {
public:
    std::vector<double> v1;
    std::vector<double> v2;
    std::vector<double> v3;
    int id;
    std::vector<std::set<std::vector<double>>> edges;
    std::shared_ptr<Material> mat;
    AABB bbox;

    bool hit(const Ray&, const Interval&, HitRecord&) const override;
};

set_usertype_enabled(Triangle);

#endif // !TRIANGLE_H