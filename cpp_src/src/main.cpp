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
    // Main.safe_eval("using PBRT");
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

template <typename Ot, typename Ft, int Tag>
struct Property {
    using object_type = const Ot;
    using field_type = const Ft;
    static std::string name;
    static std::function<const Ft(Ot&)> getter;
    static std::function<const void(Ot&, Ft)> setter;
};

template <typename Ot, typename Ft, int Tag>
std::function<const Ft(Ot&)> Property<Ot, Ft, Tag>::getter;

template <typename Ot, typename Ft, int Tag>
std::function<const void(Ot&, Ft)> Property<Ot, Ft, Tag>::setter;

template <typename Ot, typename Ft, int Tag>
std::string Property<Ot, Ft, Tag>::name;

template <typename... Types>
struct TypeList { };

template<typename T>
struct type_enabled {
    constexpr static inline const char* name = "None";
    constexpr static inline const bool value = false;
    constexpr static inline const bool is_abstract = false;
};

#define set_type_enabled(T) template<> struct type_enabled<T> { \
    constexpr static inline const char* name = #T;   \
    constexpr static inline const bool is_abstract = std::is_abstract<T>::value; \
}; 

template<typename T>
class MyType { 
    public:
        static inline std::map<std::string, std::function<void(T&, std::string)>> functions;
        static inline std::map<std::string, std::size_t> tstr_hash;
    
        template <
            typename... Property, template <typename...> class A, 
            typename... Derived, template <typename...> class B 
        >
        static inline void initalize_self_constructor(A<Property...>, B<Derived...>) {
            (functions.insert({
                Property::name,
                [](T& instance, std::string jl_t) -> void {
                    size_t real_t_hash = MyType<T>::tstr_hash[jl_t];
                    if (real_t_hash == typeid(T).hash_code()) {
                        // Property::setter(instance, MyType<T>::self_construct())
                    } else {
                        ([&real_t_hash]() -> void {
                            if (real_t_hash == typeid(Derived).hash_code()) {
                                // Property::setter(instance, MyType<Derived>::self_construct())  
                            }
                        }(), ...);
                    }
                }
            }), ...);
            initialize_map<Derived...>();
        }

        template <typename... Derived>
        static inline void initialize_map() {
            tstr_hash[typeid(T).name()] = typeid(T).hash_code();
            ((tstr_hash[typeid(Derived).name()] = typeid(Derived).hash_code()), ...);
        }

        template <typename... Derived>
        static inline void self_construct(std::string jl_t) {

        }

    private:
        static inline bool _is_abstract = type_enabled<T>::is_abstract;
};

template<typename T>
concept is_str = std::is_same_v<std::remove_cv_t<T>, std::string>;

template <is_str T>
void print_str(T t) {
    std::cout << t << std::endl;
}

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

    Property<B, std::string, 0>::name = "str";
    Property<B, std::string, 0>::getter = [](const B& b) -> std::string { return b.get_name(); };
    Property<B, std::string, 0>::setter = [](B b, const std::string msg) -> void { b.set_str(msg); };

    Usertype<B>::initialize_type(
        TypeList<
            Property<B, std::string, 0>
        >(),
        TypeList<>()
    ); 



    // Usertype<B>::add_property<std::string>(
    //     "str",
    //     [](B& b) -> std::string { return b.get_name(); },
    //     [](B& b, const std::string msg) -> void { b.set_str(msg); }
    // );


    // Usertype<C>::initialize_map<A*, B, C>();

    // Usertype<C>::add_property<A*, B, C>(
    //     "val",
    //     [](C& c) -> A* { return c.val; },
    //     [](C& c, A* val) -> void { 
    //         c.val = val; 
    //     }
    // );

    // // add foo method
    // Main.create_or_assign("foo", as_julia_function<void(C)>
    //     ( [](C c) -> void { foo(c); } )
    // );

    

    Main.safe_eval(R"(
    foo(PBRT.C(PBRT.C(PBRT.B("heyyy :3"))))
    )");

    return 0;
}