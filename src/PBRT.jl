module PBRT

using Base
using LinearAlgebra
using Distributions

include("testing.jl")

export foo
export gen_img

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
