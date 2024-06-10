#include <stdlib.h>
#include <jluna.hpp>
#include <string>
#include <functional>

#include "bvh.h"

using namespace jluna;

int main() {
    initialize();

    Main.safe_eval("using Pkg");
    Main.safe_eval("Pkg.activate(\"../\")");
    Main.safe_eval("Pkg.instantiate()");
    Main.safe_eval("Pkg.resolve()");
    Main.safe_eval("using PBRT");

    Usertype<ray>::add_property<std::vector<double>>(
        "origin",
        [](ray& r) -> std::vector<double> { return r.origin; },
        [](ray& r, const std::vector<double>& v) -> void { r.origin = v; }
    );

    Usertype<ray>::add_property<std::vector<double>>(
        "direction",
        [](ray& r) -> std::vector<double> { return r.direction; },
        [](ray& r, const std::vector<double>& v) { r.direction = v; }
    );

    Usertype<ray>::implement();

    Usertype<interval>::add_property<double>(
        "lo",
        [](const interval& i) -> double { return i.lo; },
        [](interval& i, double v) -> void { i.lo = v; }
    );

    Usertype<interval>::add_property<double>(
        "hi",
        [](const interval& i) -> double { return i.hi; },
        [](interval& i, double v) -> void { i.hi = v; }
    );

    Usertype<interval>::implement();

    Usertype<aabb>::add_property<interval>(
        "x",
        [](const aabb& b) -> interval { return b.x; },
        [](aabb& b, const interval& i) -> void { b.x = i; }
    );

    Usertype<aabb>::add_property<interval>(
        "y",
        [](const aabb& b) -> interval { return b.y; },
        [](aabb& b, const interval& i) -> void { b.y = i; }
    );

    Usertype<aabb>::add_property<interval>(
        "z",
        [](const aabb& b) -> interval { return b.z; },
        [](aabb& b, const interval& i) -> void { b.z = i; }
    );

    Usertype<aabb>::implement();

    Main.create_or_assign("hit", as_julia_function<bool(aabb, ray, interval)>(hit));

    const char *to_replace = 
        "function PBRT.hit(bbox::PBRT.aabb, r::PBRT.ray, ray_t::PBRT.interval)::Bool\n"
        "    return Bool(hit(bbox, r, ray_t))\n" 
        "end";

    Main.safe_eval(to_replace);

    auto module = Main["PBRT"];
    auto example_render = module["example_render"];

    example_render();

    return 0;
}
