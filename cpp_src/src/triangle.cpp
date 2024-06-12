#include "triangle.h"

// std::function<bool(const triangle&)> create_triangle_hit_func() {
//     return [](const triangle& t) -> bool {

//         return true;
//     };
// }


std::function<bool(const triangle&, const ray_itval&, const HitRecord&)> create_triangle_hit_func() {
    return [](const triangle& t, const ray_itval& rt, const HitRecord& rec) -> bool {
        std::vector<double> e1 = {t.B[0] - t.A[0], t.B[1] - t.A[1], t.B[2] - t.A[2]};
        std::vector<double> e2 = {t.C[0] - t.A[0], t.C[1] - t.A[1], t.C[2] - t.A[2]};
        std::vector<double> normal = cross(e1, e2);

        std::vector<double> ray_cross_e2 = cross(rt.r.direction, e2);
        double det = dot(e1, ray_cross_e2);

        if (det > -1e-8 && det < 1e-8) {
            return false;
        }

        double inv_det = 1.0 / det;
        std::vector<double> s = {rt.r.origin[0] - t.A[0], rt.r.origin[1] - t.A[1], rt.r.origin[2] - t.A[2]};
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
        rec.mat = t.mat;
        return true;
    };
}