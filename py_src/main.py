from juliacall import Main
from juliacall import Pkg as jlPkg

from bvh import aabb, interval, ray, hit

# julia setup 
jlPkg.activate('..')
Main.seval('using PBRT')
Main.seval('using PythonCall')
Main.seval('using Pkg')
Main.seval('Pkg.instantiate()')
Main.seval('Pkg.resolve()')

PBRT = Main.PBRT

# functions to replace
Main.hit = hit

Main.seval("""
function PBRT.hit(bbox::PBRT.aabb, r::PBRT.ray, ray_t::PBRT.interval)::Bool
    return Bool(hit(bbox, r, ray_t)) 
end
""")

def render_image():
    PBRT.example_render()

if __name__ == '__main__':
    PBRT.example_render()
