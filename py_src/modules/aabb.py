import numpy as np
from dataclasses import dataclass

# ray 
@dataclass 
class ray: 
    origin: np.ndarray
    direction: np.ndarray
    
def at(ray: ray, t: float) -> np.ndarray:
    return ray.origin + t * ray.direction

# generic interval 
@dataclass 
class interval[T]: 
    lo: T
    hi: T

# aabb 
@dataclass 
class aabb: 
    x: interval[float]
    y: interval[float]
    z: interval[float]
    
def hit_aabb(bbox: aabb, r: ray, ray_t: interval[float]) -> bool: 
    r_lo = ray_t.lo
    r_hi = ray_t.hi
    for axis in range(3): 
        ax = [bbox.x, bbox.y, bbox.z][axis]
        adinv = 1.0 / r.direction[axis] if r.direction[axis] != 0 else float('inf')
        
        t0 = (ax.lo - r.origin[axis]) * adinv
        t1 = (ax.hi - r.origin[axis]) * adinv
        
        if adinv < 0: 
            t0, t1 = t1, t0
         
        r_lo = max(r_lo, t0)
        r_hi = min(r_hi, t1)
        
        if r_hi <= r_lo: 
            return False
        
    return True
        

        
