#ifndef MATH_UTIL_H
#define MATH_UTIL_H

#include <vector>
#include "aabb.h"

std::vector<double> at(const ray& r, double t);

double dot(const std::vector<double>& a, const std::vector<double>& b);

std::vector<double> cross(const std::vector<double>& a, const std::vector<double>& b);

std::vector<double> subtract(const std::vector<double>& a, const std::vector<double>& b);

#endif // !MATH_UTIL_H