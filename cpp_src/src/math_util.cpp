#include "math_util.h"

std::vector<double> at (const ray& r, double t) {
    return {r.origin[0] + t * r.direction[0],
            r.origin[1] + t * r.direction[1],
            r.origin[2] + t * r.direction[2]};
}

double dot(const std::vector<double>& a, const std::vector<double>& b) {
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
}

std::vector<double> cross(const std::vector<double>& a, const std::vector<double>& b) {
    return {
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0]
    };
}

std::vector<double> subtract(const std::vector<double>& a, const std::vector<double>& b) {
    return {a[0] - b[0], a[1] - b[1], a[2] - b[2]};
}
