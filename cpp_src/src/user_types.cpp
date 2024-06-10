#include <jluna.hpp>
#include "bvh.h"

using namespace jluna;

void register_type_properties() {
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
}

void implement_types() {
    Usertype<aabb>::implement();
    Usertype<interval>::implement();
    Usertype<ray>::implement();
}

void register_types() {
    register_type_properties();
    implement_types();
}