mutable struct AABB
    x::Interval{Float64}
    y::Interval{Float64}
    z::Interval{Float64}

    function pad_to_min(x, y, z)
        delta = 0.0001
        if size(x) < delta
            x = expand(delta, x)
        end 
        if size(y) < delta
            y = expand(delta, y)
        end
        if size(z) < delta
            z = expand(delta, z)
        end

        new(x, y, z)
    end

    # constructors
    AABB() = 
        pad_to_min(Interval(0.0, 0.0), Interval(0.0, 0.0), Interval(0.0, 0.0))

    AABB(x::Interval{Float64}, y::Interval{Float64}, z::Interval{Float64}) = 
        pad_to_min(x, y, z)

    AABB(p0::Vector{Float64}, p1::Vector{Float64}) = 
        pad_to_min(
            Interval(min(p0[1], p1[1]), max(p0[1], p1[1])),
            Interval(min(p0[2], p1[2]), max(p0[2], p1[2])),
            Interval(min(p0[3], p1[3]), max(p0[3], p1[3])
        ))

    AABB(a::AABB, b::AABB) = 
        pad_to_min(Interval(a.x, b.x), Interval(a.y, b.y), Interval(a.z, b.z))
end

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

"""
Slab method for AABB intersection
"""
function hit!(bbox::AABB, r::Ray, ray_t::Interval)::Bool
    r_lo = ray_t.lo
    r_hi = ray_t.hi
    for axis in 1:3
        ax = axis_interval(bbox, axis)
        adinv = r.direction[axis] != 0.0 ? 1.0 / r.direction[axis] : Inf
        
        t0 = (ax.lo - r.origin[axis]) * adinv
        t1 = (ax.hi - r.origin[axis]) * adinv

        if adinv < 0.0
            t0, t1 = t1, t0
        end
   
        r_lo = max(r_lo, t0)
        r_hi = min(r_hi, t1)

        if r_hi <= r_lo
            return false
        end
    end
    return true
end

