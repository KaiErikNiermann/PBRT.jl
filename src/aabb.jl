mutable struct AABB
    x::Interval{Float64}
    y::Interval{Float64}
    z::Interval{Float64}
end

function pad_to_min(x, y, z)
    Δ = 0.0001

    if size(x) < Δ
        x = expand(Δ, x)
    end 
    
    if size(y) < Δ
        y = expand(Δ, y)
    end
    
    if size(z) < Δ
        z = expand(Δ, z)
    end

    AABB(x, y, z)
end


AABB() = 
    pad_to_min(Interval(0.0, 0.0), Interval(0.0, 0.0), Interval(0.0, 0.0))

compute_aabb(x::Interval{Float64}, y::Interval{Float64}, z::Interval{Float64}) = 
    pad_to_min(x, y, z)

AABB(p0::V3, p1::V3) = 
    pad_to_min(
        Interval(min(p0[1], p1[1]), max(p0[1], p1[1])),
        Interval(min(p0[2], p1[2]), max(p0[2], p1[2])),
        Interval(min(p0[3], p1[3]), max(p0[3], p1[3])
    ))

AABB(p0::Vector{Float64}, p1::Vector{Float64}) = 
    pad_to_min(
        Interval(min(p0[1], p1[1]), max(p0[1], p1[1])),
        Interval(min(p0[2], p1[2]), max(p0[2], p1[2])),
        Interval(min(p0[3], p1[3]), max(p0[3], p1[3])
    ))

AABB(a::AABB, b::AABB) = 
    pad_to_min(Interval(a.x, b.x), Interval(a.y, b.y), Interval(a.z, b.z))

function longest_axis(bbox::AABB)
    if size(bbox.x) > size(bbox.y)
        return size(bbox.x) > size(bbox.z) ? 1 : 3
    else
        return size(bbox.y) > size(bbox.z) ? 2 : 3
    end
end

function axis_interval(bbox::AABB, axis::Int)::Interval
    if axis == 2
        return bbox.y
    elseif axis == 3
        return bbox.z
    end
    return bbox.x
end

function hit!(bbox::AABB, ray::Ray, interval::Interval)::Bool
    r_lo = interval.lo
    r_hi = interval.hi
    
    for axis in 1:3
        ax    = axis_interval(bbox, axis)
        adinv = ray.direction[axis] != 0.0 ? 1.0 / ray.direction[axis] : Inf
        
        t0 = (ax.lo - ray.origin[axis]) * adinv
        t1 = (ax.hi - ray.origin[axis]) * adinv

        if adinv < 0.0
            t0, t1 = t1, t0
        end

        @guard min(r_hi, t1) <= max(r_lo, t0) false
    end
    
    true
end

export AABB, longest_axis, axis_interval, hit!, pad_to_min, compute_aabb