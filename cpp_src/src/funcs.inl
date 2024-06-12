#pragma once 

#include <string>

namespace funcs {
    static inline std::string hit_aabb = 
        R"(function PBRT.hit!(bbox::PBRT.aabb, r::PBRT.ray, ray_t::PBRT.interval)::Bool
    return Bool(hit_aabb(bbox, r, ray_t)) 
end
)";
    static inline std::string hit_triangle  = 
        R"(function PBRT.hit!(triangle::PBRT.Triangle, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    return Bool(hit_triangle(triangle, PBRT.ray_itval(r, ray_t), rec)) 
end)";
    static inline std::string hit_sphere = 
        R"(function PBRT.hit!(sphere::PBRT.sphere, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    return Bool(hit_sphere(sphere, PBRT.ray_itval(r, ray_t), rec)) 
end)";
}   
