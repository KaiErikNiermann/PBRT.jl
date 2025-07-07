from .hittable import set_face_normal
from .fast_math import dot
from .models import LIB_SCOPE, _Sphere, Interval, Ray, HitRecord, Sphere
from dataclasses import dataclass
from .aabb import at
import numpy as np
from .bvh import hit


@hit.register(_Sphere)
def _(sphere, ray: Ray, interval: Interval, record: HitRecord) -> HitRecord:
    oc = ray.origin - sphere.center
    a = 1
    half_b = dot(oc, ray.direction)

    c = dot(oc, oc) - sphere.r_squared
    discriminant = half_b * half_b - a * c
    if discriminant < 0:
        return record

    sqrtd = np.sqrt(discriminant)

    root = (-half_b - sqrtd) / a
    if root < interval.lo or root > interval.hi:
        root = (-half_b + sqrtd) / a
        if root < interval.lo or root > interval.hi:
            return record

    record.t = root
    record.p = at(ray, root)
    record.mat = sphere.mat
    record.hit = True
    out_norm = (record.p - sphere.center) / sphere.radius

    return record
