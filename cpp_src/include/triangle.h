#ifndef TRIANGLE_H
#define TRIANGLE_H
#include <functional>
#include <iostream>
#include <jluna.hpp>
#include <vector>

#include "hittable.h"

class Triangle : public Hittable {
   public:
    std::vector<double> A;
    std::vector<double> B;
    std::vector<double> C;
    int id;
    std::vector<std::set<std::vector<double>>> edges;
    std::shared_ptr<material> mat;
    aabb bbox;
    bool hit(const ray_itval&, HitRecord* rec) const override;
};

class tri_hit_container {
   public:
    Triangle tri;
    ray r;
    interval t_interval;
    HitRecord& rec;
};

bool hit_triangle(const Triangle& tri, const ray_itval& rt, const HitRecord& rec);

set_usertype_enabled(Triangle);
set_usertype_enabled(Triangle*);

#endif  // !TRIANGLE_H