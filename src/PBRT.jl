module PBRT

using Base
using LinearAlgebra
using Distributions
using PProf
using Profile
using StaticArrays
using ProgressBars
using BenchmarkTools

include("testing.jl")

export foo
export gen_img
export custom_scene
export example_render

using Match

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
include("scene.jl")

include("obj_reader.jl")
include("RayTracer.jl")

end
