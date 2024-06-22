#include "triangle.h"

bool Triangle::hit(const ray_itval& rt, const HitRecord& rec) const {
    std::vector<double> e1 = {this->B[0] - this->A[0], this->B[1] - this->A[1], this->B[2] - this->A[2]};
    std::vector<double> e2 = {this->C[0] - this->A[0], this->C[1] - this->A[1], this->C[2] - this->A[2]};
    std::vector<double> normal = cross(e1, e2);

    std::vector<double> ray_cross_e2 = cross(rt.r.direction, e2);
    double det = dot(e1, ray_cross_e2);

    if (det > -1e-8 && det < 1e-8) {
        return false;
    }

    double inv_det = 1.0 / det;
    std::vector<double> s = {rt.r.origin[0] - this->A[0], rt.r.origin[1] - this->A[1], rt.r.origin[2] - this->A[2]};
    double u = dot(s, ray_cross_e2) * inv_det;
    if (u < 0.0 || u > 1.0) {
        return false;
    }

    std::vector<double> s_cross_e1 = cross(s, e1);
    double v = dot(rt.r.direction, s_cross_e1) * inv_det;
    if (v < 0.0 || u + v > 1.0) {
        return false;
    }

    double t_val = dot(e2, s_cross_e1) * inv_det;
    if (t_val < rt.t.lo || t_val > rt.t.hi) {
        return false;
    }

    rec.t = t_val;
    rec.p = at(rt.r, t_val);
    rec.normal = normal;
    // set_face_normal(rec, rt.r, normal);
    rec.mat = this->mat;

    return true;
};