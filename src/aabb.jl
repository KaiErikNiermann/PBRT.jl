mutable struct aabb
    x::interval{Float64}
    y::interval{Float64}
    z::interval{Float64}

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
    aabb() = 
        pad_to_min(interval(0.0, 0.0), interval(0.0, 0.0), interval(0.0, 0.0))

    aabb(x::interval{Float64}, y::interval{Float64}, z::interval{Float64}) = 
        pad_to_min(x, y, z)

    aabb(p0::Vector{Float64}, p1::Vector{Float64}) = 
        pad_to_min(
            interval(min(p0[1], p1[1]), max(p0[1], p1[1])),
            interval(min(p0[2], p1[2]), max(p0[2], p1[2])),
            interval(min(p0[3], p1[3]), max(p0[3], p1[3])
        ))

    aabb(a::aabb, b::aabb) = 
        pad_to_min(interval(a.x, b.x), interval(a.y, b.y), interval(a.z, b.z))
end

function longest_axis(bbox::aabb)
    if size(bbox.x) > size(bbox.y)
        return size(bbox.x) > size(bbox.z) ? 1 : 3
    else
        return size(bbox.y) > size(bbox.z) ? 2 : 3
    end
end

function axis_interval(bbox::aabb, axis::Int)::interval
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
function hit(bbox::aabb, r::ray, ray_t::interval)::Bool
    println("julia hit")
    r_lo = ray_t.lo
    r_hi = ray_t.hi
    for axis in 1:3
        ax = axis_interval(bbox, axis)
        adinv = r.direction[axis] != 0.0 ? 1.0 / r.direction[axis] : Inf
        
        # t0 and t1 are the intersection points of the ray with the slab
        t0 = (ax.lo - r.origin[axis]) * adinv
        t1 = (ax.hi - r.origin[axis]) * adinv

        # swap t0 and t1 if the slab is entered from the wrong side
        if adinv < 0.0
            t0, t1 = t1, t0
        end
   
        # update the ray_t interval to reflect closest intersection
        r_lo = max(r_lo, t0)
        r_hi = min(r_hi, t1)

        # if the slab intersection is empty, the ray misses the box
        if r_hi <= r_lo
            return false
        end
    end
    return true
end

