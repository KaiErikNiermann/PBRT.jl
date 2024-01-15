using CUDA

function greet_your_package_name()
    x_d = CUDA.fill(1.0, (2, 2))
    return "Hello, juliaThesis!"
end