from .aabb import aabb, interval, ray, at
from .hittable import HittableList, Hittable, HitRecord
from dataclasses import dataclass
from .material import Material
import numpy as np

class Sphere(Hittable):
    # center: np.ndarray
    # radius: float
    # r_squared: float
    # mat: Material
    # bbox: aabb
    def __init__(self
                , center: np.ndarray = np.array([0.0, 0.0, 0.0])
                , radius: float = 0.0
                , mat: Material = None):
        self.center = center
        self.radius = max(0.0, radius)
        self.r_squared = radius * radius
        self.mat = mat
        self.bbox = aabb(
              x = interval[float](lo = center[0] - radius, hi = center[0] + radius)
            , y = interval[float](lo = center[1] - radius, hi = center[1] + radius)
            , z = interval[float](lo = center[2] - radius, hi = center[2] + radius)
        )

def hit_sphere(s: Sphere, r: ray, ray_t: interval[float], rec: HitRecord) -> bool: 
    oc = r.origin - s.center
    a = np.dot(r.direction, r.direction)
    half_b = np.dot(oc, r.direction)
    
    c = np.dot(oc, oc) - s.r_squared
    discriminant = half_b * half_b - a * c
    if discriminant < 0: 
        return False
    
    sqrtd = np.sqrt(discriminant)
    
    root = (-half_b - sqrtd) / a
    if root < ray_t.lo or root > ray_t.hi: 
        root = (-half_b + sqrtd) / a
        if root < ray_t.lo or root > ray_t.hi: 
            return False
        
    rec.t = root
    rec.p = at(r, root)
    outward_normal = (rec.p - s.center) / s.radius
    rec.normal = outward_normal
    rec.mat = s.mat