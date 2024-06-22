#include <jluna.hpp>
#include <vector>
#include <iostream>
#include "aabb.h"
#include "triangle.h"
#include "sphere.h"
#include "color.h"
#include "hittable.h"
#include "bvh.h"
#include "material.h"

template<typename B, typename... D>
bool assign_shared_ptr(std::shared_ptr<B>& val, B* in) {
    bool assigned = false;
    (..., [&]() -> void {
        if (auto d = dynamic_cast<D*>(in)) {
            val = std::shared_ptr<B>(std::make_shared<D>(*d));
            // std::cout << "assigned " << typeid(D).name() << std::endl;
            assigned = true;
        }
    }());
    return assigned;
} 

template <typename Ot, typename Ft, const char* name>
struct Property {
    using obj_t = const Ot;
    using field_t = Ft;
    static constexpr const char* get_name() { return name; }
    static std::function<Ft(Ot&)> getter;
    static std::function<void(Ot&, Ft)> setter;
};

template <typename Ot, typename Ft, const char* name>
std::function<Ft(Ot&)> Property<Ot, Ft, name>::getter;

template <typename Ot, typename Ft, const char* name>
std::function<void(Ot&, Ft)> Property<Ot, Ft, name>::setter;

#define var(name) static char name[] = #name; 

using namespace jluna;

template<typename... T>
struct tl {};

void register_type_properties() {
    // ray
    var(origin); var(direction);
    using ray_origin = Property<ray, std::vector<double>, origin>;
    using ray_direction = Property<ray, std::vector<double>, direction>;
    ray_origin::getter = [](ray& r) -> std::vector<double> { return r.origin; };
    ray_origin::setter = [](ray& r, const std::vector<double>& v) -> void { r.origin = v; };
    ray_direction::getter = [](ray& r) -> std::vector<double> { return r.direction; };
    ray_direction::setter = [](ray& r, const std::vector<double>& v) -> void { r.direction = v; };

    Usertype<ray>::initialize_type(
        tl<
            ray_origin,
            ray_direction
        >(),
        tl<>()
    );

    // interval
    var(lo); var(hi);
    using interval_lo = Property<interval, double, lo>;
    using interval_hi = Property<interval, double, hi>;
    interval_lo::getter = [](const interval& i) -> double { return i.lo; };
    interval_lo::setter = [](interval& i, double v) -> void { i.lo = v; };
    interval_hi::getter = [](const interval& i) -> double { return i.hi; };
    interval_hi::setter = [](interval& i, double v) -> void { i.hi = v; };

    Usertype<interval>::initialize_type(
        tl<
            interval_lo,
            interval_hi
        >(),
        tl<>()
    );

    // aabb
    var(x); var(y); var(z);
    using aabb_x = Property<aabb, interval, x>;
    using aabb_y = Property<aabb, interval, y>;
    using aabb_z = Property<aabb, interval, z>;
    aabb_x::getter = [](const aabb& b) -> interval { return b.x; };
    aabb_x::setter = [](aabb& b, const interval& i) -> void { b.x = i; };
    aabb_y::getter = [](const aabb& b) -> interval { return b.y; };
    aabb_y::setter = [](aabb& b, const interval& i) -> void { b.y = i; };
    aabb_z::getter = [](const aabb& b) -> interval { return b.z; };
    aabb_z::setter = [](aabb& b, const interval& i) -> void { b.z = i; };

    Usertype<aabb>::initialize_type(
        tl<
            aabb_x,
            aabb_y,
            aabb_z
        >(),
        tl<>()
    );

    // sphere
    var(A); var(B); var(C); var(id); var(edges); var(mat); var(bbox);
    using Triangle_A = Property<Triangle, std::vector<double>, A>;
    using Triangle_B = Property<Triangle, std::vector<double>, B>;
    using Triangle_C = Property<Triangle, std::vector<double>, C>;
    using Triangle_id = Property<Triangle, int, id>;
    using Triangle_edges = Property<Triangle, std::vector<std::set<std::vector<double>>>, edges>;
    using Triangle_mat = Property<Triangle, material, mat>;
    using Triangle_bbox = Property<Triangle, aabb, bbox>;

    Triangle_A::getter = [](Triangle& t) -> std::vector<double> { return t.A; };
    Triangle_A::setter = [](Triangle& t, const std::vector<double>& v) -> void { t.A = v; };
    Triangle_B::getter = [](Triangle& t) -> std::vector<double> { return t.B; };
    Triangle_B::setter = [](Triangle& t, const std::vector<double>& v) -> void { t.B = v; };
    Triangle_C::getter = [](Triangle& t) -> std::vector<double> { return t.C; };
    Triangle_C::setter = [](Triangle& t, const std::vector<double>& v) -> void { t.C = v; };
    Triangle_id::getter = [](Triangle& t) -> int { return t.id; };
    Triangle_id::setter = [](Triangle& t, int v) -> void { t.id = v; };
    Triangle_edges::getter = [](Triangle& t) -> std::vector<std::set<std::vector<double>>>{ return t.edges; };
    Triangle_edges::setter = [](Triangle& t, const std::vector<std::set<std::vector<double>>>& v) -> void { t.edges = v; };
    Triangle_mat::getter = [](Triangle& t) -> material { return t.mat; };
    Triangle_mat::setter = [](Triangle& t, const material& m) -> void { t.mat = m; };
    Triangle_bbox::getter = [](Triangle& t) -> aabb { return t.bbox; };
    Triangle_bbox::setter = [](Triangle& t, const aabb& b) -> void { t.bbox = b; };

    Usertype<Triangle>::initialize_type(
        tl<
            Triangle_A,
            Triangle_B,
            Triangle_C,
            Triangle_id,
            Triangle_edges,
            Triangle_mat,
            Triangle_bbox
        >(),
        tl<>()
    );

    // sphere
    var(center); var(radius); var(r_squared); 
    using sphere_center = Property<sphere, std::vector<double>, center>;
    using sphere_radius = Property<sphere, double, radius>;
    using sphere_r_squared = Property<sphere, double, r_squared>;
    using sphere_mat = Property<sphere, material, mat>;
    using sphere_bbox = Property<sphere, aabb, bbox>;

    sphere_center::getter = [](sphere& s) -> std::vector<double> { return s.center; };
    sphere_center::setter = [](sphere& s, const std::vector<double>& v) -> void { s.center = v; };
    sphere_radius::getter = [](sphere& s) -> double { return s.radius; };
    sphere_radius::setter = [](sphere& s, double v) -> void { s.radius = v; };
    sphere_r_squared::getter = [](sphere& s) -> double { return s.r_squared; };
    sphere_r_squared::setter = [](sphere& s, double v) -> void { s.r_squared = v; };
    sphere_mat::getter = [](sphere& s) -> material { return s.mat; };
    sphere_mat::setter = [](sphere& s, const material& m) -> void { s.mat = m; };
    sphere_bbox::getter = [](sphere& s) -> aabb { return s.bbox; };
    sphere_bbox::setter = [](sphere& s, const aabb& b) -> void { s.bbox = b; };
    
    Usertype<sphere>::initialize_type(
        tl<
            sphere_center,
            sphere_radius,
            sphere_r_squared,
            sphere_mat,
            sphere_bbox
        >(),
        tl<>()
    );

    // HitRecord
    var(p); var(normal); var(u); var(v); var(t);
    using hitrecord_t = Property<HitRecord, double, t>;
    using hitrecord_p = Property<HitRecord, std::vector<double>, p>;
    using hitrecord_normal = Property<HitRecord, std::vector<double>, normal>;
    using hitrecord_mat = Property<HitRecord, material, mat>;
    using hitrecord_u = Property<HitRecord, double, u>;
    using hitrecord_v = Property<HitRecord, double, v>;

    hitrecord_t::getter = [](HitRecord& rec) -> double { return rec.t; };
    hitrecord_t::setter = [](HitRecord& rec, double v) -> void { rec.t = v; };
    hitrecord_p::getter = [](HitRecord& rec) -> std::vector<double> { return rec.p; };
    hitrecord_p::setter = [](HitRecord& rec, const std::vector<double>& v) -> void { rec.p = v; };
    hitrecord_normal::getter = [](HitRecord& rec) -> std::vector<double> { return rec.normal; };
    hitrecord_normal::setter = [](HitRecord& rec, const std::vector<double>& v) -> void { rec.normal = v; };
    hitrecord_mat::getter = [](HitRecord& rec) -> material { return rec.mat; };
    hitrecord_mat::setter = [](HitRecord& rec, const material& m) -> void { rec.mat = m; };
    hitrecord_u::getter = [](HitRecord& rec) -> double { return rec.u; };
    hitrecord_u::setter = [](HitRecord& rec, double v) -> void { rec.u = v; };
    hitrecord_v::getter = [](HitRecord& rec) -> double { return rec.v; };
    hitrecord_v::setter = [](HitRecord& rec, double v) -> void { rec.v = v; };

    Usertype<HitRecord>::initialize_type(
        tl<
            hitrecord_t,
            hitrecord_p,
            hitrecord_normal,
            hitrecord_mat,
            hitrecord_u,
            hitrecord_v
        >(),
        tl<>()
    );

    // color
    var(c_r); var(g); var(b);
    using color_r = Property<color, double, c_r>;
    using color_g = Property<color, double, g>;
    using color_b = Property<color, double, b>;

    color_r::getter = [](color& c) -> double { return c.r; };
    color_r::setter = [](color& c, double v) -> void { c.r = v; };
    color_g::getter = [](color& c) -> double { return c.g; };
    color_g::setter = [](color& c, double v) -> void { c.g = v; };
    color_b::getter = [](color& c) -> double { return c.b; };
    color_b::setter = [](color& c, double v) -> void { c.b = v; };

    Usertype<color>::initialize_type(
        tl<
            color_r,
            color_g,
            color_b
        >(),
        tl<>()
    );

    // ray_itval
    var(r); 
    using ray_itval_r = Property<ray_itval, ray, r>;
    using ray_itval_t = Property<ray_itval, interval, t>;
    
    ray_itval_r::getter = [](ray_itval& rt) -> ray { return rt.r; };
    ray_itval_r::setter = [](ray_itval& rt, const ray& r) -> void { rt.r = r; };
    ray_itval_t::getter = [](ray_itval& rt) -> interval { return rt.t; };
    ray_itval_t::setter = [](ray_itval& rt, const interval& i) -> void { rt.t = i; };

    Usertype<ray_itval>::initialize_type(
        tl<
            ray_itval_r,
            ray_itval_t
        >(),
        tl<>()
    );

    // bvh_node
    var(left); var(right); 
    using bvh_node_left = Property<bvh_node, Hittable*, left>;
    using bvh_node_right = Property<bvh_node, Hittable*, right>;
    using bvh_node_bbox = Property<bvh_node, aabb, bbox>;

    bvh_node_left::getter = [](bvh_node& b) -> Hittable* { return b.left.get(); };
    bvh_node_left::setter = [](bvh_node& b, Hittable* h) -> void { 
        if (!assign_shared_ptr<Hittable, Triangle, sphere, bvh_node>(b.left, h)) {
            // std::cout << "could not assign" << std::endl;
        }
    };
    bvh_node_right::getter = [](bvh_node& b) -> Hittable* { return b.right.get(); };
    bvh_node_right::setter = [](bvh_node& b, Hittable* h) -> void { 
        if (!assign_shared_ptr<Hittable, Triangle, sphere, bvh_node>(b.right, h)) {
            // std::cout << "could not assign" << std::endl;
        }
    };
    bvh_node_bbox::getter = [](bvh_node& b) -> aabb { return b.bbox; };
    bvh_node_bbox::setter = [](bvh_node& b, const aabb& a) -> void { b.bbox = a; };

    Usertype<bvh_node>::initialize_type(
        tl<
            bvh_node_left,
            bvh_node_right,
            bvh_node_bbox
        >(),
        tl<Triangle, sphere, bvh_node>()
    );
}

void implement_types() {
    Usertype<aabb>::implement();
    Usertype<interval>::implement();
    Usertype<ray>::implement();
    Usertype<sphere>::implement();
    Usertype<sphere*>::implement();
    Usertype<Triangle>::implement();
    Usertype<Triangle*>::implement();
    Usertype<HitRecord>::implement();
    Usertype<color>::implement();
    Usertype<ray_itval>::implement();
    Usertype<Hittable>::implement();
    Usertype<Hittable*>::implement();
    Usertype<bvh_node>::implement();
    Usertype<bvh_node*>::implement();
}

void register_types() {
    register_type_properties();
    implement_types();
}