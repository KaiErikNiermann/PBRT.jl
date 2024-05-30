struct triangle <: hittable
    x::Float64
    y::Float64
    z::Float64
    bbox::aabb
    edges::Vector{Vector{Int64}}
    triangle(x, y, z) = new(x, y, z, aabb(), Vector{Vector{Int64}}())
end 

function hit!(t::triangle, r::ray, ray_t::interval, rec::hit_record)::Bool

end