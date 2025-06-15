from dataclasses import dataclass, field
import numpy as np
from .color import RGBVec3


@dataclass
class Material:
    pass


@dataclass
class Lambertian(Material):
    albedo: RGBVec3


@dataclass
class Metal(Material):
    albedo: RGBVec3 = field(default_factory=lambda: RGBVec3(0.0, 0.0, 0.0))
    fuzz: float = 0.0


@dataclass
class Dialectric(Material):
    ref_idx: float = 0.0
