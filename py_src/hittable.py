import numpy as np
from dataclasses import dataclass
from .bvh import AABB

# abstract hittable class with bounding box and material 
@dataclass 
class Material:
    pass

@dataclass
class Hittable: 
    bbox: AABB
    material: Material

@dataclass
class HittableList(Hittable): 
    objects: list[Hittable]
    bbox: AABB