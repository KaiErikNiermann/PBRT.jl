import numpy as np
from dataclasses import dataclass
from functools import singledispatch
from bvh import hit


@dataclass
class Ray:
    origin: np.ndarray = np.zeros(3, dtype=np.float64)
    direction: np.ndarray = np.zeros(3, dtype=np.float64)


def at(ray: Ray, t: float) -> np.ndarray:
    return ray.origin + t * ray.direction


@dataclass
class Interval[T]:
    lo: T
    hi: T


@dataclass
class AABB:
    x: Interval[float]
    y: Interval[float]
    z: Interval[float]


@dataclass
class RayPath:
    ray: Ray
    interval: Interval[float]


@hit.register
def _(bbox: AABB, r: Ray, Interval: Interval[float]) -> bool:
    r_lo = Interval.lo
    r_hi = Interval.hi
    for axis in range(3):
        ax = [bbox.x, bbox.y, bbox.z][axis]
        adinv = 1.0 / \
            r.direction[axis] if r.direction[axis] != 0 else float("inf")

        t0 = (ax.lo - r.origin[axis]) * adinv
        t1 = (ax.hi - r.origin[axis]) * adinv

        if adinv < 0:
            t0, t1 = t1, t0

        r_lo = max(r_lo, t0)
        r_hi = min(r_hi, t1)

        if r_hi <= r_lo:
            return False

    return True
