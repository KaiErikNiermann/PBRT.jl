import Base: +, -, *

struct color
    r::Float32
    g::Float32
    b::Float32
    function color(c)
        new(c[1], c[2], c[3])
    end
    color() = new(0.0, 0.0, 0.0)
end

-(v::Vector{Float64}, sc::Float64) = [v[1] - sc, v[2] - sc, v[3] - sc]

+(v::Vector{Float64}, sc::Float64) = [v[1] + sc, v[2] + sc, v[3] + sc]

*(v::Vector{Float64}, sc::Float64) = [v[1] * sc, v[2] * sc, v[3] * sc]

+(c1::color, c2::color)::color = color([c1.r .+ c2.r, c1.g .+ c2.g, c1.b .+ c2.b])

*(t::Float64, c::color)::color = color([t .* c.r, t .* c.g, t .* c.b])

*(c1::color, c2::color)::color = color([c1.r .* c2.r, c1.g .* c2.g, c1.b .* c2.b])

@inline function random()::Vector{Float64}
    Vector{Float64}(random_double(), random_double(), random_double())
end

@inline function random(min::Float64, max::Float64)::Vector{Float64}
    [random_double(min, max), random_double(min, max), random_double(min, max)]
end

random_double()::Float64 = rand(Uniform(0.0, 1.0))

random_double(min::Float64, max::Float64)::Float64 = min + (max - min) * random_double() 

random_int(min::Int, max::Int)::Int = rand(Uniform(min, max + 1))

random_unit_vector() = normalize(random_in_unit_sphere())

@inline function random_in_unit_sphere()
    while true
        p = random(-1.0, 1.0)
        if(norm(p) >= 1.0)  
            continue
        end
        return p
    end
end

@inline function random_in_unit_disk()
    while(true)
        p = [random_double(-1.0, 1.0), random_double(-1.0, 1.0), 0]
        if(dot(p, p) >= 1)
            continue
        end
        return p
    end
end

@inline function random_in_hemisphere(normal::Vector{Float64})::Vector{Float64}
    in_unit_sphere = random_in_unit_sphere()
    ifelse(dot(in_unit_sphere, normal) > 0.0, in_unit_sphere, -in_unit_sphere)
end 

const EPSILON = 1e-8

@inline function near_zero(vec::Vector{Float64})::Bool
    (abs(vec[1]) < EPSILON) && (abs(vec[2]) < EPSILON) && (abs(vec[3]) < EPSILON)
end

reflect(v::Vector{Float64}, n::Vector{Float64})::Vector{Float64} = v + 2.0 * dot(-n, v) * n

@doc raw"""
    refract(uv::Vector{Float64}, n::Vector{Float64}, r::Float64)::Vector{Float64}

Refract a vector `uv` through a normal `n` with a refractive index `r`. Uses Snell's Law to calculate the refracted vector.

"""
@inline function refract(uv::Vector{Float64}, n::Vector{Float64}, r)::Vector{Float64} 
    cos_theta = min(dot(-uv, n), 1)
    r_out_perp = r * (uv + cos_theta * n)
    r_out_parallel = -sqrt(abs(1.0 - r^2 * (1 - cos_theta^2))) * n
    r_out_perp + r_out_parallel
end

@inline function reflectance(cosine, ref_idx)::Float64
    r0 = ((1 - ref_idx) / (1 + ref_idx))^2
    r0 + (1 - r0) * (1 - cosine)^5
end