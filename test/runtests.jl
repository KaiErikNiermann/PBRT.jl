using PBRT
using Test

@testset "PBRT.jl" begin
    @test PBRT.greet_your_package_name() == "Hello, PBRT!"
end
