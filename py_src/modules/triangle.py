from .aabb import aabb, interval, ray
from .hittable import HittableList
import numpy as np
from dataclasses import dataclass
from .material import Material

@dataclass 
class Triangle:
    A: np.ndarray
    B: np.ndarray
    C: np.ndarray
    ident: int
    mat: Material
    bbox: aabb

def hit_triangle(triangle: Triangle, r: ray, ray_t: interval[float], rec: HittableList) -> bool: 
    return False