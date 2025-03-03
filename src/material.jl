abstract type Material end

struct Lambertian <: Material
    albedo::Color
end

struct Metal <: Material
    albedo::Color
    fuzz::Float64   
    Metal(a::Color) = new(a, 0.0)

    function Metal(a::Color, f::Float64)
        if(f < 1)
            new(a, f)
        else
            new(a, 1.0)
        end
    end
end

struct Dielectric <: Material
    ir::Float64
    Dielectric(i::Float64) = new(i)
    Dielectric() = new(0)
end



