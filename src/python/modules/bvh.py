from functools import singledispatch
from .aabb import hit_aabb
from .models import LIB_SCOPE, Ray, Interval, HitRecord, wrapper_dispatch, BVHNode


@singledispatch
def hit(node, ray: Ray, interval: Interval, record: HitRecord) -> HitRecord:
    if not hit_aabb(wrapper_dispatch(node.bbox), ray, interval):
        return record

    left = hit(wrapper_dispatch(node.left), ray, interval, record)
    right = hit(
        wrapper_dispatch(node.right), ray, Interval(
            interval.lo, record.t if left.hit else interval.hi), record
    )

    return left if left.hit else right
