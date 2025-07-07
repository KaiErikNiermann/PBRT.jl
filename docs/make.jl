using Documenter
include("../run.jl")

makedocs(
    sitename = "MiniRT",
    format = Documenter.HTML(),
    modules = [MiniRT]
)

deploydocs(
    repo = "https://github.com/KaiErikNiermann/MiniRT.jl.git"
)