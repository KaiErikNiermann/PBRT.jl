"""
    Triangle(v1::Vector{Float64}, v2::Vector{Float64}, v3::Vector{Float64}, material::Material)

A triangle defined by three vertices in 3D space, with a material and an axis-aligned bounding box (AABB).

- `v1`, `v2`, `v3` are the vertices of the triangle, represented as vectors of type `Vector{Float64}`.
- `id` is a unique identifier for the triangle.
- `edges` is a vector of sets, each containing two vertices that form the edges of the triangle.
- `mat` is the material of the triangle, which can be of type `Material`.
- `bbox` is the axis-aligned bounding box that encompasses the triangle.
"""
@kwdef struct Triangle <: Hittable
    v1::V3
    v2::V3
    v3::V3
    id::Int
    edges::Vector{Set{V3}}
    mat::Material
    bbox::AABB
end 

function compute_triangle(v1::Vector{Float64}, v2::Vector{Float64}, v3::Vector{Float64}, material::Material)::Triangle 
    u = v2 - v1
    v = v3 - v1
    
    Triangle(
        v1 = V3([v1...]), 
        v2 = V3([v2...]),
        v3 = V3([v3...]),
        id = rand(1:10000000000000000),
        edges = [Set([v1, v2]), Set([v2, v3]), Set([v3, v1])],
        mat = material,
        bbox = AABB(AABB(v1, v1 + u + v), AABB(v1 + u, v1 + v)), 
    )
end

function hit!(triangle::Triangle, ray::Ray, interval::Interval, record::HitRecord)::Bool
    edge1     = triangle.v2 - triangle.v1
    edge2     = triangle.v3 - triangle.v1
    normal    = normalize(cross(edge1, edge2))

    ray_cross_edge2 = cross(ray.direction, edge2)
    det             = edge1 ⋅ ray_cross_edge2

    @guard abs(det) < ϵ false 

    inv_det = 1.0 / det
    s       = ray.origin - triangle.v1
    u       = inv_det * (s ⋅ ray_cross_edge2)

    @guard !(0.0 < u < 1.0) false

    s_cross_edge1 = cross(s, edge1)
    v             = inv_det * (ray.direction ⋅ s_cross_edge1)

    @guard v < 0.0 || u + v > 1.0 false

    t = inv_det * edge2 ⋅ s_cross_edge1

    @guard !(interval.lo < t < interval.hi) false

    record.t   = t
    record.p   = at(ray, record.t)
    record.mat = triangle.mat
    
    set_face_normal!(record, ray, normal)
    
    true
end

export Triangle, compute_triangle, hit!