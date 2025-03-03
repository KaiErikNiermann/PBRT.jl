mutable struct HitRecord
    p::Vector{Float64}
    normal::Vector{Float64}
    mat::Material
    t::Float64
    front_face::Bool
    u::Float64
    v::Float64
    hit::Bool
    HitRecord() = new([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], Lambertian(Color([0.0, 0.0, 0.0])), 0.0, false, 0.0, 0.0, false)
end

mutable struct ScatterData
    attenuation::Color
    scattered::Ray
end

function set_face_normal!(rec::HitRecord, r::Ray, outward_normal::Vector{Float64})
    rec.front_face = dot(r.direction, outward_normal) < 0
    if(rec.front_face)
        # ray is outside
        rec.normal = outward_normal
    else
        # ray is inside
        rec.normal = -outward_normal
    end
end

function scatter(mat::Lambertian, ray::Ray, rec::HitRecord, sd::ScatterData)::Bool
    scatter_direction = rec.normal + random_unit_vector()
    
    # Catch degenerate scatter direction
    if(near_zero(scatter_direction))
        scatter_direction = rec.normal
    end
    
    sd.scattered = Ray(rec.p, scatter_direction)
    sd.attenuation = mat.albedo
    return true
end

function scatter(material::Metal, ray::Ray, rec::HitRecord, sd::ScatterData)::Bool
    reflected = reflect(ray.direction/norm(ray.direction), rec.normal)
    sd.scattered = Ray(rec.p, reflected + material.fuzz * random_in_unit_sphere())
    sd.attenuation = material.albedo
    return (dot(sd.scattered.direction, rec.normal) > 0)
end

function scatter(material::Dielectric, ray::Ray, rec::HitRecord, sd::ScatterData)::Bool
    sd.attenuation = Color([1.0, 1.0, 1.0])
    refraction_ratio = rec.front_face ? (1.0 / material.ir) : material.ir

    unit_direction = ray.direction/norm(ray.direction)
    cos_theta = min(dot(-unit_direction, rec.normal), 1.0)
    sin_theta = sqrt(1.0 - cos_theta^2)

    cannot_refract = refraction_ratio * sin_theta > 1.0
    dir = [0.0, 0.0, 0.0]
    if(cannot_refract || reflectance(cos_theta, refraction_ratio) > random_double())
        dir = reflect(unit_direction, rec.normal)
    else
        dir = refract(unit_direction, rec.normal, refraction_ratio)
    end

    sd.scattered = Ray(rec.p, dir)
    return true
end

abstract type Hittable end

struct NULLHittable <: Hittable end