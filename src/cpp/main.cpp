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
        using Clock = std::chrono::steady_clock;  // Use a monotonic clock
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
        lambda();
        auto after = Benchmark::_clock.now();
        _results.push_back(Result(name, before, after));
    }

    static void save(const std::string& path = "/workspaces/Thesis/benchmarks/cpp_time.csv") {
        std::ofstream file(path);
        for (const auto& result : _results) {
            file << result._before.count() << ",";
            file << result._after.count() << ",";
            file << result._elapsed.count() << ",";
            file << "0" << ",";
            file << result._elapsed.count() << "\n"; 
        }
        file.close();
    }

private:
    static inline std::chrono::steady_clock _clock = std::chrono::steady_clock();
    static inline std::vector<Result> _results = {};
};

void register_functions() {
    jluna::Module RTInterop = jluna::Main.safe_eval("return MiniRTInterop");

    RTInterop.create_or_assign("hit", jluna::as_julia_function<HitRecord(BVHNode, RayPath, HitRecord)>(
        [](const BVHNode& node, const RayPath& ray_path, HitRecord&& record) -> HitRecord {
            Benchmark::run([&]() { 
                node.hit(ray_path.ray, ray_path.interval, record);
            });
            return record;
        }
    ));
}   

void render() {
    jluna::Main.safe_eval(
        "MiniRTInterop.MiniRT.render(\"/workspaces/Thesis/scenes/cottage/cottage.obj\")"
    );
}

int main(int argc, char* argv[]) {
    jluna::initialize(1);
    jluna::Main.safe_eval("ENV[\"JL_INTEROP_LANGUAGE\"] = \"C++\"");
    jluna::Main.safe_eval(module::MiniRTInterop);
    register_types();
    register_functions();
    
    Benchmark::initialize();
    render();
    Benchmark::save();
    return 0;
}