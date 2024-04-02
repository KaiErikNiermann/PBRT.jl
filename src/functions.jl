using CUDA
using PyCall

"""
    greet_your_package_name()

Return a greeting message.
"""
function greet_your_package_name()
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