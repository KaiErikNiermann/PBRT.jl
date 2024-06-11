function PBRT.hit!(triangle::PBRT.Triangle, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    return Bool(hit_triangle(triangle, Main.ray_itval(r, ray_t), rec)) 
end