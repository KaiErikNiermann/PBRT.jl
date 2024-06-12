#include <stdlib.h>

#include <functional>
#include <jluna.hpp>
#include <string>

#include "aabb.h"
#include "funcs.inl"
#include "sphere.h"
#include "triangle.h"
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

    jluna::unsafe::Value* hit_aabb_f = as_julia_function<bool(aabb, ray, interval)>(create_aabb_hit_func());
    jluna::unsafe::Value* hit_triangle_f = as_julia_function<bool(triangle, ray_itval, HitRecord)>(create_triangle_hit_func());
    jluna::unsafe::Value* hit_sphere_f = as_julia_function<bool(Sphere, ray_itval, HitRecord)>(create_sphere_hit_func());

    // Redefine hit functions
    Main.create_or_assign("hit_aabb", hit_aabb_f);
    Main.create_or_assign("hit_triangle", hit_triangle_f);
    Main.create_or_assign("hit_sphere", hit_sphere_f);

    Main.safe_eval(funcs::hit_aabb);
    Main.safe_eval(funcs::hit_triangle);
    Main.safe_eval(funcs::hit_sphere);

    auto module = Main["PBRT"];
    auto example_render = module["example_render"];

    example_render();

    return 0;
}