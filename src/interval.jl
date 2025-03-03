mutable struct Interval{T<:Real}
    lo::T
    hi::T
end

function size(a::Interval)::Float64
    return a.hi - a.lo
end

Interval() = Interval(Inf, -Inf)

function Interval(a::Interval, b::Interval)::Interval
    Interval(min(a.lo, b.lo), max(a.hi, b.hi))
end

function expand(delta::Float64, intval::Interval)::Interval
    padding = delta / 2.0
    Interval(intval.lo - padding, intval.hi + padding)
end