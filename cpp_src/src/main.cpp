#include <stdlib.h>
#include <jluna.hpp>
#include <string>
#include <functional>

#include "aabb.h"
#include "sphere.h"
#include "triangle.h"
#include "user_types.h"
#include "funcs.inl"

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

    // Redefine hit functions 
    Main.create_or_assign("hit_aabb", as_julia_function<bool(aabb, ray, interval)>(create_aabb_hit_func()));
    Main.create_or_assign("hit_triangle", as_julia_function<bool(const triangle&, const ray_itval&, HitRecord&)>(create_triangle_hit_func()));
    // Main.create_or_assign("hit_sphere", as_julia_function<jluna::Bool(Sphere, ray_itval, HitRecord)>(create_sphere_hit_func()));

    Main.safe_eval(funcs::hit_aabb);
    Main.safe_eval(funcs::hit_triangle);
    // Main.safe_eval(funcs::hit_sphere);

    auto module = Main["PBRT"];
    auto example_render = module["example_render"];

    example_render();

    return 0;
}