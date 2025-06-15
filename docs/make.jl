push!(LOAD_PATH,"../src/")

using Documenter
using MiniRT

makedocs(
    sitename = "MiniRT",
    format = Documenter.HTML(),
    modules = [MiniRT]
)

deploydocs(
    repo = "https://github.com/KaiErikNiermann/MiniRT.jl.git"
)