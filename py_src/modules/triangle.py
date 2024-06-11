from .aabb import aabb, interval, ray, at
from .hittable import HittableList, Hittable, HitRecord
import numpy as np
from dataclasses import dataclass
from .material import Material

@dataclass 
class Triangle(Hittable):
    A: np.ndarray
    B: np.ndarray
    C: np.ndarray
    ident: int
    edges: list[set[list[float]]]
    mat: Material
    bbox: aabb

def hit_triangle(t: Triangle, r: ray, ray_t: interval[float], rec: HitRecord) -> bool: 
    e1 = t.B - t.A
    e2 = t.C - t.A
    normal = np.cross(e1, e2) 
    
    ray_cross_e2 = np.cross(r.direction, e2)
    det = np.dot(e1, ray_cross_e2)
    
    if det > -1e-8 and det < 1e-8:
        return False
    
    inv_det = 1.0 / det
    s = r.origin - t.A
    u = np.dot(s, ray_cross_e2) * inv_det
    if u < 0 or u > 1: 
        return False
    
    s_cross_e1 = np.cross(s, e1)
    v = np.dot(r.direction, s_cross_e1) * inv_det
    
    if v < 0.0 or u + v > 1.0: 
        return False
    
    t_val = np.dot(e2, s_cross_e1) * inv_det
    
    if t_val < ray_t.lo or t_val > ray_t.hi:
        return False
    
    rec.t = t_val
    rec.p = at(r, t_val)
    rec.normal = normal
    rec.mat = t.mat
    
    return True