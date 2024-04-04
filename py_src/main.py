import juliacall as jl
from juliacall import Main
from juliacall import Pkg as jlPkg
from numba import cuda as nb_cuda
import numpy as np
import time

# Load required Julia packages
jlPkg.activate('..')
Main.seval('using PBRT')
Main.seval('using PythonCall')

PBRT = Main.PBRT

# Access the greet_your_package_name function
func = PBRT.greet_your_package_name

# Call the function and print the result
result = func()
print(type(result))

# access data_pass_test function 

func = PBRT.data_pass_test

point = func()

print(type(point.to_numpy()))


def time_sleep():
    import time
    time.sleep(10)
    return "Done"

jlsleep = PBRT.time_sleep
pysleep = time_sleep

# benchmark julia sleep
t1 = time.time()
jlsleep()
t2 = time.time()
print("Julia sleep time: ", t2-t1)

# benchmark python sleep
t1 = time.time()
pysleep()
t2 = time.time()
print("Python sleep time: ", t2-t1)
