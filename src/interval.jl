struct interval{T<:Real}
    lo::T
    hi::T
end

interval() = interval(Inf, -Inf)

function interval(a::interval, b::interval)::interval
    interval(min(a.lo, b.lo), max(a.hi, b.hi))
end

function expand(delta::Float64)::interval
    padding = delta / 2.0
    interval(0.0 - padding, 0.0 + padding)
end