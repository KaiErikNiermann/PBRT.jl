function PBRT.hit!(sphere::PBRT.sphere, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    jl_ray_itval.r = r
    jl_ray_itval.ray_t = ray_t
    return Bool(hit_sphere(sphere, jl_ray_itval, rec)) 
end