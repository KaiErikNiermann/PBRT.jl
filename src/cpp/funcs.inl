#pragma once 

#include <string>

namespace module {
    static inline std::string MiniRTInterop = 
        R"(using StaticArrays

module MiniRTInterop
const ROOT_FP  = "/workspaces/Thesis"
const benchmarks = joinpath(ROOT_FP, "benchmarks", "jl_time.csv")

push!(LOAD_PATH, ROOT_FP)

using Pkg
using Logging

Pkg.activate(ROOT_FP)
Pkg.instantiate()
Pkg.resolve()

using MiniRT

function __init__()
    # ENV["JULIA_CPU_TARGET"] = "generic; native"
    language = get(ENV, "JL_INTEROP_LANGUAGE", "<NOT SET>")
    @info "Julia interop language set to: $language"
    @info "Set Julia CPU target"
    if !MiniRT.hello()
        @error "Failed to initialize MiniRT.jl."
        error("Initialization failed")
    end
end

function MiniRT.hit!(node::MiniRT.BVHNode, ray::MiniRT.Ray, interval::MiniRT.Interval, record::MiniRT.HitRecord)::Bool
    updated_record = @MiniRT.time_exec benchmarks MiniRTInterop.hit(node, MiniRT.RayPath(ray, interval), record)

    if ENV["JL_INTEROP_LANGUAGE"] == "C++"
        record.t                 = updated_record.t
        record.p                 = updated_record.p
        record.normal            = updated_record.normal
        record.mat.albedo.data   = updated_record.mat.albedo.data
        record.front_face        = updated_record.front_face
        record.hit               = updated_record.hit   
    end 

    return record.hit
end

end 

using .MiniRTInterop)";
}   
