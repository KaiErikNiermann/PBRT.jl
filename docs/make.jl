push!(LOAD_PATH,"../src/")

using Documenter
using PBRT

makedocs(
    sitename = "PBRT",
    format = Documenter.HTML(),
    modules = [PBRT]
)

deploydocs(
    repo = "https://github.com/KaiErikNiermann/PBRT.jl.git"
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
