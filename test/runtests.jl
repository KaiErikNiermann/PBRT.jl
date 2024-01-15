using juliaThesis
using Test

@testset "juliaThesis.jl" begin
    @test juliaThesis.greet_your_package_name() == "Hello, juliaThesis!"
end
