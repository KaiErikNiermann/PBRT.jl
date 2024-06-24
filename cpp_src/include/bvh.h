#ifndef BVH_H
#define BVH_H
#include "hittable.h"
#include "aabb.h"
#include "triangle.h"
#include "sphere.h"
#include <jluna.hpp>

class bvh_node : public Hittable {
    public:
        std::shared_ptr<Hittable> left;
        std::shared_ptr<Hittable> right;
        aabb bbox;

        virtual bool hit(const ray_itval& rt, const HitRecord& rec) const override;
};


set_usertype_enabled(bvh_node);
set_usertype_enabled(bvh_node*);

#endif // !BVH_H