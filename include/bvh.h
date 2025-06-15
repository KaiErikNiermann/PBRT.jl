#ifndef BVH_H
#define BVH_H
#include "hittable.h"
#include "aabb.h"
#include "triangle.h"
#include "sphere.h"
#include <jluna.hpp>

class BVHNode;

class BVHNode : public Hittable {
public:
    std::shared_ptr<Hittable> left;
    std::shared_ptr<Hittable> right;
    AABB bbox;

    bool hit(const Ray&, const Interval&, HitRecord&) const override;
};

set_usertype_enabled(BVHNode);

#endif // !BVH_H