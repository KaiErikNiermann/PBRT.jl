import Base: ==

mutable struct Interval
    lo::Float64
    hi::Float64
    
    Interval(lo::Float64, hi::Float64)  = 
        new(lo, hi)
    
    Interval(a::Interval, b::Interval)  = 
        new(min(a.lo, b.lo), max(a.hi, b.hi))
end

size(a::Interval)::Float64 = a.hi - a.lo

expand(delta::Float64, i::Interval)::Interval = Interval(i.lo - delta/2, i.hi + delta/2)

==(a::Interval, b::Interval)::Bool =
    a.lo == b.lo && a.hi == b.hi

export Interval, size, expand