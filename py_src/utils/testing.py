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

def b(p): 
    print(f"point in py {p}")

PBRT = Main.PBRT

# set PBRT.b to be the python function b ?
Main.b = b

Main.seval("""
function PBRT.b(p::PBRT.Point)
    return b(p)
end
""")

PBRT.a()


# def time_sleep():
#     import time
#     time.sleep(10)
#     return "Done"

# jlsleep = PBRT.time_sleep
# pysleep = time_sleep

# # benchmark julia sleep
# t1 = time.time()
# jlsleep()
# t2 = time.time()
# print("Julia sleep time: ", t2-t1)

# # benchmark python sleep
# t1 = time.time()
# pysleep()
# t2 = time.time()
# print("Python sleep time: ", t2-t1)
