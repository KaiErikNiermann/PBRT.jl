from .aabb import aabb, interval, ray, at, ray_itval
import modules.hittable as h
from dataclasses import dataclass
from .material import Material
import numpy as np

class Sphere(h.Hittable):
    def __init__(self
                , center: np.ndarray = np.array([0.0, 0.0, 0.0])
                , radius: float = 0.0
                , mat: Material = None):
        self.center: np.ndarray = center
        self.radius: float = max(0.0, radius)
        self.r_squared: float = radius * radius
        self.mat: Material = mat
        self.bbox = aabb(
              x = interval[float](lo = center[0] - radius, hi = center[0] + radius)
            , y = interval[float](lo = center[1] - radius, hi = center[1] + radius)
            , z = interval[float](lo = center[2] - radius, hi = center[2] + radius)
        )
        
    def __repr__(self) -> str: 
        return f"sphere"

def hit_sphere(s: Sphere, rt: ray_itval, rec: h.HitRecord) -> bool: 
    oc = rt.r.origin - s.center
    a = np.dot(rt.r.direction, rt.r.direction)
    half_b = np.dot(oc, rt.r.direction)
    
    c = np.dot(oc, oc) - s.r_squared
    discriminant = half_b * half_b - a * c
    if discriminant < 0: 
        return False
    
    sqrtd = np.sqrt(discriminant)
    
    root = (-half_b - sqrtd) / a
    if root < rt.t.lo or root > rt.t.hi: 
        root = (-half_b + sqrtd) / a
        if root < rt.t.lo or root > rt.t.hi: 
            return False
        
    rec.t = root
    rec.p = at(rt.r, root)
    outward_normal = [
        (rec.p[0] - s.center[0]) / s.radius, 
        (rec.p[1] - s.center[1]) / s.radius,
        (rec.p[2] - s.center[2]) / s.radius
    ]
    rec.normal = outward_normal
    rec.mat = s.mat
    
    return True