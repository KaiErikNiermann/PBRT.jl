function PBRT.hit!(triangle::PBRT.Triangle, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    jl_ray_itval.r = r
    jl_ray_itval.ray_t = ray_t
    return Bool(hit_triangle(triangle, Main.ray_itval(r, ray_t), rec)) 
end