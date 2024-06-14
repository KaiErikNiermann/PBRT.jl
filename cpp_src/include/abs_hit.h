#ifndef ABS_HIT_H
#define ABS_HIT_H

#include "functional"
#include "aabb.h"
#include "sphere.h"
#include "triangle.h"
#include "bvh.h"
#include "abs_hittable.h"

// function takes the 

using hit_lambda = std::function<jluna::Bool(const Hittable&, const ray_itval&, const HitRecord&)>;

hit_lambda hit(const Hittable& h);

set_usertype_enabled(hit_lambda);

#endif // ABS_HIT_H