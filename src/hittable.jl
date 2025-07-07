mutable struct HitRecord
    p::Vec3
    normal::Vec3
    mat::Material
    t::Float64
    front_face::Bool
    u::Float64
    v::Float64
    hit::Bool
end

HitRecord() = HitRecord(
    Vec3((0.0, 0.0, 0.0)),
    Vec3((0.0, 0.0, 0.0)),
    Lambertian(RGBVec3((0.0, 0.0, 0.0))),
    0.0,
    false,
    0.0,
    0.0,
    false
)

mutable struct ScatterRecord
    attenuation::RGBVec3
    scattered::Ray
end

const HRecord  = HitRecord
const SDRecord = ScatterRecord

function set_face_normal!(h_record::HRecord, r::Ray, outward_normal::Vec3)
    h_record.front_face = dot(r.direction, outward_normal) < 0
    
    if(h_record.front_face)
        h_record.normal = outward_normal
    else
        h_record.normal = -outward_normal
    end
end

function scatter(material::Lambertian, h_record::HRecord, s_data::SDRecord, ray::Ray)::Bool
    s_direction = h_record.normal .+ rand_unit_v()
    
    if(near_zero(s_direction))
        s_direction = h_record.normal
    end
    
    s_data.scattered   = Ray(h_record.p, s_direction)
    s_data.attenuation = material.albedo
    
    true
end

function scatter(material::Metal, h_record::HRecord, s_data::SDRecord, ray::Ray)::Bool
    reflected          = reflect(unit_v(ray.direction), h_record.normal)

    s_data.scattered   = Ray(h_record.p, reflected .+ (material.fuzz * random_in_unit_sphere()))
    s_data.attenuation = material.albedo
    
    dot(s_data.scattered.direction, h_record.normal) > 0
end

function scatter(material::Dielectric, h_record::HRecord, s_data::SDRecord, ray::Ray)::Bool
    refraction_ratio = h_record.front_face ? (1.0 / material.ir) : material.ir
    
    unit_direction   = unit_v(ray.direction)
    cosθ             = min(dot(-unit_direction, h_record.normal), 1.0)
    sinθ             = sqrt(1.0 - cosθ^2)
    
    cannot_refract = (refraction_ratio * sinθ) > 1.0
    
    direction = cannot_refract || reflectance(cosθ, refraction_ratio) > rand_f64() ? 
    reflect(unit_direction, h_record.normal) :
    refract(unit_direction, h_record.normal, refraction_ratio)
    
    s_data.scattered = Ray(h_record.p, direction)
    s_data.attenuation = RGBVec3(Vec3[1.0, 1.0, 1.0])
    
    true
end

abstract type Hittable end

export HitRecord, ScatterRecord, Hittable, set_face_normal!, scatter, HRecord, SDRecord