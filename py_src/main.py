from julia import Main
from julia.api import Julia

jl = Julia(compiled_modules=False)

Main.include("../src/PBRT.jl")

print("hello world")
print(Main.PBRT.greet_your_package_name())
