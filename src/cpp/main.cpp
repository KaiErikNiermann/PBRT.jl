#include <stdlib.h>

#include <any>
#include <functional>
#include <iostream>
#include <jluna.hpp>
#include <string>
#include <typeinfo>
#include <unordered_map>
#include <chrono>
#include <fstream>

#include "aabb.h"
#include "bvh.h"
#include "funcs.inl"
#include "hittable.h"
#include "sphere.h"
#include "triangle.h"
#include "user_types.h"

/* clang-format off */
struct Benchmark {
    struct Result {
        using Clock = std::chrono::system_clock;  
        using TimePoint = std::chrono::time_point<Clock>;
        using Duration = std::chrono::nanoseconds; 
    
        Result() : _before(Duration::zero()), _after(Duration::zero()), _elapsed(Duration::zero()) {}

        Result(const std::string& name, TimePoint before, TimePoint after)
            : _name(name),
              _before(std::chrono::duration_cast<Duration>(before.time_since_epoch())), 
              _after(std::chrono::duration_cast<Duration>(after.time_since_epoch())),
              _elapsed(std::chrono::duration_cast<Duration>(after - before)) {}

        std::string _name;
        Duration _before;
        Duration _after;
        Duration _elapsed;
    };

    static void initialize() {
        std::cout << "[C++][LOG] starting benchmarks...\n" << std::endl;
        _results.clear();
    }

    template <typename Lambda_t>
    static void run(Lambda_t lambda, const std::string& name = "default") {
        auto before = Benchmark::_clock.now();
        try {
            lambda();
        } catch (const std::exception& e) {
            std::cerr << e.what() << std::endl;
        }
        auto after = Benchmark::_clock.now();
        _results.push_back(Result(name, before, after));
    }

    static Benchmark::Result save(const std::string& path = "/workspaces/Thesis/benchmarks/cpp_time.csv") {
        std::ofstream file(path);
        for (const auto& result : _results) {
            file << result._before.count() << std::endl; 
            file << result._after.count() << std::endl;  
            file << result._elapsed.count() << std::endl;
        }
        file.close();
        return _base;
    }

private:
    static inline Benchmark::Result _base = Benchmark::Result();
    static inline std::chrono::system_clock _clock = std::chrono::system_clock(); 
    static inline std::vector<Result> _results = {};
};


void init_pbrt() {
    jluna::Main.safe_eval("using Pkg");
    jluna::Main.safe_eval("Pkg.activate(\"./\")");
    jluna::Main.safe_eval("Pkg.instantiate()");
    jluna::Main.safe_eval("Pkg.resolve()");
    jluna::Main.safe_eval("include(\"/workspaces/Thesis/src/PBRT.jl\")");
    jluna::Main.safe_eval("using .PBRT");
}

void register_functions() {
    jluna::unsafe::Value* hit_bvh_f
        = jluna::as_julia_function<HitRecord(BVHNode, RayData, HitRecord)>(
            [](const BVHNode& bvh_tree, const RayData& ray_data, HitRecord&& hit_rec) -> HitRecord {
                Benchmark::run([&]() { BVH_hit(bvh_tree, ray_data, hit_rec); });
                return std::move(hit_rec);
            }
        );

    jluna::Main.create_or_assign("hit_bvh", hit_bvh_f);
    jluna::Main.safe_eval(funcs::hit_bvh);
}

void render_scene(const std::string& scene_path) {
    jluna::Main["PBRT"]["example_render"](scene_path);
}

int main(int argc, char* argv[]) {
    jluna::initialize();
    init_pbrt();

    register_types();
    register_functions();

    Benchmark::initialize();
    render_scene("./scenes/cottage.obj");
    Benchmark::save();
    return 0;
}