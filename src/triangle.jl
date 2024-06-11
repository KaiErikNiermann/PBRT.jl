struct Triangle <: hittable
    A::Vector{Float64}
    B::Vector{Float64}
    C::Vector{Float64}
    id::Int
    edges::Vector{Set{Vector{Float64}}}
    mat::material
    bbox::aabb
    end 
Triangle(A::Vector{Float64}, B::Vector{Float64}, C::Vector{Float64}, mat::material) = begin 
    u = B - A
    v = C - A
    bbox_diag1 = aabb(A, A + u + v)
    bbox_diag2 = aabb(A + u, A + v)
    bbox = aabb(bbox_diag1, bbox_diag2)
    edges = [Set([A, B]), Set([B, C]), Set([C, A])]
    id = rand(1:10000000000000000)
    Triangle(A, B, C, id, edges, mat, bbox)
end

Base.show(io::IO, t::Triangle) = print(io, "Triangle(id = $(t.id))")

function hit!(t::Triangle, r::ray, ray_t::interval, rec::hit_record)::Bool
    e1 = t.B - t.A
    e2 = t.C - t.A
    normal = normalize(cross(e1, e2))

    ray_cross_e2 = cross(r.direction, e2)
    det = dot(e1, ray_cross_e2)

    if det > -0.0001 && det < 0.0001
        return false
    end

    inv_det = 1.0 / det
    s = r.origin - t.A
    u = inv_det * dot(s, ray_cross_e2)
    if u < 0.0 || u > 1.0
        return false
    end

    s_cross_e1 = cross(s, e1)
    v = inv_det * dot(r.direction, s_cross_e1)

    if v < 0.0 || u + v > 1.0
        return false
    end

    t_val = inv_det * dot(e2, s_cross_e1)

    if t_val < ray_t.lo || t_val > ray_t.hi
        return false
    end
    
    # Update the hit record with intersection information
    rec.t = t_val
    rec.p = at(r, rec.t)
    set_face_normal!(rec, r, normal)
    rec.mat = t.mat
    
    true
end

