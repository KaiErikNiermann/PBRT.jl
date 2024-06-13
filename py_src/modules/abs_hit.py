from .hittable import Hittable, HitRecord
from .aabb import ray_itval
from functools import partial
from functools import singledispatch
from .sphere import * 
from .triangle import *
from .bvh import *
from .aabb import *

def hit(obj: Hittable):
    if str(obj).startswith("sphere"):
        return partial(hit_sphere, obj) 
    elif str(obj).startswith("Triangle"):
        return partial(hit_triangle, obj)
    elif str(obj).startswith("PBRT.bvh_node"):
        return partial(hit_bvh, obj)
    elif str(obj).startswith("PBRT.aabb"):
        return partial(hit_aabb, obj)  
    else:
        raise ValueError(f"Object {obj} is not hittable") 
    