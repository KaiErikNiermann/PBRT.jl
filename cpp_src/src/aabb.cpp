#include "aabb.h"

std::function<bool(const aabb&, const ray&, const interval&)> create_aabb_hit_func() {
    return [](const aabb& box, const ray& r, const interval& ray_t) -> bool {
        float r_lo = ray_t.lo;
        float r_hi = ray_t.hi;

        for (int axis = 0; axis < 3; axis++) {
            auto ax = std::vector<interval> {box.x, box.y, box.z}[axis];
            float invD = r.direction[axis] != 0.0 ? 1.0 / r.direction[axis] : 0.0; 

            float t0 = (ax.lo - r.origin[axis]) * invD;
            float t1 = (ax.hi - r.origin[axis]) * invD;
            
            if (invD < 0.0) 
                std::swap(t0, t1);

            r_lo = t0 > r_lo ? t0 : r_lo;
            r_hi = t1 < r_hi ? t1 : r_hi;

            if (r_hi <= r_lo) 
                return false;
        }
        return true;
    };
}