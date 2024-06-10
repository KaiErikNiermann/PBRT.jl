#pragma once 

#include <string>

namespace funcs {
    static inline std::string hit_aabb = 
        R"(function PBRT.hit!(bbox::PBRT.aabb, r::PBRT.ray, ray_t::PBRT.interval)::Bool
    return Bool(hit_bbox(bbox, r, ray_t)) 
end
)";
    static inline std::string hit_tri  = 
        R"(function PBRT.hit!(bbox::PBRT.triangle, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    return Bool(hit_triangle(bbox, r, ray_t, rec)) 
end)";
    static inline std::string hit_sphere = 
        R"(function PBRT.hit!(bbox::PBRT.sphere, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    return Bool(hit_sphere(bbox, r, ray_t, rec)) 
end)";
}   
