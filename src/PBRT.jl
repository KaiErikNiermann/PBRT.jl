module PBRT

using Base
using LinearAlgebra
using Distributions

include("testing.jl")

export foo
export gen_img

include("util.jl")
include("ray.jl")
include("material.jl")
include("hittable.jl")
include("sphere.jl")
include("hittable_list.jl")
include("camera.jl")
include("scene.jl")

include("RayTracer.jl")

end
