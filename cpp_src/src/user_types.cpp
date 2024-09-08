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

    var(albedo); 
    using material_albedo = Property<lambertian, color, albedo>;

    material_albedo::getter = [](lambertian& l) -> color { return l.albedo; };
    material_albedo::setter = [](lambertian& l, const color& v) -> void { l.albedo = v; };

    Usertype<lambertian>::initialize_type(
        tl<
            material_albedo
        >(),
        tl<>()
    );

    // triangle
    var(A); var(B); var(C); var(id); var(edges); var(mat); var(bbox);
    using Triangle_A = Property<Triangle, std::vector<double>, A>;
    using Triangle_B = Property<Triangle, std::vector<double>, B>;
    using Triangle_C = Property<Triangle, std::vector<double>, C>;
    using Triangle_id = Property<Triangle, int, id>;
    using Triangle_edges = Property<Triangle, std::vector<std::set<std::vector<double>>>, edges>;
    using Triangle_mat = Property<Triangle, material*, mat>;
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
    Triangle_mat::getter = [](Triangle& t) -> material* { return t.mat.get(); };
    Triangle_mat::setter = [](Triangle& t, material* m) -> void { 
        if (!assign_shared_ptr<material, lambertian>(t.mat, m)) {
            // std::cout << "could not assign" << std::endl;
        }
    };
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
        tl<lambertian>()
    );

    // sphere
    var(center); var(radius); var(r_squared); 
    using sphere_center = Property<sphere, std::vector<double>, center>;
    using sphere_radius = Property<sphere, double, radius>;
    using sphere_r_squared = Property<sphere, double, r_squared>;
    using sphere_mat = Property<sphere, material*, mat>;
    using sphere_bbox = Property<sphere, aabb, bbox>;

    sphere_center::getter = [](sphere& s) -> std::vector<double> { return s.center; };
    sphere_center::setter = [](sphere& s, const std::vector<double>& v) -> void { s.center = v; };
    sphere_radius::getter = [](sphere& s) -> double { return s.radius; };
    sphere_radius::setter = [](sphere& s, double v) -> void { s.radius = v; };
    sphere_r_squared::getter = [](sphere& s) -> double { return s.r_squared; };
    sphere_r_squared::setter = [](sphere& s, double v) -> void { s.r_squared = v; };
    sphere_mat::getter = [](sphere& s) -> material* { return s.mat.get(); };
    sphere_mat::setter = [](sphere& s, material* m) -> void { 
        if (!assign_shared_ptr<material, lambertian>(s.mat, m)) {
            // std::cout << "could not assign" << std::endl;
        }
    };
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
        tl<lambertian>()
    );

    // HitRecord
    var(p); var(normal); var(u); var(v); var(t); var(hit); var(front_face); 
    using hitrecord_t = Property<HitRecord, double, t>;
    using hitrecord_p = Property<HitRecord, std::vector<double>, p>;
    using hitrecord_normal = Property<HitRecord, std::vector<double>, normal>;
    using hitrecord_mat = Property<HitRecord, material*, mat>;
    using hitrecord_u = Property<HitRecord, double, u>;
    using hitrecord_v = Property<HitRecord, double, v>;
    using hitrecord_hit = Property<HitRecord, bool, hit>;
    using hitrecord_front_face = Property<HitRecord, bool, front_face>;

    hitrecord_t::getter = [](HitRecord& rec) -> double { return rec.t; };
    hitrecord_t::setter = [](HitRecord& rec, double v) -> void { rec.t = v; };
    hitrecord_p::getter = [](HitRecord& rec) -> std::vector<double> { return rec.p; };
    hitrecord_p::setter = [](HitRecord& rec, const std::vector<double>& v) -> void { rec.p = v; };
    hitrecord_normal::getter = [](HitRecord& rec) -> std::vector<double> { return rec.normal; };
    hitrecord_normal::setter = [](HitRecord& rec, const std::vector<double>& v) -> void { rec.normal = v; };
    hitrecord_mat::getter = [](HitRecord& rec) -> material* { return rec.mat.get(); };
    hitrecord_mat::setter = [](HitRecord& rec, material* m) -> void { 
        if (!assign_shared_ptr<material, lambertian>(rec.mat, m)) {
            // std::cout << "could not assign" << std::endl;
        }
    };
    hitrecord_u::getter = [](HitRecord& rec) -> double { return rec.u; };
    hitrecord_u::setter = [](HitRecord& rec, double v) -> void { rec.u = v; };
    hitrecord_v::getter = [](HitRecord& rec) -> double { return rec.v; };
    hitrecord_v::setter = [](HitRecord& rec, double v) -> void { rec.v = v; };
    hitrecord_hit::getter = [](HitRecord& rec) -> bool { return rec.hit; };
    hitrecord_hit::setter = [](HitRecord& rec, bool v) -> void { rec.hit = v; };
    hitrecord_front_face::getter = [](HitRecord& rec) -> bool { return rec.front_face; };
    hitrecord_front_face::setter = [](HitRecord& rec, bool v) -> void { rec.front_face = v; };

    Usertype<HitRecord>::initialize_type(
        tl<
            hitrecord_p,
            hitrecord_normal,
            hitrecord_mat,
            hitrecord_t,
            hitrecord_front_face,
            hitrecord_u,
            hitrecord_v, 
            hitrecord_hit
        >(),
        tl<lambertian>()
    );

    // color
    var(r); var(g); var(b);
    using color_r = Property<color, double, r>;
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
    Usertype<interval>::implement();
    Usertype<aabb>::implement();
    Usertype<ray>::implement();
    Usertype<Hittable>::implement();
    Usertype<Hittable*>::implement();
    Usertype<material>::implement();
    Usertype<material*>::implement();
    Usertype<lambertian>::implement<material>();
    Usertype<lambertian*>::implement<material>();
    Usertype<sphere>::implement<Hittable>();
    Usertype<sphere*>::implement<Hittable>();
    Usertype<Triangle>::implement<Hittable>();
    Usertype<Triangle*>::implement<Hittable>();
    Usertype<HitRecord>::implement();
    Usertype<HitRecord*>::implement();
    Usertype<color>::implement();
    Usertype<ray_itval>::implement();
    Usertype<bvh_node>::implement<Hittable>();
    Usertype<bvh_node*>::implement<Hittable>();

}

void register_types() {
    register_type_properties();
    implement_types();
}