#pragma once 

#include <string>

namespace module {
    static inline std::string MiniRTInterop = 
        R"(module MiniRTInterop
    const ROOT_FP  = "/workspaces/Thesis"
    const BENCH_FP = joinpath(ROOT_FP, "benchmarks", "jl_time.csv")
    const run_once = let done = false 
        () -> begin
            if !done
                @info "$(@__FILE__): Started rendering"
                done = true
            end
        end
    end
   
    push!(LOAD_PATH, ROOT_FP)
   
    using Pkg
    using Logging
    
    Pkg.activate(ROOT_FP)
    Pkg.instantiate()
    Pkg.resolve()

    using MiniRT
    
    function __init__()
        @info "Set Julia CPU target"
        if !MiniRT.hello()
            @error "Failed to initialize MiniRT.jl."
            error("Initialization failed")
        end
        ENV["JULIA_CPU_TARGET"] = "generic; native"
    end

    function MiniRT.hit!(node::MiniRT.BVHNode, ray::MiniRT.Ray, interval::MiniRT.Interval, record::MiniRT.HitRecord)::Bool
        run_once()  

        t1 = time_ns()  
        updated_record = MiniRTInterop.hit(node, MiniRT.RayPath(ray, interval), record)
        t2 = time_ns()

        open(BENCH_FP, "a") do io
            write(io, "$t1,")
            write(io, "$t2,")
            write(io, "$(t2 - t1)\n")  
        end

        record.t            = updated_record.t
        record.p            = updated_record.p
        record.normal       = updated_record.normal
        red                 = updated_record.mat.albedo.r
        green               = updated_record.mat.albedo.g
        blue                = updated_record.mat.albedo.b
        record.mat          = MiniRT.Lambertian(MiniRT.RGBVec3(red, green, blue))
        record.front_face   = updated_record.front_face
        
        return Bool(updated_record.hit)
    end
end 
)";
}   
