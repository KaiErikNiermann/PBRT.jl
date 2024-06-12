#include "sphere.h"

std::function<bool(const Sphere&, const ray_itval&, const HitRecord&)> create_sphere_hit_func() {
    return [](const Sphere& s, const ray_itval& rt, const HitRecord& rec) -> bool {
        std::vector<double> oc = subtract(rt.r.origin, s.center);
        double a = dot(rt.r.direction, rt.r.direction);
        double half_b = dot(oc, rt.r.direction);
        double c = dot(oc, oc) - s.r_squared;
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
            (rec.p[0] - s.center[0]) / s.radius,
            (rec.p[1] - s.center[1]) / s.radius,
            (rec.p[2] - s.center[2]) / s.radius
        };

        rec.normal = outward_normal;
        // set_face_normal(rec, rt.r, outward_normal);
        rec.mat = s.mat;
        return true;
    };
}
