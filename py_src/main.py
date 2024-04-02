from juliacall import Main
from juliacall import Pkg as jlPkg
from numba import cuda as nb_cuda

# Load required Julia packages
jlPkg.activate('..')
Main.seval('using PBRT')

PBRT = Main.PBRT

# Access the greet_your_package_name function
func = PBRT.greet_your_package_name

# Call the function and print the result
result = func()
print(type(result))

# basic cuda example numba 
@nb_cuda.jit
def add(a, b, c):
    c[0] = a[0] + b[0]
    
a = nb_cuda.to_device([1])
b = nb_cuda.to_device([4])
c = nb_cuda.to_device([0])

add[1, 1](a, b, c)
print(c.copy_to_host())