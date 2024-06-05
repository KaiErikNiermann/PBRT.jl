struct Triangle <: hittable
    A::Vector{Float64}
    B::Vector{Float64}
    C::Vector{Float64}
    bbox::aabb
    id::Int
    mat::material
    edges::Vector{Set{Vector{Float64}}}
    Triangle(A::Vector{Float64}, B::Vector{Float64}, C::Vector{Float64}, mat::material) = begin 
        bbox_diag1 = aabb(A, A + B + C)
        bbox_diag2 = aabb(A + B, A + C)
        bbox = aabb(bbox_diag1, bbox_diag2)
        edges = [Set([A, B]), Set([B, C]), Set([C, A])]
        id = rand(1:10000000000000000)
        new(A, B, C, bbox, id, mat, edges)
    end
end 

Base.show(io::IO, t::Triangle) = print(io, "Triangle(id = $(t.id))")

function hit!(t::Triangle, r::ray, ray_t::interval, rec::hit_record)::Bool
    # Möller–Trumbore intersection algorithm
    e1 = t.B - t.A
    e2 = t.C - t.A
    h = cross(r.direction, e2)
    a = dot(e1, h)
    
    # Check if the ray is parallel to the triangle
    if abs(a) < EPSILON
        return false
    end
    
    f = 1.0 / a
    s = r.origin - t.A
    u = f * dot(s, h)
    
    # Check if the intersection is outside the triangle
    if u < 0.0 || u > 1.0
        return false
    end
    
    q = cross(s, e1)
    v = f * dot(r.direction, q)
    
    # Check if the intersection is outside the triangle
    if v < 0.0 || u + v > 1.0
        return false
    end

    t_val = f * dot(e2, q)
    
    # Check if the intersection is outside the valid t range
    if t_val > ray_t.hi || t_val < ray_t.lo
        return false
    end
    
    # Update the hit record with intersection information
    rec.t = t_val
    rec.p = at(r, rec.t)
    outward_normal = normalize(cross(e1, e2))
    set_face_normal!(rec, r, outward_normal)
    rec.mat = t.mat
    
    true
end