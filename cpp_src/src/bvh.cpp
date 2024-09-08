#include "bvh.h"

bool bvh_hit(const bvh_node& node, const ray_itval& rt, HitRecord* rec)  {
    if (!hit_aabb(node.bbox, rt.r, rt.t)) {
        rec->hit = false;
        return false;
    }

    bool hit_left = false;
    bool hit_right = false;

    if (node.left != nullptr) {
        hit_left = node.left.get()->hit(rt, rec);
    }

    if (node.right != nullptr) {
        hit_right = node.right.get()->hit(ray_itval(interval(rt.t.lo, hit_left ? rec->t : rt.t.hi), rt.r), rec);
    }
    
    rec->hit = hit_left || hit_right;
    return rec->hit;
}
