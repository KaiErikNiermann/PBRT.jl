struct Triangle <: hittable
    A::Vector{Float64}
    B::Vector{Float64}
    C::Vector{Float64}
    bbox::aabb
    edges::Vector{Set{Vector{Float64}}}
    Triangle(A::Vector{Float64}, B::Vector{Float64}, C::Vector{Float64}) = begin 
        bbox_diag1 = aabb(A, A + B + C)
        bbox_diag2 = aabb(A + B, A + C)
        bbox = aabb(bbox_diag1, bbox_diag2)
        edges = [Set([A, B]), Set([B, C]), Set([C, A])]
        new(A, B, C, bbox, edges)
    end
end 

Base.show(io::IO, t::Triangle) = print(io, "Triangle($(t.A), $(t.B), $(t.C))")

function hit!(t::Triangle, r::ray, ray_t::interval, rec::hit_record)::Bool
    false
end