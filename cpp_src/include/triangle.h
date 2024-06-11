#ifndef TRIANGLE_H
#define TRIANGLE_H
#include <vector>
#include <iostream>
#include <functional>
#include <jluna.hpp>

#include "material.h"
#include "aabb.h"
#include "hittable.h"

class triangle {
    public: 
        std::vector<double> A;
        std::vector<double> B;
        std::vector<double> C;
        int ident;
        std::vector<std::vector<std::vector<double>>> edges;
        material mat;
        aabb bbox;
};

class tri_hit_container {
    public: 
        triangle tri;
        ray r;
        interval t_interval;
        HitRecord& rec;
};

std::function<jluna::Bool(const triangle&, const ray_itval&, HitRecord&)> create_triangle_hit_func();

set_usertype_enabled(triangle);

#endif // !TRIANGLE_H