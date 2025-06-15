struct Ray
    origin::V3
    direction::V3
end

struct RayPath 
    ray::Ray
    interval::Interval
end

Ray() = Ray(V3([0.0, 0.0, 0.0]), V3([0.0, 0.0, 0.0]))

at(ray::Ray, t::Float64)::V3 = ray.origin + t * ray.direction 

export Ray, RayPath, at