from dataclasses import dataclass
from .hittable import Hittable, HitRecord
from .aabb import aabb, ray_itval, hit_aabb, interval

@dataclass 
class bvh_node(Hittable):
    left: Hittable
    right: Hittable
    bbox: aabb
    
    def __repr__(self) -> str: 
        return f"bvh_node"

def hit_bvh(node: bvh_node, rt: ray_itval, rec: HitRecord) -> bool:
    from .abs_hit import hit
    if not hit(node.bbox)(rt.r, rt.t): 
        return False
    
    hit_left = hit(node.left)(rt, rec)
    hit_right = hit(node.right)(ray_itval(rt.r, interval(rt.t.lo, rec.t if hit_left else rt.t.hi)), rec)
    
    return (hit_left or hit_right)