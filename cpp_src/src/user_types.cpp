#include <jluna.hpp>
#include <vector>
#include <iostream>
#include "aabb.h"
#include "triangle.h"
#include "sphere.h"
#include "color.h"
#include "hittable.h"
#include "material.h"

using namespace jluna;

void register_type_properties() {
    // ray
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

    // interval
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

    // aabb
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

    // sphere 
    Usertype<Sphere>::add_property<std::vector<double>>(
        "center",
        [](const Sphere& s) -> std::vector<double> { return s.center; },
        [](Sphere& s, const std::vector<double>& v) -> void { s.center = v; }
    );

    Usertype<Sphere>::add_property<double>(
        "radius",
        [](const Sphere& s) -> double { return s.radius; },
        [](Sphere& s, double v) -> void { s.radius = v; }
    );

    Usertype<Sphere>::add_property<double>(
        "r_squared",
        [](const Sphere& s) -> double { return s.r_squared; },
        [](Sphere& s, double v) -> void { s.r_squared = v; }
    );

    Usertype<Sphere>::add_property<material>(
        "mat",
        [](const Sphere& s) -> material { return s.mat; },
        [](Sphere& s, const material& m) -> void { s.mat = m; }
    );

    Usertype<Sphere>::add_property<aabb>(
        "bbox",
        [](const Sphere& s) -> aabb { return s.bbox; },
        [](Sphere& s, const aabb& b) -> void { s.bbox = b; }
    );

    // triangle
    Usertype<triangle>::add_property<std::vector<double>>(
        "A",
        [](const triangle& t) -> std::vector<double> { return t.A; },
        [](triangle& t, const std::vector<double>& v) -> void { t.A = v; }
    );

    Usertype<triangle>::add_property<std::vector<double>>(
        "B",
        [](const triangle& t) -> std::vector<double> { return t.B; },
        [](triangle& t, const std::vector<double>& v) -> void { t.B = v; }
    );

    Usertype<triangle>::add_property<std::vector<double>>(
        "C",
        [](const triangle& t) -> std::vector<double> { return t.C; },
        [](triangle& t, const std::vector<double>& v) -> void { t.C = v; }
    );

    Usertype<triangle>::add_property<int>(
        "id",
        [](const triangle& t) -> int { return t.ident; },
        [](triangle& t, int v) -> void { t.ident = v; }
    );

    Usertype<triangle>::add_property<std::vector<std::set<std::vector<double>>>>(
        "edges",
        [](const triangle& t) -> std::vector<std::set<std::vector<double>>> { return t.edges; },
        [](triangle& t, const std::vector<std::set<std::vector<double>>>& v) -> void { t.edges = v; }
    );

    Usertype<triangle>::add_property<material>(
        "mat",
        [](const triangle& t) -> material { return t.mat; },
        [](triangle& t, const material& m) -> void { t.mat = m; }
    );

    Usertype<triangle>::add_property<aabb>(
        "bbox",
        [](const triangle& t) -> aabb { return t.bbox; },
        [](triangle& t, const aabb& b) -> void { t.bbox = b; }
    );

    // hittable
    Usertype<HittableList>::add_property<std::vector<Hittable>>(
        "objects",
        [](const HittableList& hl) -> std::vector<Hittable> { return hl.objects; },
        [](HittableList& hl, const std::vector<Hittable>& v) -> void { hl.objects = v; }
    );

    Usertype<HittableList>::add_property<aabb>(
        "bbox",
        [](const HittableList& hl) -> aabb { return hl.bbox; },
        [](HittableList& hl, const aabb& b) -> void { hl.bbox = b; }
    );

    Usertype<HitRecord>::add_property<double>(
        "t",
        [](const HitRecord& hr) -> double { return hr.t; },
        [](HitRecord& hr, double v) -> void { hr.t = v; }
    );

    Usertype<HitRecord>::add_property<std::vector<double>>(
        "p",
        [](const HitRecord& hr) -> std::vector<double> { return hr.p; },
        [](HitRecord& hr, const std::vector<double>& v) -> void { hr.p = v; }
    );

    Usertype<HitRecord>::add_property<std::vector<double>>(
        "normal",
        [](const HitRecord& hr) -> std::vector<double> { return hr.normal; },
        [](HitRecord& hr, const std::vector<double>& v) -> void { hr.normal = v; }
    );

    Usertype<HitRecord>::add_property<bool>(
        "front_face",
        [](const HitRecord& hr) -> bool { return hr.front_face; },
        [](HitRecord& hr, bool v) -> void { hr.front_face = v; }
    );

    Usertype<HitRecord>::add_property<material>(
        "mat",
        [](const HitRecord& hr) -> material { return hr.mat; },
        [](HitRecord& hr, const material& m) -> void { hr.mat = m; }
    );

    Usertype<HitRecord>::add_property<double>(
        "u",
        [](const HitRecord& hr) -> double { return hr.u; },
        [](HitRecord& hr, double v) -> void { hr.u = v; }
    );

    Usertype<HitRecord>::add_property<double>(
        "v",
        [](const HitRecord& hr) -> double { return hr.v; },
        [](HitRecord& hr, double v) -> void { hr.v = v; }
    );

    Usertype<color>::add_property<double>(
        "r",
        [](const color& c) -> double { return c.r; },
        [](color& c, double v) -> void { c.r = v; }
    );

    Usertype<color>::add_property<double>(
        "g",
        [](const color& c) -> double { return c.g; },
        [](color& c, double v) -> void { c.g = v; }
    );

    Usertype<color>::add_property<double>(
        "b",
        [](const color& c) -> double { return c.b; },
        [](color& c, double v) -> void { c.b = v; }
    );

    Usertype<ray_itval>::add_property<ray>(
        "r",
        [](const ray_itval& rt) -> ray { return rt.r; },
        [](ray_itval& rt, const ray& r) -> void { rt.r = r; }
    );

    Usertype<ray_itval>::add_property<interval>(
        "t",
        [](const ray_itval& rt) -> interval { return rt.t; },
        [](ray_itval& rt, const interval& i) -> void { rt.t = i; }
    );
}

void implement_types() {
    Usertype<aabb>::implement();
    Usertype<interval>::implement();
    Usertype<ray>::implement();
    // Usertype<Sphere>::implement();
    // Usertype<triangle>::implement();
    // Usertype<HittableList>::implement();
    // Usertype<HitRecord>::implement();
    // Usertype<color>::implement();
    // Usertype<ray_itval>::implement();
}

void register_types() {
    register_type_properties();
    implement_types();
}