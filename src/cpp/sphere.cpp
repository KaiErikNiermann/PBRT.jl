#include "sphere.h"

bool Sphere::hit(const Ray& ray, const Interval& interval, HitRecord& record) const {
    Vec3 oc = Vec3(ray.origin) - Vec3(this->center);
    double a               = 1;
    double half_b          = dot(oc, Vec3(ray.direction));
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
    record.p = at(ray, root).to_array();
    record.normal = ((Vec3(record.p) - Vec3(this->center)) / this->radius).to_array();
    record.mat = this->mat;
    
    return true;
};
