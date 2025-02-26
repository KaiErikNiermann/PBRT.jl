struct ray
    origin::Vector{Float64}
    direction::Vector{Float64}
    function ray(origin::Vector{Float64}, direction::Vector{Float64})
        new(origin, direction)
    end
    ray() = new([0.0, 0.0, 0.0], [0.0, 0.0, 0.0])
end

struct ray_itval 
    r::ray
    t::interval
end

"""
    at(r::ray, t::Float64)

Return the point at `t` along the ray `r`. Using the formula 
"""
function at(r::ray, t::Float64)::Vector{Float64} 
    r.origin + t * r.direction
end 