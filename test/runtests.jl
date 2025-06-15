using MiniRT
using Test
using StaticArrays
import LinearAlgebra: norm

@testset "Testing works" begin 
    @test 1 + 1 == 2
end 

@testset "Random Fns" begin 
    @test rand_f64() >= 0.0 && rand_f64() <= 1.0
    @test rand_f64(0.0, 1.0) >= 0.0 && rand_f64(0.0, 1.0) <= 1.0
    @test rand_i64(1, 10) >= 1 && rand_i64(1, 10) <= 10
    @test rand_rgbvec3().r <= 1.0 && rand_rgbvec3().g <= 1.0 && rand_rgbvec3().b <= 1.0
end

@testset "Interval" begin 
    @test Interval(1.0, 2.0).lo == 1.0
    @test Interval(1.0, 2.0).hi == 2.0
    @test MiniRT.size(Interval(1.0, 2.0)) == 1.0
    @test MiniRT.expand(0.1, Interval(1.0, 2.0)) == Interval(0.95, 2.05)
end

@testset "AABB" begin
    aabb1 = compute_aabb(Interval(1.0, 2.0), Interval(3.0, 4.0), Interval(5.0, 6.0))
    aabb2 = compute_aabb(Interval(2.0, 3.0), Interval(4.0, 5.0), Interval(6.0, 7.0))
    combined_aabb = AABB(aabb1, aabb2)

    @test MiniRT.size(combined_aabb.x) == 2.0
    @test MiniRT.size(combined_aabb.y) == 2.0
    @test MiniRT.size(combined_aabb.z) == 2.0
end

@testset "Triangle" begin
    v1 = [0.0, 0.0, 0.0]
    v2 = [1.0, 0.0, 0.0]
    v3 = [0.0, 1.0, 0.0]
    material = Metal(rand_rgbvec3(), 0.5)

    triangle = compute_triangle(v1, v2, v3, material)

    @test triangle.v1 == v1
    @test triangle.v2 == v2
    @test triangle.v3 == v3
    @test triangle.mat == material
end

@testset "Hit detection" begin 
    objects = reduce(
        push!, 
        [
            compute_sphere(V3_F64(0.0, 0.0, 0.0), 1.0),
            compute_sphere(V3_F64(2.0, 2.0, 2.0), 1.0),
            compute_sphere(V3_F64(-1.0, -1.0, -1.0), 1.5),
            compute_triangle(
                [1.0, 0.0, 0.0],
                [0.0, 1.0, 0.0],
                [0.0, 0.0, 1.0],
                Metal(rand_rgbvec3(), 0.5)
            )
        ], 
        init = HList()
    )

    bvh = compute_bvh(objects)

    @test hit!(bvh, Ray(V3_F64(1.0, 1.0, 1.0), V3_F64(1.0, 1.0, 1.0)), Interval(0.0, Inf), HRecord())
    @test hit!(bvh, Ray(V3_F64(0.0, 0.0, 0.0), V3_F64(1.0, 1.0, 1.0)), Interval(0.0, Inf), HRecord())
    @test !hit!(bvh, Ray(V3_F64(10.0, 10.0, 10.0), V3_F64(1.0, 1.0, 1.0)), Interval(0.0, Inf), HRecord())
end

@testset "Empty image" begin
    render_scene(nothing)

    @test isfile("image.ppm")
    @test filesize("image.ppm") > 0
end