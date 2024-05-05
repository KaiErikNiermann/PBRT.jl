using PBRT
using Test

@testset "PBRT.jl" begin
    @test PBRT.foo() == "Hello, PBRT!"
end
