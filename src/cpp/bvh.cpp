#include "bvh.h"

bool BVHNode::hit(const Ray& ray, const Interval& interval, HitRecord& record) const {
    if (!hit_bbox(this->bbox, ray, interval)) {
        record.hit = false;
        return false;
    }

    bool hit_left  = false;
    bool hit_right = false;

    if (this->left != nullptr) {
        hit_left = this->left.get()->hit(ray, interval, record);
    }

    if (this->right != nullptr) {
        hit_right = this->right.get()->hit(
            ray, Interval(interval.lo, hit_left ? record.t : interval.hi), record
        );
    }

    record.hit = hit_left || hit_right;

    return record.hit;
}
