struct Ray
    origin::Vector{Float64}
    direction::Vector{Float64}
    function Ray(origin::Vector{Float64}, direction::Vector{Float64})
        new(origin, direction)
    end
    Ray() = new([0.0, 0.0, 0.0], [0.0, 0.0, 0.0])
end

struct RayData 
    ray::Ray
    interval::Interval
end

"""
    at(r::ray, t::Float64)

Return the point at `t` along the ray `r`. Using the formula 
"""
function at(r::Ray, t::Float64)::Vector{Float64} 
    r.origin + t * r.direction
end 