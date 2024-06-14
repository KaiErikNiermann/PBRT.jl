#include "bvh.h"

bool hit_bvh(const bvh_node& node, const ray_itval& rt, const HitRecord& rec) {
    if (!hit(node.bbox)(node.bbox, rt, rec)) {
        return false;
    }

    bool hit_left = hit(node.left)(node.left, rt, rec);
    bool hit_right = hit(node.right)(node.right, ray_itval(interval(rt.t.lo, hit_left ? rec.t : rt.t.hi), rt.r), rec);

    return (hit_left || hit_right);
}