mutable struct AABB
    x::Interval
    y::Interval
    z::Interval
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
    
    AABB() = 
        pad_to_min(Interval(0.0, 0.0), Interval(0.0, 0.0), Interval(0.0, 0.0))
    
    AABB(a::AABB, b::AABB) = 
        pad_to_min(Interval(a.x, b.x), Interval(a.y, b.y), Interval(a.z, b.z))
        
    AABB(x::Interval, y::Interval, z::Interval) = 
        pad_to_min(x, y, z)
    
    AABB(p0::Vec3, p1::Vec3) = 
        pad_to_min(
            Interval(min(p0[1], p1[1]), max(p0[1], p1[1])),
            Interval(min(p0[2], p1[2]), max(p0[2], p1[2])),
            Interval(min(p0[3], p1[3]), max(p0[3], p1[3]))
        )
end


axis_longest(bbox::AABB) = argmax((size(bbox.x), size(bbox.y), size(bbox.z)))

axis_interval(bbox::AABB, axis::Int)::Interval = (bbox.x, bbox.y, bbox.z)[axis]

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

export AABB, axis_longest, axis_interval, hit!, pad_to_min, compute_aabb