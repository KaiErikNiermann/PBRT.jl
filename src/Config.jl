module Config
export V2_ref, V3_ref, init!
using StaticArrays
abstract type ModeTag end
struct Static  <: ModeTag end
struct Dynamic <: ModeTag end

Vec2(::Type{Dynamic}) = Vector{Float64}
Vec3(::Type{Dynamic}) = Vector{Float64}
Vec2(::Type{Static})  = SVector{2,Float64}
Vec3(::Type{Static})  = SVector{3,Float64}

const V2_ref = Ref{DataType}()   
const V3_ref = Ref{DataType}()

function init!(mode::Symbol)
    T = mode == :static  ? Static  :
    mode == :dynamic ? Dynamic :
    error("Invalid vector mode: $mode")
    
    @info "Vector mode : $T"
    V2_ref[] = Vec2(T)
    V3_ref[] = Vec3(T)
end

end 
