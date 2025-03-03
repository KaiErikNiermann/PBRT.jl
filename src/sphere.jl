struct Sphere <: Hittable
    center::Vector{Float64}
    radius::Float64
    r_squared::Float64
    mat::Material
    bbox::AABB
end

function Sphere(center::Vector{Float64}, radius::Float64, mat::Material)
    radius = max(0.0, radius)
    rvec = [radius, radius, radius]
    bbox = AABB(center - rvec, center + rvec)
    Sphere(center, radius, radius^2, mat, bbox)
end

Base.show(io::IO, s::Sphere) = print(io, "sphere($(s.center), $(s.radius), $(s.mat))")

function hit!(s::Sphere, r::Ray, ray_t::Interval, rec::HitRecord)
    oc = r.origin - s.center
    a = dot(r.direction, r.direction)
    half_b = dot(oc, r.direction)

    c = dot(oc, oc) - s.r_squared
    discriminant = half_b^2 - a * c
    if (discriminant < 0)
        return false
    end

    sqrtd = sqrt(discriminant)

    # Nearest root that lies in the acceptable range
    root = (-half_b - sqrtd) / a
    if (root < ray_t.lo || root > ray_t.hi)
        root = (-half_b + sqrtd) / a
        if (root < ray_t.lo || root > ray_t.hi)
            return false
        end
    end

    rec.t = root
    rec.p = at(r, rec.t)
    outward_normal::Vector{Float64} = (rec.p - s.center) / s.radius
    set_face_normal!(rec, r, outward_normal)
    rec.mat = s.mat

    return true
end