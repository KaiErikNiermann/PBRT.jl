#include "sphere.h"

bool Sphere::hit(const RayData& rd, HitRecord& rec) const {
    std::vector<double> oc = subtract(rd.ray.origin, this->center);
    double a               = dot(rd.ray.direction, rd.ray.direction);
    double half_b          = dot(oc, rd.ray.direction);
    double c               = dot(oc, oc) - this->r_squared;
    double discriminant    = half_b * half_b - a * c;

    if (discriminant < 0) {
        return false;
    }

    double sqrtd = std::sqrt(discriminant);

    double root = (-half_b - sqrtd) / a;
    if (root < rd.interval.lo || root > rd.interval.hi) {
        root = (-half_b + sqrtd) / a;
        if (root < rd.interval.lo || root > rd.interval.hi) {
            return false;
        }
    }

    rec.t = root;
    rec.p = at(rd.ray, root);
    rec.normal = std::vector<double>(
        {(rec.p[0] - this->center[0]) / this->radius,
         (rec.p[1] - this->center[1]) / this->radius,
         (rec.p[2] - this->center[2]) / this->radius}
    );
    rec.mat = this->mat;
    return true;
};
