#include "triangle.h"

bool Triangle::hit(const Ray& ray, const Interval& interval, HitRecord& record) const {
    std::vector<double> e1
        = {this->v2[0] - this->v1[0], this->v2[1] - this->v1[1], this->v2[2] - this->v1[2]};
    std::vector<double> e2
        = {this->v3[0] - this->v1[0], this->v3[1] - this->v1[1], this->v3[2] - this->v1[2]};
    std::vector<double> normal = cross(e1, e2);

    std::vector<double> ray_cross_e2 = cross(ray.direction, e2);
    double det                       = dot(e1, ray_cross_e2);

    if (det > -1e-8 && det < 1e-8) {
        return false;
    }

    double inv_det = 1.0 / det;
    std::vector<double> s
        = {ray.origin[0] - this->v1[0], ray.origin[1] - this->v1[1], ray.origin[2] - this->v1[2]};
    double u = dot(s, ray_cross_e2) * inv_det;
    if (u < 0.0 || u > 1.0) {
        return false;
    }

    std::vector<double> s_cross_e1 = cross(s, e1);
    double v                       = dot(ray.direction, s_cross_e1) * inv_det;
    if (v < 0.0 || u + v > 1.0) {
        return false;
    }

    double t_val = dot(e2, s_cross_e1) * inv_det;
    if (t_val < interval.lo || t_val > interval.hi) {
        return false;
    }

    record.t      = t_val;
    record.p      = at(ray, t_val);
    record.normal = normal;
    record.mat    = this->mat;

    return true;
};