using CUDA
using PythonCall

"""
    foo()

Return a greeting message.
"""
function foo()
    for (i,device) in enumerate(CUDA.devices())
        println("*** General properties for device $i ***")
        name = CUDA.name(device)
        println("Device name: $name")
        major = CUDA.attribute(device, CUDA.CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR)
        minor = CUDA.attribute(device, CUDA.CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR)
        println("Compute capabilities: $major.$minor")
        clock_rate = CUDA.attribute(device, CUDA.CU_DEVICE_ATTRIBUTE_CLOCK_RATE)
        println("Clock rate: $clock_rate")
        device_overlap = CUDA.attribute(device, CUDA.CU_DEVICE_ATTRIBUTE_GPU_OVERLAP)
        print("Device copy overlap: ")
        println(device_overlap > 0 ? "enabled" : "disabled")
        kernel_exec_timeout = CUDA.attribute(device, CUDA.CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT)
        print("Kernel execution timeout: ")
        println(kernel_exec_timeout > 0 ? "enabled" : "disabled")
    end
    return "Hello, PBRT!"
end

mutable struct Point{Float64}
    _x::Float64
    _y::Float64
end
    
# array
function data_pass_test()
    a = [1.0, 2.0]
    return a
end

function point_pass_test(p::Point)
    return p
end

# julia function to convert point to pytype
function point_to_pytype(p)
    return @py [p._x, p._y]
end

function time_sleep()
    sleep(10)
    return "Done"
end

function a()
    println("a")
    p = Point(1.0, 2.0)
    println(p)
    for i in 1:10
        b(p)
    end
    println(p)
    c()
end

function b(p::Point)
    println("point in jl $(p)")
end

function c()
    println("c")
end

abstract type A end 

mutable struct B <: A
    str::String
end

mutable struct C <: A
    val::A
end

mutable struct D <: A
    val::A
end

abstract type s1 end

abstract type s2 end

mutable struct var"s2*"
    var"s2*"() = new()
end

mutable struct d1 <: s1
    albedo::Vector{Float64}
    d1() = new()
end

mutable struct var"d1*"
    var"d1*"() = new()
end

mutable struct a1 <: s2
    val::s1
    a1() = new()
end

mutable struct var"a1*"
    var"a1*"() = new()
end