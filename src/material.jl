abstract type Material end

"""
    Lambertian(albedo::RGBVec3)

Lambertian material, typically used for diffuse or matte surfaces.

- `albedo` is the color of the material, represented as an RGB vector.
"""
mutable struct Lambertian <: Material
    albedo::RGBVec3
    Lambertian(albedo::RGBVec3) = new(albedo)
    Lambertian() = new(RGBVec3((0.0, 0.0, 0.0)))
end

"""
    Metal(albedo::RGBVec3, fuzz::Float64)

Metal material with fuzziness

-  `albedo` is the color of the material, represented as an RGB vector.
-  `fuzz` is the fuzziness factor, which should be between 0.0 and 1.0.
"""
mutable struct Metal <: Material
    albedo::RGBVec3
    fuzz::Float64 

    Metal(albedo::RGBVec3) = new(albedo, 0.0)
    Metal(albedo::RGBVec3, fuzz::Float64) = new(albedo, clamp(fuzz, 0.0, 1.0))
end

"""
    Dielectric(ir::Float64)

Dielectric material, typically used for glass or water

- `ir` is the index of refraction. (default is 0)
"""
mutable struct Dielectric <: Material
    ir::Float64
    Dielectric(ir::Float64) = new(ir)
    Dielectric() = new(0)
end

export Material, Lambertian, Metal, Dielectric
