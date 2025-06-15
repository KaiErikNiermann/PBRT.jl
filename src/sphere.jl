@kwdef struct Sphere <: Hittable
    center::V3
    radius::Float64
    r_squared::Float64
    mat::Material
    bbox::AABB
end

function compute_sphere(center::V3, radius::Float64, material::Material = Lambertian(RGBVec3(1.0, 0.0, 0.0)))::Sphere
    radius  = max(0.0, radius)
    rvec    = @vec3 radius, radius, radius
    
    Sphere(
        center    = center, 
        radius    = radius, 
        r_squared = radius^2, 
        material  = material, 
        bbox      = AABB(center - rvec, center + rvec)
    )
end

function hit!(s::Sphere, ray::Ray, interval::Interval, record::HitRecord)
    oc     = ray.origin - s.center
    a      = ray.direction ⋅ ray.direction
    half_b = oc ⋅ ray.direction

    c      = (oc ⋅ oc) - s.r_squared
    Δ      = half_b^2 - a * c

    @guard Δ < 0 false

    sqrt_Δ = sqrt(Δ)
    root   = (-half_b - sqrt_Δ) / a

    in_interval(n) = interval.lo < n < interval.hi

    if !in_interval(root)
        root = (-half_b + sqrt_Δ) / a
        @guard !in_interval(root) false
    end


    record.t   = root
    record.p   = at(ray, record.t)
    out_norm   = (record.p - s.center) / s.radius
    record.mat = s.mat
    
    set_face_normal!(record, ray, out_norm)

    return true
end

export compute_sphere, Sphere