#ifndef BVH_H
#define BVH_H
#include "hittable.h"
#include "aabb.h"

class bvh_node {
    public:
        Hittable left;
        Hittable right;
        aabb bbox;
};

bool hit_bvh(const bvh_node& node, const ray_itval& rt, const HitRecord& rec);

#endif // !BVH_H