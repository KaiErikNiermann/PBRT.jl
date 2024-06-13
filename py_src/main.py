from juliacall import Main
from juliacall import Pkg as jlPkg

from modules.aabb import hit_aabb
from modules.triangle import hit_triangle
from modules.sphere import hit_sphere
from utils.sub_func_parser import get_sub_func_list

class PyJlPBRT: 
    def __init__(self):
        # julia setup 
        jlPkg.activate('..')
        Main.seval('using PBRT')
        Main.seval('using PythonCall')
        Main.seval('using Pkg')
        Main.seval('Pkg.instantiate()')
        Main.seval('Pkg.resolve()')

        self.PBRT = Main.PBRT

    def ex_render(self):
        self.PBRT.example_render("../scenes/cottage_obj.obj")
        
    def f_to_replace(self):
        """
        Overwrite the julia functions with the python functions
        """
        Main.hit_aabb = hit_aabb
        Main.hit_triangle = hit_triangle
        Main.hit_sphere = hit_sphere        

        for f in get_sub_func_list():
            Main.seval(f)

if __name__ == '__main__':
    p = PyJlPBRT()
    p.f_to_replace()
    p.ex_render()
