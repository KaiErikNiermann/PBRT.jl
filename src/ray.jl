struct Ray
    origin::Vec3
    direction::Vec3
end

mutable struct RayPath 
    ray::Ray
    interval::Interval
end

Ray() = Ray(Vec3((0.0, 0.0, 0.0)), Vec3((0.0, 0.0, 0.0)))

at(ray::Ray, t::Float64)::Vec3 = ray.origin + t * ray.direction 

export Ray, RayPath, at