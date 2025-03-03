#include "bvh.h"

bool BVH_hit(const BVHNode& node, const RayData& rd, HitRecord& rec) {
    if (!AABB_hit(node.bbox, rd.ray, rd.interval)) {
        rec.hit = false;
        return false;
    }

    bool hit_left  = false;
    bool hit_right = false;

    if (node.left != nullptr) {
        hit_left = node.left.get()->hit(rd, rec);
    }
    
    if (node.right != nullptr) {
        hit_right = node.right.get()->hit(
            RayData(Interval(rd.interval.lo, hit_left ? rec.t : rd.interval.hi), rd.ray), rec
        );
    }

    rec.hit = hit_left || hit_right;
    return rec.hit;
}
