
template<typename B, typename... D>
void assign_shared_ptr(std::shared_ptr<B>& val, B* in) {
    (..., [&]() -> void {
        if (auto d = dynamic_cast<D*>(in)) {
            val = std::shared_ptr<B>(std::make_shared<D>(*d));
        }
    }());
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

void testing() {
    Usertype<A>::implement();
    Usertype<A*>::implement();
    Usertype<B>::implement();
    Usertype<B*>::implement();
    Usertype<C>::implement();
    Usertype<C*>::implement();
    Usertype<D>::implement();
    Usertype<D*>::implement();

    // B
    static char str[] = "str";
    Property<B, std::string, str>::getter = [](B& b) -> std::string { return b.get_name(); };
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
    Property<C, A*, val>::getter = [](C& c) -> A* { return c.val.get(); };
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

    Main.create_or_assign("foo", as_julia_function<void(C)>([](C c) -> void { 
        std::cout << "c mem " << &c << "\n";
        std::cout << "b str" << static_cast<B*>(static_cast<D*>(static_cast<C*>(c.val.get())->val.get())->val.get())->str << "\n";
    }));

    Main.safe_eval(R"(
    foo(PBRT.C(PBRT.C(PBRT.D(PBRT.B("heyyy :3")))))
    )");
}