#ifndef TRIANGLE_H
#define TRIANGLE_H
#include <vector>
#include <iostream>
#include <functional>

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

std::function<jluna::Bool(const triangle&, const ray&, const interval&, HitRecord&)> create_triangle_hit_func();

#endif // !TRIANGLE_H