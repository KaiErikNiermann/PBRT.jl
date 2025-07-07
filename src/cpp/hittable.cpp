#include "hittable.h"
#include "math_util.h"

std::vector<double> scale(std::vector<double> v, double s) {
    for (int i = 0; i < v.size(); i++) {
        v[i] *= s;
    }
    return v;
}