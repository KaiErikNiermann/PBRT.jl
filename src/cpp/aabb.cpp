#include "aabb.h"

bool AABB_hit(const AABB& bbox, const Ray& ray, const Interval& interval) {
    for (int axis = 0; axis < 3; axis++) {
        auto ax    = std::vector<Interval> { bbox.x, bbox.y, bbox.z }[axis];
        float invD = ray.direction[axis] != 0.0 ? 1.0 / ray.direction[axis] : 0.0;

        float t0 = (ax.lo - ray.origin[axis]) * invD;
        float t1 = (ax.hi - ray.origin[axis]) * invD;

        if (invD < 0.0)
            std::swap(t0, t1);

        float r_lo = t0 > interval.lo ? t0 : interval.lo;
        float r_hi = t1 < interval.hi ? t1 : interval.hi;

        if (r_hi <= r_lo)
            return false;
    }
    return true;
};