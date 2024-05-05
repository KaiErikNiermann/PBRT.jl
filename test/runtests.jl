using PBRT
using Test

@testset "PBRT.jl" begin
    @test PBRT.testing() == "Hello, PBRT!"
end
