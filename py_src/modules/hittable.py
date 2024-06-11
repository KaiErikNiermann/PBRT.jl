import numpy as np
from dataclasses import dataclass, field
from .aabb import aabb
from .material import Material

class Hittable: 
    pass

class HittableList: 
    def __init__(self, objects: list[Hittable] = [], bbox: aabb = None):
        self.objects = objects
        self.bbox = bbox
        
class HitRecord:
    def __init__(self, 
                t: float = 0.0, 
                p: np.ndarray = np.array([0.0, 0.0, 0.0]), 
                normal: np.ndarray = np.array([0.0, 0.0, 0.0]), 
                front_face: bool = False, 
                mat: Material = None, 
                u: float = 0.0, 
                v: float = 0.0):
        self.p = p
        self.normal = normal
        self.mat = mat
        self.t = t
        self.front_face = front_face
        self.u = u
        self.v = v