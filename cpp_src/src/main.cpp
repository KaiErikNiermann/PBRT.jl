#include <stdlib.h>

#include <functional>
#include <jluna.hpp>
#include <string>

#include "hittable.h"
#include "aabb.h"
#include "funcs.inl"
#include "sphere.h"
#include "triangle.h"
#include "bvh.h"
#include "abs_hit.h"
#include "user_types.h"

using namespace jluna;

void inti_pbrt() {
    Main.safe_eval("using Pkg");
    Main.safe_eval("Pkg.activate(\"../\")");
    Main.safe_eval("Pkg.instantiate()");
    Main.safe_eval("Pkg.resolve()");
    Main.safe_eval("using PBRT");
}

int main() {
    // Initalize jluna API and jl backing
    initialize();
    inti_pbrt();

    // Register types
    register_types();
    
    jluna::unsafe::Value* hit_aabb_f = as_julia_function<bool(aabb, ray, interval)>(
        [](const aabb& box, const ray& r, const interval& ray_t) -> bool {
            return hit_aabb(box, r, ray_t);
        }
    );
    jluna::unsafe::Value* hit_triangle_f = as_julia_function<bool(triangle, ray_itval, HitRecord)>(
        [](const triangle& tri, const ray_itval& r, const HitRecord& rec) -> bool {
            return hit_triangle(tri, r, rec);
        }
    );
    jluna::unsafe::Value* hit_sphere_f = as_julia_function<bool(Sphere, ray_itval, HitRecord)>(
        [](const Sphere& s, const ray_itval& r, const HitRecord& rec) -> bool {
            return hit_sphere(s, r, rec);
        }
    );
    jluna::unsafe::Value* hit_bvh_f = as_julia_function<bool(bvh_node, ray_itval, HitRecord)>(
        [](const bvh_node& bvh, const ray_itval& r, const HitRecord& rec) -> bool {
            return hit_bvh(bvh, r, rec);
        }
    );
    jluna::unsafe::Value* hit_f = as_julia_function<hit_lambda(Hittable)>(
        [](const Hittable& h) -> hit_lambda {
            return hit(h);
        }
    );

    // Redefine hit functions
    Main.create_or_assign("hit_aabb", hit_aabb_f);
    Main.create_or_assign("hit_triangle", hit_triangle_f);
    Main.create_or_assign("hit_sphere", hit_sphere_f);
    Main.create_or_assign("hit_bvh", hit_bvh_f);


    Main.safe_eval(funcs::hit_aabb);
    Main.safe_eval(funcs::hit_triangle);
    Main.safe_eval(funcs::hit_sphere);
    Main.safe_eval(funcs::hit_bvh);

    auto module = Main["PBRT"];
    auto example_render = module["example_render"];

    example_render("../scenes/cottage_obj.obj");

    return 0;
}