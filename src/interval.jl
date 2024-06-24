mutable struct interval{T<:Real}
    lo::T
    hi::T
end

function size(a::interval)::Float64
    return a.hi - a.lo
end

interval() = interval(Inf, -Inf)

function interval(a::interval, b::interval)::interval
    interval(min(a.lo, b.lo), max(a.hi, b.hi))
end

function expand(delta::Float64, intval::interval)::interval
    padding = delta / 2.0
    interval(intval.lo - padding, intval.hi + padding)
end