module Types

using StaticArrays

abstract type Mode end
struct Static <: Mode end
struct Dynamic <: Mode end

Point3D(::Type{Static})  = SVector{3, Float64}
Point3D(::Type{Dynamic}) = Vector{Float64}

Point2D(::Type{Static})  = SVector{2, Float64}
Point2D(::Type{Dynamic}) = Vector{Float64}  

export Mode, Static, Dynamic, AppConfig, Point2D, Point3D

function mode_set(mode::Symbol) 
    mode == :static ? Static : 
    mode == :dynamic ? Dynamic :
    error("Invalid mode: $mode. Use :static or :dynamic.") 
end

export Static, Dynamic, mode_set

end # module Types