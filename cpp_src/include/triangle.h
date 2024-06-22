#ifndef TRIANGLE_H
#define TRIANGLE_H
#include <functional>
#include <iostream>
#include <jluna.hpp>
#include <vector>

#include "hittable.h"

class triangle : public Hittable {
   public:
    std::vector<double> A;
    std::vector<double> B;
    std::vector<double> C;
    int ident;
    std::vector<std::set<std::vector<double>>> edges;
    material mat;
    aabb bbox;
    bool hit(const ray_itval&, const HitRecord& rec) const;
};

class tri_hit_container {
   public:
    triangle tri;
    ray r;
    interval t_interval;
    HitRecord& rec;
};

bool hit_triangle(const triangle& tri, const ray_itval& rt, const HitRecord& rec);

set_usertype_enabled(triangle);
set_usertype_enabled(triangle*);

#endif  // !TRIANGLE_H