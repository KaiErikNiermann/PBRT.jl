module MiniRT
using Base
using LinearAlgebra
using Distributions
using PProf
using Profile
using StaticArrays
using ProgressBars
using BenchmarkTools
using InteractiveUtils
using Match

include("macros.jl")
include("util.jl")
include("interval.jl")
include("ray.jl")
include("material.jl")
include("hittable.jl")
include("aabb.jl")
include("sphere.jl")
include("triangle.jl")
include("hittable_list.jl")
include("bvh.jl") 
include("camera.jl")
include("obj_reader.jl")
include("scene.jl")
include("main.jl")

test(str) = begin
    @info "MiniRT.jl test function called with argument: $str"
    open("test.txt", "w") do file
        write(file, "Test successful with argument: $str\n")
    end
end

hello() = begin 
    @info "MiniRT.jl initialized successfully."
    return true
end
end
