#include <stdlib.h>

#include <functional>
#include <jluna.hpp>
#include <string>

#include "aabb.h"
#include "abs_hit.h"
#include "bvh.h"
#include "funcs.inl"
#include "hittable.h"
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

void register_functions() {
    jluna::unsafe::Value* hit_aabb_f = as_julia_function<bool(aabb, ray, interval)>(
        [](const aabb& box, const ray& r, const interval& ray_t) -> bool {
            return hit_aabb(box, r, ray_t);
        });
    jluna::unsafe::Value* hit_triangle_f = as_julia_function<bool(triangle, ray_itval, HitRecord)>(
        [](const triangle& tri, const ray_itval& r, const HitRecord& rec) -> bool {
            return tri.hit(r, rec);
        });
    jluna::unsafe::Value* hit_sphere_f = as_julia_function<bool(Sphere, ray_itval, HitRecord)>(
        [](const Sphere& s, const ray_itval& r, const HitRecord& rec) -> bool {
            return s.hit(r, rec);
        });
    jluna::unsafe::Value* hit_bvh_f = as_julia_function<bool(bvh_node, ray_itval, HitRecord)>(
        [](const bvh_node& bvh, const ray_itval& r, const HitRecord& rec) -> bool {
            return hit_bvh(bvh, r, rec);
        });
    // jluna::unsafe::Value* hit_f = as_julia_function<hit_lambda(std::shared_ptr<Hittable>)>(
    //     [](const std::shared_ptr<Hittable>& h) -> hit_lambda {
    //         return hit(h);
    //     });

    // Redefine hit functions
    Main.create_or_assign("hit_aabb", hit_aabb_f);
    Main.create_or_assign("hit_triangle", hit_triangle_f);
    Main.create_or_assign("hit_sphere", hit_sphere_f);
    // Main.create_or_assign("hit_bvh", hit_bvh_f);

    Main.safe_eval(funcs::hit_aabb);
    Main.safe_eval(funcs::hit_triangle);
    Main.safe_eval(funcs::hit_sphere);
    // Main.safe_eval(funcs::hit_bvh);
}

void render_scene(const std::string& scene_path) {
    Main["PBRT"]["example_render"](scene_path);
}

class A { };

class B : public A {
    public:
        std::string str = "B";
        B() { }
        B(const std::string& s) : str(s) { }
};

class node : public A {
    public:
        A val;
        node() : val(B()) { };
        node(const A& a) : val(a) { };
};

set_usertype_enabled(A);
set_usertype_enabled(B);
set_usertype_enabled(node);

void foo(const node& n) {
    // print pointer n
    node* n_ptr = const_cast<node*>(&n); 
    std::cout << n_ptr << std::endl;
    std::cout << "node" << std::endl;
}

int main() {
    initialize();
    inti_pbrt();

    // register_types();
    // register_functions();

    // render_scene("../scenes/cottage_obj.obj");




    Usertype<B>::add_property<std::string>(
        "str",
        [](const B& b) -> std::string { return b.str; },
        [](B& b, const std::string& msg) -> void { b.str = msg; }
    );

    Usertype<node>::add_property<A>(
        "val",
        [](const node& n) -> A { return n.val; },
        [](node& n, const A& a) -> void { n.val = a; }
    );

    Usertype<A>::implement();
    Usertype<B>::implement();
    Usertype<node>::implement();

    Main.create_or_assign("foo", as_julia_function<void(node)>(
        [](const node& n) -> void {
            foo(n);
        }
    ));

    Main.safe_eval(R"(
    n = node()
    foo(n)
    )");

    return 0;
}