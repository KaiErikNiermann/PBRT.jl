#include "sphere.h"

bool Sphere::hit(const Ray& ray, const Interval& interval, HitRecord& record) const {
    std::vector<double> oc = subtract(ray.origin, this->center);
    double a               = dot(ray.direction, ray.direction);
    double half_b          = dot(oc, ray.direction);
    double c               = dot(oc, oc) - this->r_squared;
    double discriminant    = half_b * half_b - a * c;

    if (discriminant < 0) {
        return false;
    }

    double sqrtd = std::sqrt(discriminant);

    double root = (-half_b - sqrtd) / a;
    if (root < interval.lo || root > interval.hi) {
        root = (-half_b + sqrtd) / a;
        if (root < interval.lo || root > interval.hi) {
            return false;
        }
    }

    record.t = root;
    record.p = at(ray, root);
    record.normal = std::vector<double>(
        {(record.p[0] - this->center[0]) / this->radius,
         (record.p[1] - this->center[1]) / this->radius,
         (record.p[2] - this->center[2]) / this->radius}
    );
    record.mat = this->mat;
    return true;
};
