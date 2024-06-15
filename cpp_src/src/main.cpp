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
        virtual const std::string get_name() const override { return "B"; }
        void set_str(const std::string& s) { str = s; }
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
set_usertype_enabled(C);

// void foo(jl_value_t* C) {
//     jl_datatype_t* C_type = (jl_datatype_t*)jl_typeof(C);
//     jluna::Type C_jltype = jluna::Type(C_type);
//     std::vector<std::string> f_names = C_jltype.get_field_names();
//     for (std::string s : f_names) {
//         std::cout << s << std::endl;
//     }
//     std::cout << "is abstract: " << C_jltype.is_abstract_type() << std::endl;
//     std::cout << C_jltype.get_super_type().get_name() << std::endl;

//     // get val field
//     jl_value_t* val = jl_get_nth_field(C, 0);
//     jluna::Type val_type = jluna::Type((jl_datatype_t*)jl_typeof(val));
//     std::cout << val_type.get_name() << std::endl;
//     std::cout << val_type.get_field_names().size() << std::endl;
//     std::cout << val_type.get_field_names()[0] << std::endl;
//     // print super type
//     std::cout << val_type.get_super_type().get_name() << std::endl;

//     // get str field
//     jl_value_t* str = jl_get_nth_field(val, 0);
//     std::cout << jl_string_ptr(str) << std::endl;
// }

void foo(const C& c) {
    std::cout << "calling foo" << std::endl;
    
    C* c1 = dynamic_cast<C*>(c.val);

    jl_value_t* B = (jl_value_t*)(c1->val);

    std::cout << "works" << std::endl;
    // jl_value_t* str = jl_get_nth_field(val, 0);
    // std::cout << jl_string_ptr(str) << std::endl;
}

template<class... Types>
struct type_container {
    using as_tuple = std::tuple<Types...>;

    template<std::size_t I>
    using get = std::tuple_element_t<I, as_tuple>;

    static constexpr std::size_t size = sizeof...(Types);
};

template<typename T>
void print_type() {
    std::cout << typeid(T).name() << std::endl;
    auto b = T();
    std::cout << b.get_name() << std::endl;
}

int main() {
    initialize();
    inti_pbrt();

    // register_types();
    // register_functions();

    // render_scene("../scenes/cottage_obj.obj");

    Usertype<B>::add_property<std::string>(
        "str",
        [](const B& b) -> std::string { return b.get_name(); },
        [](B& b, const std::string& msg) -> void { b.set_str(msg); });

    Usertype<C>::add_property<A*>(
        "val",
        [](const C& c) -> A* { return c.val; },
        [](C& c, A* val) -> void {
            c.val = val;
        });

    // add foo method
    Main.create_or_assign("foo", as_julia_function<void(C)>(
        [](const C& c) -> void { foo(c); })
    );

    Usertype<A>::implement();
    Usertype<A*>::implement();
    Usertype<B>::implement();
    Usertype<C>::implement();

    // create typearray using type_container 
    using types = type_container<A, B, C>;
    print_type<types::get<1>>();

    Main.safe_eval(R"(
    foo(PBRT.C(PBRT.C(PBRT.B("heyyy :3"))))
    )");

    return 0;
}