#ifndef BVH_H
#define BVH_H
#include "hittable.h"
#include "aabb.h"
#include "triangle.h"
#include "sphere.h"
#include <jluna.hpp>

class BVHNode;

bool BVH_hit(const BVHNode& node, const RayData& rd, HitRecord& rec);

class BVHNode : public Hittable {
public:
    std::shared_ptr<Hittable> left;
    std::shared_ptr<Hittable> right;
    AABB bbox;

    bool hit(const RayData& rd, HitRecord& rec) const override { return BVH_hit(*this, rd, rec); }
};

set_usertype_enabled(BVHNode);

#endif // !BVH_H