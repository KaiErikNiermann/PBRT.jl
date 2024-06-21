#include <stdlib.h>

#include <any>
#include <functional>
#include <iostream>
#include <jluna.hpp>
#include <string>
#include <typeinfo>
#include <unordered_map>

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

class B : public A {
   public:
    std::string str;
    B() : str("default B") {}
};

class C : public A {
   public:
    std::shared_ptr <A> val;
    C() : val(nullptr), str("default C") {}
    virtual const std::string get_name() const override { return "C"; }
    std::string str;
};

set_usertype_enabled(A);
set_usertype_enabled(A*);
set_usertype_enabled(B);
set_usertype_enabled(B*);
set_usertype_enabled(C);
set_usertype_enabled(C*);

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

template <typename... Types>
struct TypeList {};

template <typename T>
struct type_enabled {
    constexpr static inline const char* name = "None";
    constexpr static inline const bool value = false;
    constexpr static inline const bool is_abstract = false;
};

#define set_type_enabled(T)                                                          \
    template <>                                                                      \
    struct type_enabled<T> {                                                         \
        constexpr static inline const char* name = #T;                               \
        constexpr static inline const bool is_abstract = std::is_abstract<T>::value; \
    };

template <typename T>
class MyType {
   public:
    static inline std::map<const std::string, std::function<void(T&, std::string)>> functions;
    static inline std::map<std::string, std::size_t> tstr_hash;

    template <
        typename... Property, template <typename...> class A,
        typename... Derived, template <typename...> class B>
    static inline void initialize_self_constructor(A<Property...>, B<Derived...>) {
        ([&]() -> void {
            auto symbol = jluna::Symbol(Property::get_name());
            functions.insert({Property::get_name(),
                [](T& instance, std::string jl_t) -> void {
                    size_t real_t_hash = MyType<T>::tstr_hash[jl_t];
                    if (real_t_hash == typeid(T).hash_code()) {
                        // Property::setter(instance, MyType<T>::self_construct())
                    } else {
                        ([&real_t_hash]() -> void {
                            if (real_t_hash == typeid(Derived).hash_code()) {
                                // Property::setter(instance, MyType<Derived>::self_construct())
                            }
                        }(),
                        ...);
                    }
                }});
        }(),
         ...);

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

template<typename B, typename... D>
void assign_shared_ptr(std::shared_ptr<B>& val, B* in) {
    (..., [&]() -> void {
        if (auto d = dynamic_cast<D*>(in)) {
            val = std::shared_ptr<B>(std::make_shared<D>(*d));
        }
    }());
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

    static char str[] = "str";
    Property<B, std::string, str>::getter = [](B& b) -> std::string { return b.get_name(); };
    Property<B, std::string, str>::setter = [](B& b, std::string my_str) -> void {
        b.str = my_str;
    };

    Usertype<B>::initialize_type(
        TypeList<
            Property<B, std::string, str>>(),
        TypeList<>());

    static char val[] = "val";
    Property<C, A*, val>::getter = [](C& c) -> A* { return c.val.get(); };
    Property<C, A*, val>::setter = [](C& c, A* my_val) -> void {
        assign_shared_ptr<A, B, C>(c.val, my_val);
    };

    Usertype<C>::initialize_type(
        TypeList<
            Property<C, A*, val>>(),
        TypeList<B, C>());

    Main.create_or_assign("foo", as_julia_function<void(C)>([](C c) -> void { 
        std::cout << "c mem " << &c << "\n";
        B* b = static_cast<B*>(static_cast<C*>(c.val.get())->val.get());
        std::cout << "b str " << static_cast<B*>(static_cast<C*>(c.val.get())->val.get())->str << "\n";
    }));

    Main.safe_eval(R"(
    foo(PBRT.C(PBRT.C(PBRT.B("heyyy :3"))))
    )");

    return 0;
}