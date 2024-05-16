using PBRT
using Test

@testset "PBRT.jl" begin
    @test PBRT.foo() == "Hello, PBRT!"

    @test PBRT.basic_scene().img.width == 400
end
