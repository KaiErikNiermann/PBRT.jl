#include "bvh.h"

bool bvh_node::hit(const ray_itval& rt, const HitRecord& rec) const {
    if (!hit_aabb(bbox, rt.r, rt.t)) {
        return false;
    }
    
    bool hit_left = left.get()->hit(rt, rec);
    bool hit_right = right.get()->hit(ray_itval(interval(rt.t.lo, hit_left ? rec.t : rt.t.hi), rt.r), rec);

    return hit_left || hit_right;
}