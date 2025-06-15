import Base: +, -, *

const ϵ                = 1e-8
const DEF_ASPECT_RATIO = 16.0 / 9.0

struct RGBVec3
    data::V3
end 

RGBVec3() = RGBVec3(@vec3 0.0, 0.0, 0.0)
RGBVec3(r::Float64, g::Float64, b::Float64) = RGBVec3(@vec3 r, g, b)

+(c1::RGBVec3, c2::RGBVec3)::RGBVec3 = 
    RGBVec3(c1.data + c2.data)
-(c1::RGBVec3, c2::RGBVec3)::RGBVec3 =
    RGBVec3(c1.data - c2.data)
*(c::RGBVec3, s::Float64)::RGBVec3 =
    RGBVec3(c.data * s)
*(s::Float64, c::RGBVec3)::RGBVec3 =
    RGBVec3(c.data * s)
*(c1::RGBVec3, c2::RGBVec3)::RGBVec3 =
    RGBVec3(c1.data .* c2.data)

Base.getproperty(c::RGBVec3, s::Symbol) = 
    s === :r ? c.data[1] :
    s === :g ? c.data[2] :
    s === :b ? c.data[3] :
    getfield(c, s)

function split_quad(vertices)
    v1, v2, v3, v4 = vertices

    mat() = Metal(rand_rgbvec3(), 0.0)

    return norm(v1 - v3) <= norm(v2 - v4) ? [
        compute_triangle(v1, v2, v3, mat()),
        compute_triangle(v1, v4, v3, mat())
    ] : [
        compute_triangle(v1, v2, v4, mat()),
        compute_triangle(v2, v4, v3, mat())
    ]
end

unit_v(v::V3)::V3 = v ./ norm(v)

norm_coords(pos::V2, dims::Vector{Int64})::V2 = 
    (pos .+ rand_f64()) ./ (dims .- 1)

rand_rgbvec3()::RGBVec3 = 
    RGBVec3(@vec3 rand([0.0, 1.0]), rand([0.0, 1.0]), rand([0.0, 1.0]))

rand_f64vec3()::V3 = 
    @vec3 rand_f64(), rand_f64(), rand_f64()

rand_f64vec3(min::Float64, max::Float64)::V3 = 
    @vec3 rand_f64(min, max), rand_f64(min, max), rand_f64(min, max)

rand_f64()::Float64 = 
    rand(Uniform(0.0, 1.0))

rand_f64(min::Float64, max::Float64)::Float64 = 
    min + (max - min) * rand_f64() 

rand_i64(min::Int64, max::Int64)::Int64 = 
    trunc(Int64, rand_f64(Float64(min), Float64(max)))

rand_unit_v() = 
    normalize(random_in_unit_sphere())

near_zero(vec::V3)::Bool = 
    all(abs.(vec) .< ϵ)

reflect(v::V3, n::V3)::V3 = 
    v + 2.0 * (-n ⋅ v) * n

function random_in_unit_sphere()
    while true
        p = rand_f64(-1.0, 1.0)
        if norm(p) >= 1.0  
            continue
        end
        return p
    end
end

function random_in_unit_disk()
    while true
        p = @vec3 rand_f64(-1.0, 1.0), rand_f64(-1.0, 1.0), 0.0
        if p ⋅ p >= 1
            continue
        end
        return p
    end
end

function random_in_hemisphere(normal::V3)::V3
    in_unit_sphere = random_in_unit_sphere()

   (in_unit_sphere ⋅ normal) > 0.0 ? in_unit_sphere : -in_unit_sphere
end 

@doc raw"""
    refract(uv::V3, n::V3, r::Float64)::V3

Refract a vector `uv` with respect to a normal `n` and a refraction index `r`.

```math
\begin{equation}
    \underbrace{\frac{\eta}{\eta '}(\mathbf R + |\mathbf R|\cos \theta \mathbf n)}_{\mathbf R'_\perp\text{ - perpendicular ray}} + \underbrace{-\sqrt{1 - |\mathbf R'_\perp|^2 \mathbf n}}_{\mathbf R'_\parallel \text{ - parallel ray}}
\end{equation}
```
"""
function refract(uv::V3, n::V3, r)::V3 
    cosθ            = min((-uv ⋅ n), 1)
    r_out_perp      = r * (uv + cosθ * n)
    r_out_parallel  = -sqrt(abs(1.0 - r^2 * (1 - cosθ^2))) * n

    r_out_perp + r_out_parallel
end

@doc raw"""
    reflectance(cosθ::Float64, ref_idx::Float64)::Float64

Schlick's approximation for reflectance. 

```math 
\begin{equation}
    R(\theta) = R_0 + (1 - R_0) \cdot (1 - \cos \theta)^5 \quad \text{where} \quad R_0 = \left(\frac{1 - n}{1 + n}\right)^2
\end{equation}
```
"""
function reflectance(cosθ, ref_idx)::Float64
    r0 = ((1 - ref_idx) / (1 + ref_idx))^2
    (r0 + (1 - r0) * (1 - cosθ)^5) # R(θ)
end

export RGBVec3
export rand_f64, rand_f64vec3, rand_rgbvec3, rand_unit_v, norm_coords, unit_v, rand_f64, rand_f64vec3, rand_f64vec3, rand_i64   