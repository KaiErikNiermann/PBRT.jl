from julia import Main
from julia.api import Julia

jl = Julia(compiled_modules=False)

Main.include("../src/juliaThesis.jl")

print("hello world")
print(Main.juliaThesis.greet_your_package_name())
