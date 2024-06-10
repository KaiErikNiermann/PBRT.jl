from .aabb import aabb, interval, ray
from .hittable import HittableList
from dataclasses import dataclass
from .material import Material
import numpy as np

@dataclass
class Sphere: 
    center: np.ndarray
    radius: float
    r_squared: float
    mat: Material
    bbox: aabb

def hit_sphere(sphere: Sphere, r: ray, ray_t: interval[float], rec: HittableList) -> bool: 
    return False    