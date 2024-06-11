from dataclasses import dataclass, field
import numpy as np
from .color import Color

@dataclass
class Material:
    pass

@dataclass
class Lambertian(Material):
    albedo: Color

class Metal(Material):
    def __init__(self, albedo: Color = np.array([0.0, 0.0, 0.0]), fuzz: float = 0.0):
        self.albedo = albedo
        self.fuzz = fuzz
    
class Dialectric(Material):
    def __init__(self, ref_idx: float = 0.0):
        self.ref_idx = ref_idx
