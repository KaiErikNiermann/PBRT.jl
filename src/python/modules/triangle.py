from .hittable import set_face_normal
from .fast_math import cross, dot
from .aabb import at
from .models import LIB_SCOPE, HitRecord, Interval, Interval, Ray, _Triangle
import numpy as np
from dataclasses import dataclass
from .bvh import hit


@hit.register(_Triangle)
def _(triangle, ray: Ray, interval: Interval, record: HitRecord) -> HitRecord:
    e1 = triangle.v2 - triangle.v1
    e2 = triangle.v3 - triangle.v1
    normal = cross(e1, e2)

    ray_cross_e2 = cross(ray.direction, e2)
    det = dot(e1, ray_cross_e2)

    if det > -1e-8 and det < 1e-8:
        return record

    inv_det = 1.0 / det
    s = ray.origin - triangle.v1
    u = dot(s, ray_cross_e2) * inv_det
    if u < 0 or u > 1:
        return record

    s_cross_e1 = cross(s, e1)
    v = dot(ray.direction, s_cross_e1) * inv_det

    if v < 0.0 or u + v > 1.0:
        return record

    t_val = dot(e2, s_cross_e1) * inv_det

    if t_val < interval.lo or t_val > interval.hi:
        return record

    record.t = t_val
    record.p = at(ray, t_val)
    record.mat = triangle.mat
    record.hit = True

    record.normal = list(normal)

    return record
