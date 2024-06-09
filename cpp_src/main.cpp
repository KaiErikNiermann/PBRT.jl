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

    Usertype<interval<double>>::add_property<double>(
        "lo",
        [](const interval<double>& i) -> double { return i.lo; },
        [](interval<double>& i, double v) -> void { i.lo = v; }
    );

    Usertype<interval<double>>::add_property<double>(
        "hi",
        [](const interval<double>& i) -> double { return i.hi; },
        [](interval<double>& i, double v) -> void { i.hi = v; }
    );

    Usertype<interval<double>>::add_property<double>(
        "hi",
        [](const interval<double>& i) -> double { return i.hi; },
        [](interval<double>& i, double v) -> void { i.hi = v; }
    );

    Usertype<interval<double>>::implement();

    Usertype<aabb>::add_property<interval<double>>(
        "x",
        [](const aabb& b) -> interval<double> { return b.x; },
        [](aabb& b, const interval<double>& i) -> void { b.x = i; }
    );

    Usertype<aabb>::add_property<interval<double>>(
        "y",
        [](const aabb& b) -> interval<double> { return b.y; },
        [](aabb& b, const interval<double>& i) -> void { b.y = i; }
    );

    Usertype<aabb>::add_property<interval<double>>(
        "z",
        [](const aabb& b) -> interval<double> { return b.z; },
        [](aabb& b, const interval<double>& i) -> void { b.z = i; }
    );

    Usertype<aabb>::implement();

    auto hit = [](const aabb&, const ray& r, const interval<double>& ray_t) -> jluna::Bool {
        return true;
    };

    // Main.create_or_assign("hit", as_julia_function<bool()>(hit));
    Main.create_or_assign("hit", as_julia_function<bool(aabb, ray, interval<double>)>(hit));

    const char *to_replace = 
        "function PBRT.hit(bbox::PBRT.aabb, r::PBRT.ray, ray_t::PBRT.interval)::Bool\n"
        "    println('a')\n"
        "    res = Bool(hit())\n"
        // "    res = Bool(hit(bbox, r, ray_t))\n"
        "    println('b')\n"    
        "    return res\n" 
        "end";

    Main.safe_eval(to_replace);

    auto module = Main["PBRT"];
    auto example_render = module["example_render"];

    example_render();

    return 0;
}
