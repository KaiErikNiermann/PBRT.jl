#ifndef HITTABLE_H
#define HITTABLE_H

#include <vector>
#include <array>
#include "aabb.h"
#include "material.h"

class Hittable {
public:
    virtual ~Hittable() = default;
};

class HittableList {
public:
    std::vector<Hittable*> objects;
    aabb bbox;

    HittableList() = default;
    HittableList(const std::vector<Hittable*>& objects, const aabb& bbox)
        : objects(objects), bbox(bbox) {}
};

class HitRecord {
public:
    double t;
    std::vector<double> p;
    std::vector<double> normal;
    bool front_face;
    material mat;
    double u;
    double v;

    HitRecord(double t = 0.0,
              const std::vector<double>& p = {0.0, 0.0, 0.0},
              const std::vector<double>& normal = {0.0, 0.0, 0.0},
              bool front_face = false,
              material mat,
              double u = 0.0,
              double v = 0.0)
        : t(t), p(p), normal(normal), front_face(front_face), mat(mat), u(u), v(v) {}
};

#endif // HITTABLE_H
