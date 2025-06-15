from dataclasses import dataclass
from .hittable import Hittable, HitRecord
from .aabb import AABB, RayPath, hit, Interval, Ray
from functools import singledispatch


@dataclass
class BVHNode(Hittable):
    left: Hittable
    right: Hittable
    bbox: AABB


@singledispatch
def hit(node: BVHNode, ray: Ray, interval: Interval[float], record: HitRecord) -> bool:
    if not hit(node.bbox, ray, interval, record):
        return False

    hit_left = hit(node.left, ray, interval, record)

    hit_right = hit(
        node.right,
        RayPath(
            ray, Interval(
                interval.lo, record.t if hit_left else interval.hi)
        ),
        record,
    )

    return hit_left or hit_right
