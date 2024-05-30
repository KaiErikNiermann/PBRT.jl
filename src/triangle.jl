struct triangle <: hittable
    A::Vector{Float64}
    B::Vector{Float64}
    C::Vector{Float64}
    bbox::aabb
    edges::Vector{Vector{Vector{Float64}}}
    triangle(A::Vector{Float64}, B::Vector{Float64}, C::Vector{Float64}) = begin 
        bbox = aabb()
        edges = [[A, B], [B, C], [C, A]]
        new(A, B, C, bbox, edges)
    end
end 

function hit!(t::triangle, r::ray, ray_t::interval, rec::hit_record)::Bool

end