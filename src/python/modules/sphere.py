from .aabb import AABB, Interval, Ray, at, RayPath
from .hittable import Hittable, HitRecord
from dataclasses import dataclass
from .material import Material
from bvh import hit
import numpy as np
from typing import Optional


@dataclass
class Sphere(Hittable):
    center: np.ndarray = np.array([0.0, 0.0, 0.0])
    radius: float = 0.0
    mat: Optional[Material] = None

    def __post_init__(self):
        self.radius = max(0.0, self.radius)
        self.r_squared = self.radius * self.radius
        self.bbox = AABB(
            x=Interval[float](
                lo=self.center[0] - self.radius, hi=self.center[0] + self.radius
            ),
            y=Interval[float](
                lo=self.center[1] - self.radius, hi=self.center[1] + self.radius
            ),
            z=Interval[float](
                lo=self.center[2] - self.radius, hi=self.center[2] + self.radius
            ),
        )


@hit.register
def _(s: Sphere, ray: Ray, interval: Interval, record: HitRecord) -> bool:
    oc = ray.origin - s.center
    a = np.dot(ray.direction, ray.direction)
    half_b = np.dot(oc, ray.direction)

    c = np.dot(oc, oc) - s.r_squared
    discriminant = half_b * half_b - a * c
    if discriminant < 0:
        return False

    sqrtd = np.sqrt(discriminant)

    root = (-half_b - sqrtd) / a
    if root < interval.lo or root > interval.hi:
        root = (-half_b + sqrtd) / a
        if root < interval.lo or root > interval.hi:
            return False

    record.t = root
    record.p = at(ray, root)
    outward_normal = np.ndarray(
        [
            (record.p[0] - s.center[0]) / s.radius,
            (record.p[1] - s.center[1]) / s.radius,
            (record.p[2] - s.center[2]) / s.radius,
        ]
    )
    record.normal = outward_normal
    record.mat = s.mat

    return True
