#ifndef BVH_H
#define BVH_H
#include "hittable.h"
#include "abs_hit.h"
#include "aabb.h"
#include <jluna.hpp>

class bvh_node : public Hittable {
    public:
        std::shared_ptr<Hittable> left;
        std::shared_ptr<Hittable> right;
        aabb bbox;

    bool hit(const ray_itval& rt, const HitRecord& rec) const; 
};

bool hit_bvh(const bvh_node& node, const ray_itval& rt, const HitRecord& rec);

set_usertype_enabled(bvh_node);

#endif // !BVH_H