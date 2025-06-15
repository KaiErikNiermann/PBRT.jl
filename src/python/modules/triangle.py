from .aabb import AABB, Interval, Interval, Ray, at
from .hittable import Hittable, HitRecord
import numpy as np
from dataclasses import dataclass
from bvh import hit
from .material import Material
from typing import Optional, List, Set


@dataclass
class Triangle(Hittable):
    v1: np.ndarray = np.zeros(3, dtype=np.float64)
    v2: np.ndarray = np.zeros(3, dtype=np.float64)
    v3: np.ndarray = np.zeros(3, dtype=np.float64)
    ident: int = 0
    edges: list[set[list[float]]] = []
    mat: Optional[Material] = None
    bbox: Optional[AABB] = None

    def __repr__(self) -> str:
        return "Triangle"


@hit.register
def _(t: Triangle, ray: Ray, interval: Interval, record: HitRecord) -> bool:
    e1 = t.v2 - t.v1
    e2 = t.v3 - t.v1
    normal = np.cross(e1, e2)

    ray_cross_e2 = np.cross(ray.direction, e2)
    det = np.dot(e1, ray_cross_e2)

    if det > -1e-8 and det < 1e-8:
        return False

    inv_det = 1.0 / det
    s = ray.origin - t.v1
    u = np.dot(s, ray_cross_e2) * inv_det
    if u < 0 or u > 1:
        return False

    s_cross_e1 = np.cross(s, e1)
    v = np.dot(ray.direction, s_cross_e1) * inv_det

    if v < 0.0 or u + v > 1.0:
        return False

    t_val = np.dot(e2, s_cross_e1) * inv_det

    if t_val < interval.lo or t_val > interval.hi:
        return False

    record.t = t_val
    record.p = at(ray, t_val)
    record.normal = normal
    record.mat = t.mat

    return True
