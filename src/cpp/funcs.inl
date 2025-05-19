#pragma once 

#include <string>

namespace funcs {
    static inline std::string hit_aabb = 
        R"(function PBRT.hit!(bbox::PBRT.aabb, r::PBRT.ray, ray_t::PBRT.interval)::Bool
    return Bool(hit_aabb(bbox, r, ray_t)) 
end)";
    static inline std::string hit_triangle  = 
        R"(function PBRT.hit!(triangle::PBRT.Triangle, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    return Bool(hit_triangle(triangle, PBRT.ray_itval(r, ray_t), rec)) 
end)";
    static inline std::string hit_sphere = 
        R"(function PBRT.hit!(sphere::PBRT.sphere, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    return Bool(hit_sphere(sphere, PBRT.ray_itval(r, ray_t), rec)) 
end)";
    static inline std::string hit_bvh = 
        R"(import Profile

function PBRT.hit!(node::PBRT.BVHNode, ray::PBRT.Ray, interval::PBRT.Interval, rec::PBRT.HitRecord)::Bool
    t1 = time_ns()  
    updated_record = Main.hit_bvh(node, PBRT.RayData(ray, interval), rec)
    t2 = time_ns()

    open("/workspaces/Thesis/benchmarks/jl_time.csv", "a") do io
        write(io, "$t1,")
        write(io, "$t2,")
        write(io, "$(t2 - t1)\n")  
    end

    rec.t = updated_record.t
    rec.p = updated_record.p
    rec.normal = updated_record.normal
    red = updated_record.mat.albedo.r
    green = updated_record.mat.albedo.g
    blue = updated_record.mat.albedo.b
    rec.mat = PBRT.Lambertian(PBRT.Color([red, green, blue]))
    rec.front_face = updated_record.front_face
    
    return Bool(updated_record.hit)
end
)";
}   
