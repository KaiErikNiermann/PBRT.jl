#ifndef BVH_H
#define BVH_H
#include "hittable.h"
#include "abs_hit.h"
#include "aabb.h"
#include <jluna.hpp>

class bvh_node : public Hittable {
    public:
        Hittable left;
        Hittable right;
        aabb bbox;
};

bool hit_bvh(const bvh_node& node, const ray_itval& rt, const HitRecord& rec);

set_usertype_enabled(bvh_node);

#endif // !BVH_H