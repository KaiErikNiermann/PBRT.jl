#ifndef MATH_UTIL_H
#define MATH_UTIL_H

#include <vector>
#include "aabb.h"

class Ray;

std::vector<double> at(const Ray& r, double t);

double dot(const std::vector<double>& a, const std::vector<double>& b);

std::vector<double> cross(const std::vector<double>& a, const std::vector<double>& b);

std::vector<double> subtract(const std::vector<double>& a, const std::vector<double>& b);

#endif // !MATH_UTIL_H