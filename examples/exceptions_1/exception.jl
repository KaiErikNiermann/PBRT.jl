using Libdl

# Load the shared library
lib = Libdl.dlopen("./libexception.so")

# Define the function signature
function add_with_cb(a::Cint, b::Cint, cb::Ptr{Nothing})::Cint
    ccall((:add_with_cb, lib), Cint, (Cint, Cint, Ptr{Nothing}), a, b, cb)
end

# Define the callback function
function add_julia_cb(a::Cint, b::Cint)::Cint
    if a == 0
        throw(ArgumentError("a is 0"))
    end
    return a + b
end

# Convert the Julia function to a C function pointer
callback = @cfunction(add_julia_cb, Cint, (Cint, Cint))

# Call the function with the callback
try
    println(add_with_cb(1, 2, callback))
    println(add_with_cb(0, 2, callback))
catch e
    println("Error: ", e)
end