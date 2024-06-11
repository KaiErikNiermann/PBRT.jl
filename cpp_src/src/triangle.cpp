#include "triangle.h"

std::vector<double> at (const ray& r, double t) {
    return {r.origin[0] + t * r.direction[0],
            r.origin[1] + t * r.direction[1],
            r.origin[2] + t * r.direction[2]};
}

// Cross product of two 3D vectors
std::vector<double> cross(const std::vector<double>& a, const std::vector<double>& b) {
    return {
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0]
    };
}

// Dot product of two 3D vectors
double dot(const std::vector<double>& a, const std::vector<double>& b) {
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
}

std::function<bool(const triangle&, const ray&, const interval&, HitRecord&)> create_triangle_hit_func() {
    return [](const triangle& t, const ray& r, const interval& ray_t, HitRecord& rec) -> bool {
        std::vector<double> e1 = {t.B[0] - t.A[0], t.B[1] - t.A[1], t.B[2] - t.A[2]};
        std::vector<double> e2 = {t.C[0] - t.A[0], t.C[1] - t.A[1], t.C[2] - t.A[2]};
        std::vector<double> normal = cross(e1, e2);

        std::vector<double> ray_cross_e2 = cross(r.direction, e2);
        double det = dot(e1, ray_cross_e2);

        if (det > -1e-8 && det < 1e-8) {
            return false;
        }

        double inv_det = 1.0 / det;
        std::vector<double> s = {r.origin[0] - t.A[0], r.origin[1] - t.A[1], r.origin[2] - t.A[2]};
        double u = dot(s, ray_cross_e2) * inv_det;
        if (u < 0.0 || u > 1.0) {
            return false;
        }

        std::vector<double> s_cross_e1 = cross(s, e1);
        double v = dot(r.direction, s_cross_e1) * inv_det;
        if (v < 0.0 || u + v > 1.0) {
            return false;
        }

        double t_val = dot(e2, s_cross_e1) * inv_det;
        if (t_val < ray_t.lo || t_val > ray_t.hi) {
            return false;
        }

        rec.t = t_val;
        rec.p = at(r, t_val);
        rec.normal = normal;
        rec.mat = t.mat;
        return true;
    };
}