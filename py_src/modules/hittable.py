import numpy as np
from dataclasses import dataclass
from .aabb import aabb

# abstract hittable class with bounding box and material 
@dataclass 
class Material:
    pass

@dataclass
class Hittable: 
    bbox: aabb
    material: Material

@dataclass
class HittableList(Hittable): 
    objects: list[Hittable]
    bbox: aabb