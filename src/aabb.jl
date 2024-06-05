mutable struct aabb
    x::interval{Float64}
    y::interval{Float64}
    z::interval{Float64}

    # constructors
    aabb() = 
        new(interval(0.0, 0.0), interval(0.0, 0.0), interval(0.0, 0.0))

    aabb(x::interval{Float64}, y::interval{Float64}, z::interval{Float64}) = 
        new(x, y, z)

    aabb(p0::Vector{Float64}, p1::Vector{Float64}) = 
        new(
            interval(min(p0[1], p1[1]), max(p0[1], p1[1])),
            interval(min(p0[2], p1[2]), max(p0[2], p1[2])),
            interval(min(p0[3], p1[3]), max(p0[3], p1[3])
        ))

    aabb(a::aabb, b::aabb) = 
        new(interval(a.x, b.x), interval(a.y, b.y), interval(a.z, b.z))
end

function pad_to_min(bbox::aabb)::bbox
    delta = 0.0001
    if size(bbox.x) < delta
        bbox.x = expand(delta, bbox.x)
    end 
    if size(bbox.y) < delta
        bbox.y = expand(delta, bbox.y)
    end
    if size(bbox.z) < delta
        bbox.z = expand(delta, bbox.z)
    end
    return bbox
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

function hit!(bbox::aabb, r::ray, ray_t::interval)::Bool
    ray_orig = r.origin
    ray_dir = r.direction

    for axis in 1:3
        ax = axis_interval(bbox, axis)
        adinv = 1.0 / ray_dir[axis]

        t0 = (ax.lo - ray_orig[axis]) * adinv
        t1 = (ax.hi - ray_orig[axis]) * adinv

        if t0 < t1
            if t0 > ray_t.lo
                ray_t.lo = t0
            end
            if t1 < ray_t.hi
                ray_t.hi = t1
            end
        else
            if t1 > ray_t.lo
                ray_t.lo = t1
            end
            if t0 < ray_t.hi
                ray_t.hi = t0
            end
        end
        
        if ray_t.hi <= ray_t.lo
            return false
        end
    end
    return true
end