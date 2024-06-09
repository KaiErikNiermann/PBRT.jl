from juliacall import Main
from juliacall import Pkg as jlPkg

from bvh import aabb, interval, ray, hit

jlPkg.activate('..')
Main.seval('using PBRT')
Main.seval('using PythonCall')
Main.seval('using Pkg')
Main.seval('Pkg.instantiate()')
Main.seval('Pkg.resolve()')

PBRT = Main.PBRT

Main.hit = hit

Main.seval("""
function PBRT.hit(bbox::PBRT.aabb, r::PBRT.ray, ray_t::PBRT.interval)::Bool
    return Bool(hit(bbox, r, ray_t)) 
end
""")

PBRT.example_render()
