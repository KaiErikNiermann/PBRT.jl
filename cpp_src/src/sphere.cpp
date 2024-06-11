#include <sphere.h>

std::vector<double> at (const ray& r, double t) {
    return {r.origin[0] + t * r.direction[0],
            r.origin[1] + t * r.direction[1],
            r.origin[2] + t * r.direction[2]};
}

double dot(const std::vector<double>& a, const std::vector<double>& b) {
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
}

std::vector<double> subtract(const std::vector<double>& a, const std::vector<double>& b) {
    return {a[0] - b[0], a[1] - b[1], a[2] - b[2]};
}

std::function<bool(const Sphere&, const ray&, const interval&, HitRecord&)> create_sphere_hit_func() {
    return [](const Sphere& s, const ray& r, const interval& ray_t, HitRecord& rec) -> bool {
        std::vector<double> oc = subtract(r.origin, s.center);
        double a = dot(r.direction, r.direction);
        double half_b = dot(oc, r.direction);
        double c = dot(oc, oc) - s.r_squared;
        double discriminant = half_b * half_b - a * c;

        if (discriminant < 0) {
            return false;
        }

        double sqrtd = std::sqrt(discriminant);

        double root = (-half_b - sqrtd) / a;
        if (root < ray_t.lo || root > ray_t.hi) {
            root = (-half_b + sqrtd) / a;
            if (root < ray_t.lo || root > ray_t.hi) {
                return false;
            }
        }

        rec.t = root;
        rec.p = at(r, root);
        std::vector<double> outward_normal = {
            (rec.p[0] - s.center[0]) / s.radius,
            (rec.p[1] - s.center[1]) / s.radius,
            (rec.p[2] - s.center[2]) / s.radius
        };
        rec.normal = outward_normal;
        rec.mat = s.mat;
        return true;
    };
}
