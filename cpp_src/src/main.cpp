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

using namespace jluna;

void init_pbrt() {
    Main.safe_eval("using Pkg");
    Main.safe_eval("Pkg.activate(\"../\")");
    Main.safe_eval("Pkg.instantiate()");
    Main.safe_eval("Pkg.resolve()");
    Main.safe_eval("using PBRT");
}

void register_functions() {
    jluna::unsafe::Value* hit_bvh_f = as_julia_function<HitRecord(bvh_node, ray_itval, HitRecord)>(
        [](const bvh_node& bvh, const ray_itval& r, const HitRecord& rec) -> HitRecord {
            auto start = std::chrono::high_resolution_clock::now();
            
            HitRecord rec_copy = rec;

            bvh_hit(bvh, r, &rec_copy);

            auto end = std::chrono::high_resolution_clock::now();

            std::chrono::duration<double> duration = end - start;
            double timeTaken = duration.count();

            std::ofstream file("cpp_t_real.csv", std::ios::app);
            if (file.is_open()) {
                file << timeTaken << "\n";
                file.close();
            } else {
                std::cerr << "Unable to open the file for writing\n";
            }

            return rec_copy;
        });
   
    Main.create_or_assign("hit_bvh", hit_bvh_f);
    Main.safe_eval(funcs::hit_bvh);
}

void render_scene(const std::string& scene_path) {
    Main["PBRT"]["example_render"](scene_path);
}

int main( int argc, char* argv[] ) {
    initialize();
    init_pbrt();

    register_types();
    register_functions();

    render_scene("../scenes/cottage.obj");

    return 0;
}