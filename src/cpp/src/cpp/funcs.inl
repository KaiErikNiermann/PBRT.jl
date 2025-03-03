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
    static inline std::string hit_bvh = 
        R"(function PBRT.hit!(node::PBRT.bvh_node, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    new_hit_rec = hit_bvh(node, PBRT.ray_itval(r, ray_t), rec)
    rec.t = new_hit_rec.t
    rec.p = new_hit_rec.p
    rec.normal = new_hit_rec.normal
    red = new_hit_rec.mat.albedo.r
    green = new_hit_rec.mat.albedo.g
    blue = new_hit_rec.mat.albedo.b
    rec.mat = PBRT.lambertian(PBRT.color([red, green, blue]))
    rec.front_face = new_hit_rec.front_face
    return Bool(new_hit_rec.hit)
end)";
}   
