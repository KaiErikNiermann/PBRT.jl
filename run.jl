using Logging
using TOML

Base.global_logger(ConsoleLogger(stderr, Logging.Info))

const ROOT        = @__DIR__
const SCENES_DIR  = joinpath(ROOT, "scenes")
const SCENES_FP   = joinpath(SCENES_DIR, "scenes.toml")

include(joinpath(ROOT, "src", "Types.jl"))
using .Types

include(joinpath(ROOT, "src", "MiniRT.jl"))
using .MiniRT

function get_scenes_dict(path::AbstractString)::Dict
    isfile(path) || error("Scenes list not found at $path")

    scenes = TOML.parsefile(path)
    haskey(scenes, "scenes") || error("No 'scenes' key found in $path")

    return scenes["scenes"]
end

function resolve_scene(args::Vector{String})::String
    scenes = get_scenes_dict(SCENES_FP)

    if length(args) < 2
        @warn "No scene specified; defaulting to 'cottage'"
        return joinpath(SCENES_DIR, "cottage", "cottage.obj")
    end

    scene_name = args[2]
    haskey(scenes, scene_name) || error("Scene '$scene_name' not found in scenes list.")
    return scenes[scene_name]
end

function main()
    scene_fp = resolve_scene(ARGS)
    mode = Types.mode_set(Symbol(get(ARGS, 1, "dynamic")))

    @info "Vector mode: $mode  (V3 = $(Types.Point2D(mode)), V2 = $(Types.Point3D(mode)))"
    @info "Rendering scene from: $scene_fp"

    MiniRT.render(scene_fp)
end

# ┌────────────────────────────────────┐
# │         CLI Entry Point            │
# └────────────────────────────────────┘

if abspath(PROGRAM_FILE) == @__FILE__
    try
        main()
    catch e
        @error "Unhandled error during execution: $e"
        rethrow(e)
    end
end
