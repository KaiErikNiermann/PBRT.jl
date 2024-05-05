mutable struct aabb
    x::interval{Float64}
    y::interval{Float64}
    z::interval{Float64}
    function aabb()
        new(interval(0.0, 0.0), interval(0.0, 0.0), interval(0.0, 0.0))
    end

    function aabb(x::interval{Float64}, y::interval{Float64}, z::interval{Float64})
        new(x, y, z)
    end

    function aabb(p0::Vector{Float64}, p1::Vector{Float64})
        new(interval(min(p0[1], p1[1]), max(p0[1], p1[1])),
            interval(min(p0[2], p1[2]), max(p0[2], p1[2])),
            interval(min(p0[3], p1[3]), max(p0[3], p1[3])))
    end

    function aabb(a::aabb, b::aabb)
        new(interval(a.x, b.x),
            interval(a.y, b.y),
            interval(a.z, b.z))
    end
end

function axis_interval(a::aabb, axis::Int)
    if axis == 1
        return a.x
    end
    if axis == 2
        return a.y
    end
end

@doc raw"""
    hit!(r::ray, a::aabb, t::interval)::Bool

Check if a ray intersects an axis-aligned bounding box. Function uses formula 

```math
\textbf t = \frac{r(t) - \textbf o}{\mathbf d}
```
"""
function hit!(r::ray, ray_t::interval)::Bool
    ray_orig = r.origin
    ray_dir = r.direction

    for axis in 1:3
        ax = axis_interval(ray_t, axis)
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