#include "triangle.h"

#include <array>
#include <vector>
#include <cmath>
#include <stdexcept>
#include <iostream>
#include "math_util.h"
#include "hittable.h"

bool Triangle::hit(const Ray& ray, const Interval& interval, HitRecord& record) const {
    Vec3 e1     = Vec3(this->v2) - Vec3(this->v1);
    Vec3 e2     = Vec3(this->v3) - Vec3(this->v1);
    Vec3 normal = cross(e1, e2).normalized();

    Vec3 ray_cross_e2 = cross(Vec3(ray.direction), e2);
    double det        = dot(e1, ray_cross_e2);

    if (det > -1e-8 && det < 1e-8) {
        return false;
    }

    double inv_det = 1.0 / det;
    Vec3 s         = Vec3(ray.origin) - Vec3(this->v1);
    double u       = dot(s, ray_cross_e2) * inv_det;
    
    if (u < 0.0 || u > 1.0) {
        return false;
    }

    Vec3 s_cross_e1 = cross(s, e1);
    double v        = dot(Vec3(ray.direction), s_cross_e1) * inv_det;

    if (v < 0.0 || u + v > 1.0) {
        return false;
    }

    double t_val = dot(e2, s_cross_e1) * inv_det;
    if (t_val < interval.lo || t_val > interval.hi) {
        return false;
    }

    record.p      = at(ray, t_val).to_array();
    record.normal     = (record.front_face ? normal : normal * -1).to_array();
    record.mat    = this->mat;
    record.t      = t_val;
    record.front_face = dot(Vec3(ray.direction), Vec3(normal)) < 0;
    record.hit    = true;

    return true;
};