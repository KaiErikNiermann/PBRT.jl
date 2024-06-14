#include "abs_hit.h"

hit_lambda hit(const Hittable& h) {
    if (dynamic_cast<const aabb*>(&h)) {
        return [](const Hittable& h, const ray_itval& rt, const HitRecord& rec) {
            return hit_aabb(dynamic_cast<const aabb&>(h), rt.r, rt.t);
        };
    } else if (dynamic_cast<const Sphere*>(&h)) {
        return [](const Hittable& h, const ray_itval& rt, const HitRecord& rec) {
            return hit_sphere(dynamic_cast<const Sphere&>(h), rt, rec);
        };
    } else if (dynamic_cast<const triangle*>(&h)) {
        return [](const Hittable& h, const ray_itval& rt, const HitRecord& rec) {
            return hit_triangle(dynamic_cast<const triangle&>(h), rt, rec);
        };
    } else if (dynamic_cast<const bvh_node*>(&h)) {
        return [](const Hittable& h, const ray_itval& rt, const HitRecord& rec) {
            return hit_bvh(dynamic_cast<const bvh_node&>(h), rt, rec);
        };
    } else {
        throw std::runtime_error("Unsupported Hittable type");
    }
}