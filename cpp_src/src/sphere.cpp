#include "sphere.h"

bool hit(const Sphere& s, const ray_itval& rt, const HitRecord& rec) {
    return s.hit(rt, rec);
}

bool Sphere::hit(const ray_itval& rt, const HitRecord& rec) const {
    std::vector<double> oc = subtract(rt.r.origin, this->center);
    double a = dot(rt.r.direction, rt.r.direction);
    double half_b = dot(oc, rt.r.direction);
    double c = dot(oc, oc) - this->r_squared;
    double discriminant = half_b * half_b - a * c;

    if (discriminant < 0) {
        return false;
    }

    double sqrtd = std::sqrt(discriminant);

    double root = (-half_b - sqrtd) / a;
    if (root < rt.t.lo || root > rt.t.hi) {
        root = (-half_b + sqrtd) / a;
        if (root < rt.t.lo || root > rt.t.hi) {
            return false;
        }
    }

    rec.t = root;
    rec.p = at(rt.r, root);
    std::vector<double> outward_normal = {
        (rec.p[0] - this->center[0]) / this->radius,
        (rec.p[1] - this->center[1]) / this->radius,
        (rec.p[2] - this->center[2]) / this->radius
    };

    rec.normal = outward_normal;
    // set_face_normal(rec, rt.r, outward_normal);
    rec.mat = this->mat;
    return true;
};
