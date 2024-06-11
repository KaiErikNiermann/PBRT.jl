#include <stdlib.h>
#include <jluna.hpp>
#include <string>
#include <functional>

#include "bvh.h"
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
    initialize();
    inti_pbrt();

    register_types();

    Main.create_or_assign("hit_aabb", as_julia_function<bool(aabb, ray, interval)>(create_hit_function()));

    Main.safe_eval(funcs::hit_aabb);

    auto module = Main["PBRT"];
    auto example_render = module["example_render"];

    example_render();

    return 0;
}