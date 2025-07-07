#ifndef MATH_UTIL_H
#define MATH_UTIL_H

#include <vector>
#include "aabb.h"

class Ray;

#include "math_util.h"

struct Vec3 {
    double x, y, z;

    // Constructors
    Vec3()
        : x(0)
        , y(0)
        , z(0) { }
    Vec3(double x_, double y_, double z_)
        : x(x_)
        , y(y_)
        , z(z_) { }

    // From std::vector<double>
    explicit Vec3(const std::vector<double>& v) {
        if (v.size() != 3)
            throw std::invalid_argument("Vec3 requires exactly 3 elements");
        x = v[0];
        y = v[1];
        z = v[2];
    }

    // From std::array<double, 3>
    explicit Vec3(const std::array<double, 3>& a)
        : x(a[0])
        , y(a[1])
        , z(a[2]) { }

    // To std::vector<double>
    std::vector<double> to_vector() const { return {x, y, z}; }

    // To std::array<double, 3>
    std::array<double, 3> to_array() const { return {x, y, z}; }

    // Operators
    inline Vec3 operator+(const Vec3& b) const { return Vec3(x + b.x, y + b.y, z + b.z); }

    inline Vec3 operator-(const Vec3& b) const { return Vec3(x - b.x, y - b.y, z - b.z); }

    inline Vec3 operator*(double s) const { return Vec3(x * s, y * s, z * s); }

    inline Vec3 operator/(double s) const {
        double inv = 1.0 / s;
        return Vec3(x * inv, y * inv, z * inv);
    }

    inline Vec3& operator+=(const Vec3& b) {
        x += b.x;
        y += b.y;
        z += b.z;
        return *this;
    }

    inline Vec3& operator-=(const Vec3& b) {
        x -= b.x;
        y -= b.y;
        z -= b.z;
        return *this;
    }

    inline Vec3& operator*=(double s) {
        x *= s;
        y *= s;
        z *= s;
        return *this;
    }

    inline Vec3& operator/=(double s) {
        double inv = 1.0 / s;
        x *= inv;
        y *= inv;
        z *= inv;
        return *this;
    }

    // Dot product
    friend inline double dot(const Vec3& a, const Vec3& b) {
        return a.x * b.x + a.y * b.y + a.z * b.z;
    }

    // Cross product
    friend inline Vec3 cross(const Vec3& a, const Vec3& b) {
        return Vec3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x);
    }

    inline double length() const { return std::sqrt(dot(*this, *this)); }

    inline Vec3 normalized() const { return *this / length(); }

    // Stream output
    friend std::ostream& operator<<(std::ostream& os, const Vec3& v) {
        return os << "Vec3(" << v.x << ", " << v.y << ", " << v.z << ")";
    }
};

inline Vec3 at(const Ray& r, double t) {
    return Vec3(r.origin[0] + t * r.direction[0],
                r.origin[1] + t * r.direction[1],
                r.origin[2] + t * r.direction[2]);
}


#endif // !MATH_UTIL_H