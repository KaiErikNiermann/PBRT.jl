#include <gtest/gtest.h>
#include <jluna.hpp>

using namespace jluna;

template<typename B, typename... D>
void assign_shared_ptr(std::shared_ptr<B>& val, B* in) {
    (..., [&]() -> void {
        if (auto d = dynamic_cast<D*>(in)) {
            val = std::shared_ptr<B>(std::make_shared<D>(*d));
        }
    }());
} 

template<typename B, typename... D>
std::shared_ptr<B> return_shared_ptr(B* in) {
    std::shared_ptr<B> val;
    (..., [&]() -> void {
        if (auto d = dynamic_cast<D*>(in)) {
            val = std::shared_ptr<B>(std::make_shared<D>(*d));
        }
    }());
    return val;
}

class A {
   public:
    virtual ~A() = default;
    virtual const std::string get_name() const = 0;  
};

class B : public A {
   public:
    B() : str("default B") {}
    const void set_str(const std::string& s) { str = s; }
    virtual const std::string get_name() const override { return "B"; }
    std::string str;
};

class D : public A {
   public:
    std::shared_ptr <A> val;
    D() : val(nullptr), str("default D") {}
    D(std::shared_ptr<A> v) : val(v), str("default D") {}
    virtual const std::string get_name() const override { return "D"; }
    std::string str;
};

class C : public A {
   public:
    std::shared_ptr <A> val;
    C() : val(nullptr), str("default C") {}
    C(std::shared_ptr<A> v) : val(v), str("default C") {}
    virtual const std::string get_name() const override { return "C"; }
    std::string str;
};

class s1 {
   public:
    virtual ~s1() = default;
    virtual void foo() = 0; 
};

class s2 {
   public:
    virtual ~s2() = default;
    virtual void bar() = 0; 
};

class d1 : public s1 {
   public:
    std::vector<double> albedo;
    virtual void foo() override {}
};

class a1 : public s2 {
    public: 
        std::shared_ptr<s1> val;
        virtual void bar() override {}
};


set_usertype_enabled(s1);
set_usertype_enabled(s1*);
set_usertype_enabled(s2);
set_usertype_enabled(s2*);
set_usertype_enabled(d1);
set_usertype_enabled(d1*);
set_usertype_enabled(a1);
set_usertype_enabled(a1*);

set_usertype_enabled(A);
set_usertype_enabled(A*);
set_usertype_enabled(B);
set_usertype_enabled(B*);
set_usertype_enabled(C);
set_usertype_enabled(C*);
set_usertype_enabled(D);
set_usertype_enabled(D*);

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

void init_pbrt() {
    Main.safe_eval("using Pkg");
    Main.safe_eval("Pkg.activate(\"../\")");
    Main.safe_eval("Pkg.instantiate()");
    Main.safe_eval("Pkg.resolve()");
    Main.safe_eval("using PBRT");
}

void proxy_object_setup() {
    // B

    static char str[] = "str";
    Property<B, std::string, str>::getter = [](B& b) -> std::string { 
        std::cout << "B.str " << b.str << std::endl;
        return b.str; 
    };
    Property<B, std::string, str>::setter = [](B& b, std::string my_str) -> void {
        b.str = my_str;
    };

    Usertype<B>::initialize_type(
        TypeList<
            Property<B, std::string, str>>(),
        TypeList<>()
    );

    // C
    static char val[] = "val";

    Property<C, A*, val>::getter = [](C& c) -> A* { 
        return c.val.get();
    };

    Property<C, A*, val>::setter = [](C& c, A* my_val) -> void {
        assign_shared_ptr<A, B, C, D>(c.val, my_val);
    };

    Usertype<C>::initialize_type(
        TypeList<
            Property<C, A*, val>>(),
        TypeList<B, C, D>()
    );

    // D
    Property<D, A*, val>::getter = [](D& d) -> A* { return d.val.get(); };
    Property<D, A*, val>::setter = [](D& d, A* my_val) -> void {
        assign_shared_ptr<A, B, C, D>(d.val, my_val);
    };

    Usertype<D>::initialize_type(
        TypeList<
            Property<D, A*, val>>(),
        TypeList<B, C, D>()
    );

    Usertype<A>::implement();
    Usertype<A*>::implement();
    Usertype<B>::implement<A>();
    Usertype<B*>::implement<A>();
    Usertype<C>::implement<A>();
    Usertype<C*>::implement<A>();
    Usertype<D>::implement<A>();
    Usertype<D*>::implement<A>();
}

void complex_proxy_object_setup() {
    // d1
    static char albedo[] = "albedo";
    Property<d1, std::vector<double>, albedo>::getter = [](d1& d) -> std::vector<double> { return d.albedo; };

    Usertype<d1>::initialize_type(
        TypeList<
            Property<d1, std::vector<double>, albedo>>(),
        TypeList<d1>()
    );

    // a1
    static char val[] = "val";
    Property<a1, s1*, val>::getter = [](a1& a) -> s1* { return a.val.get(); };
    Property<a1, s1*, val>::setter = [](a1& a, s1* my_val) -> void {
        assign_shared_ptr<s1, d1>(a.val, my_val);
    };

    Usertype<a1>::initialize_type(
        TypeList<
            Property<a1, s1*, val>>(),
        TypeList<d1>()
    );

    Usertype<s1>::implement();
    Usertype<s1*>::implement();
    Usertype<s2>::implement();
    Usertype<s2*>::implement();
    Usertype<d1>::implement<s1>();
    Usertype<d1*>::implement<s1>();
    Usertype<a1>::implement<s2>();
    Usertype<a1*>::implement<s2>();
}

TEST(BasicTests, SimpleUnbox) {
    B b = jluna::unbox<B>(jl_eval_string("PBRT.B(\"heyyy :3\")"));
    EXPECT_EQ(b.str, "heyyy :3");
}

TEST(BasicTests, SimplePolymorphicUnbox) {
    C c1 = jluna::unbox<C>(jl_eval_string("PBRT.C(PBRT.C(PBRT.C(PBRT.B(\"heyyy :3\"))))"));
    C c3 = jluna::unbox<C>(jl_eval_string("PBRT.C(PBRT.D(PBRT.C(PBRT.B(\"heyyy :3\"))))"));
    C c4 = jluna::unbox<C>(jl_eval_string("PBRT.D(PBRT.D(PBRT.C(PBRT.B(\"heyyy :3\"))))"));

    // c1 text
    std::string c1_text = static_cast<B*>(static_cast<C*>(static_cast<C*>(c1.val.get())->val.get())->val.get())->str;
    std::string c2_text = static_cast<B*>(static_cast<D*>(static_cast<C*>(c1.val.get())->val.get())->val.get())->str;
    std::string c3_text = static_cast<B*>(static_cast<C*>(static_cast<D*>(c3.val.get())->val.get())->val.get())->str;

    EXPECT_EQ(c1_text, "heyyy :3");
    EXPECT_EQ(c2_text, "heyyy :3");
    EXPECT_EQ(c3_text, "heyyy :3");
}

TEST(BasicTests, FunctionProxyMutability) {
    Main.create_or_assign("modify_B_class", 
        jluna::as_julia_function<B(B)>(
            [](const B& b) -> B {
                B b_new = b;
                b_new.str = "modified B";
                return b_new;
            }
    ));   

    auto modified_b = jluna::unbox<B>(Main.safe_eval("return modify_B_class(PBRT.B(\"heyyy :3\"))"));
    EXPECT_EQ(modified_b.str, "modified B");
}

TEST(BasicTests, BoxingPolymorphicTypes) {
    Main.safe_eval("my_proxy = PBRT.C(PBRT.D(PBRT.C(PBRT.B(\"heyyy :3\"))))");
    C polymorphic_proxy = Main["my_proxy"];
    std::string c_text = static_cast<B*>(static_cast<C*>(static_cast<D*>(polymorphic_proxy.val.get())->val.get())->val.get())->str;    

    Main.create_or_assign("modify_C_class", 
        jluna::as_julia_function<C(C)>(
            [](const C& c) -> C {
                C c_new; 
                B b_new; 
                b_new.str = "heyy from cpp :3";
                c_new.val = std::make_shared<B>(b_new);
                return c_new;
            }
    ));   

    Main.safe_eval("println(modify_C_class(my_proxy).val)");
    EXPECT_EQ(c_text, "heyyy :3");
}

TEST(BasicTests, ComplexProxyObject) {
    Main.safe_eval("my_proxy = PBRT.a1(PBRT.d1([1.0, 2.0, 3.0]))");
    a1 a = jluna::unbox<a1>(jluna::safe_eval("return my_proxy"));
    std::vector<double> albedo = static_cast<d1*>(a.val.get())->albedo;
    EXPECT_EQ(albedo[0], 1.0);
    EXPECT_EQ(albedo[1], 2.0);
    EXPECT_EQ(albedo[2], 3.0);
}

int main(int argc, char **argv) {
    initialize();
    init_pbrt();
    proxy_object_setup();
    complex_proxy_object_setup();   
    
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}