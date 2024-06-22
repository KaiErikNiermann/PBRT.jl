#include "bvh.h"

bool bvh_node::hit(const ray_itval& rt, const HitRecord& rec) const {
    if (!hit_aabb(bbox, rt.r, rt.t)) {
        return false;
    }
    
    bool hit_left = false; 
    bool hit_right = false;
    
    if (auto tri = std::dynamic_pointer_cast<Triangle>(left)) {
        hit_left = tri->hit(rt, rec);
    } 
    if (auto tri = std::dynamic_pointer_cast<Triangle>(right)) {
        hit_right = tri->hit(rt, rec);
    }
    if (auto sph = std::dynamic_pointer_cast<sphere>(left)) {
        hit_left = sph->hit(rt, rec);
    }
    if (auto sph = std::dynamic_pointer_cast<sphere>(right)) {
        hit_right = sph->hit(rt, rec);
    }
    if (auto bvh = std::dynamic_pointer_cast<bvh_node>(left)) {
        hit_left = bvh->hit(rt, rec);
    }
    if (auto bvh = std::dynamic_pointer_cast<bvh_node>(right)) {
        hit_right = bvh->hit(rt, rec);
    }

    if (hit_left || hit_right) {
        std::cout << "hit" << std::endl;
    }

    return hit_left || hit_right;
}