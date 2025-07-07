from functools import singledispatch
from juliacall import Main as jl
from juliacall import Pkg
import modules.aabb
import modules.triangle
import modules.sphere
from modules.bvh import hit
from modules.models import HitRecord, wrapper_cache, wrapper_dispatch
from utils.analysis import print_meta
from utils.bench import Benchmark
import atexit


class MiniRT:
    def __init__(self):
        # julia setup
        # Pkg.activate(".")
        # Pkg.instantiate()
        # Pkg.resolve()
        jl.seval("ENV[\"JULIA_CPU_TARGET\"] = \"generic; native\"")
        jl.seval("ENV[\"JL_INTEROP_LANGUAGE\"] = \"Python\"")

        jl.include("src/interface/MiniRTInterop.jl")
        jl.seval("using .MiniRTInterop")

        self.MiniRT = jl.MiniRTInterop.MiniRT

        @Benchmark.run()
        def hit_proxy(node, ray_path, record):
            return hit(node, ray_path.ray, ray_path.interval, record)

        jl.MiniRTInterop.hit = hit_proxy

    def render(self):
        self.MiniRT.render("scenes/cottage/cottage.obj")


if __name__ == "__main__":
    p = MiniRT()
    p.render()
    atexit.register(Benchmark.save)
