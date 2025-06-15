import numpy as np
from dataclasses import dataclass, field
from .aabb import AABB
from .material import Material
from typing import Optional


class Hittable:
    pass


@dataclass
class HittableList:
    objects: list[Hittable] = field(default_factory=list)
    bbox: Optional[AABB] = None


@dataclass
class HitRecord:
    t: float = 0.0
    p: np.ndarray = field(
        default_factory=lambda: np.zeros(3, dtype=np.float64))
    normal: np.ndarray = field(
        default_factory=lambda: np.zeros(3, dtype=np.float64))
    front_face: bool = False
    mat: Optional[Material] = None
    u: float = 0.0
    v: float = 0.0
