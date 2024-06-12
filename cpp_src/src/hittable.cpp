#include "hittable.h"

std::vector<double> scale(std::vector<double> v, double s) {
    for (int i = 0; i < v.size(); i++) {
        v[i] *= s;
    }
    return v;
}

void set_face_normal(const HitRecord& rec, const ray& r, const std::vector<double>& outward_normal) {
    rec.front_face = dot(r.direction, outward_normal) < 0;
    rec.normal = rec.front_face ? outward_normal : scale(outward_normal, -1);
}