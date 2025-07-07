import numpy as np
from .models import LIB_SCOPE, Ray, Interval


def at(ray: Ray, t: float) -> np.ndarray:
    return np.array(ray.origin) + t * np.array(ray.direction)


def hit_aabb(bbox, r: Ray, Interval: Interval) -> bool:
    r_lo = Interval.lo
    r_hi = Interval.hi
    x, y, z = bbox.x, bbox.y, bbox.z
    for axis, ax in enumerate((x, y, z)):
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
