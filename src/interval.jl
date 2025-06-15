import Base: ==

mutable struct Interval{T <: Real}
    lo::T
    hi::T
    
    Interval(lo::T, hi::T) where {T <: Real} = 
        new{T}(lo, hi)
    
    Interval(a::Interval{T}, b::Interval{T}) where {T <: Real} = 
        new{T}(min(a.lo, b.lo), max(a.hi, b.hi))
end

size(a::Interval)::Float64 = a.hi - a.lo

expand(Δ::Float64, i::Interval)::Interval = Interval(i.lo - Δ/2, i.hi + Δ/2)

==(a::Interval, b::Interval)::Bool =
    a.lo == b.lo && a.hi == b.hi

export Interval, size, expand