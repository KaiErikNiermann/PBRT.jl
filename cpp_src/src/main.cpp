#include <stdlib.h>

#include <functional>
#include <jluna.hpp>
#include <string>
#include <any>
#include <iostream>
#include <string>
#include <unordered_map>
#include <typeinfo>
#include <functional>

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

class A {
   public:
    virtual ~A() = default;  // Virtual destructor for proper cleanup
    virtual const std::string get_name() const { return "A"; }
};

// Class B that inherits from A
class B : public A {
   public:
    B() : str("default B") {}
    B(const std::string& s) : str(s) {}
    virtual const std::string get_name() const override { return str; }
    void set_str(const std::string& s) { 
        std::cout << "setting str -> " << s << std::endl;
        str = s; 
    }

   private:
    std::string str;
};

// Class C that inherits from A and can hold an A-type value
class C : public A {
   public:
    A* val;  // Pointer to an instance of A
    C() : val(nullptr) {}
    C(A* v) : val(v) {}
    ~C() { delete val; }  // Destructor to clean up the allocated memory
    virtual const std::string get_name() const override { return "C"; }
    void set_str(const std::string& s) { str = s; }

   private:
    std::string str;
};

set_usertype_enabled(A);
set_usertype_enabled(A*);
set_usertype_enabled(B);
set_usertype_enabled(B*);
set_usertype_enabled(C);
set_usertype_enabled(C*);

void foo(C c) {
    std::cout << "calling foo" << std::endl;
    // std::cout << static_cast<C*>(c.val)->val->get_name() << std::endl;
    // std::cout << c.val->get_name() << std::endl;
}

template <typename T>
class bar {
    public:
        static inline T unbox() { return T(); }    
};

int main() {
    initialize();
    inti_pbrt();

    // register_types();
    // register_functions();

    // render_scene("../scenes/cottage_obj.obj");

    Usertype<A>::implement();
    Usertype<A*>::implement();
    Usertype<B>::implement();
    Usertype<B*>::implement();
    Usertype<C>::implement();
    Usertype<C*>::implement();


    Usertype<B>::add_property<std::string>(
        "str",
        [](B& b) -> std::string { return b.get_name(); },
        [](B& b, const std::string msg) -> void { b.set_str(msg); }
    );

    Usertype<C>::initialize_map<A*, B, C>();

    Usertype<C>::add_property<A*, B, C>(
        "val",
        [](C& c) -> A* { return c.val; },
        [](C& c, A* val) -> void { 
            c.val = val; 
        }
    );

    // add foo method
    Main.create_or_assign("foo", as_julia_function<void(C)>
        ( [](C c) -> void { foo(c); } )
    );

    const std::function<void(C&, A*)> setter_f = [](C& c, A* val) -> void { c.val = val; };

    C* c = new C();
    C c2 = bar<C>::unbox();
    setter_f(*c, &c2);

    // setter_f(*c, bar<C>()::unbox());

    // Main.safe_eval(R"(
    // foo(PBRT.C(PBRT.C(PBRT.B("heyyy :3"))))
    // )");

    return 0;
}