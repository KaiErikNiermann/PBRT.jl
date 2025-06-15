#include <jluna.hpp>
#include <vector>
#include <iostream>
#include "aabb.h"
#include "triangle.h"
#include "sphere.h"
#include "color.h"
#include "hittable.h"
#include "bvh.h"
#include "material.h"

using namespace jluna;

static const char origin[]     = "origin";
static const char direction[]  = "direction";
static const char lo[]         = "lo";
static const char hi[]         = "hi";
static const char x[]          = "x";
static const char y[]          = "y";
static const char z[]          = "z";
static const char albedo[]     = "albedo";
static const char v1[]          = "v1";
static const char v2[]          = "v2";
static const char v3[]          = "v3";
static const char id[]         = "id";
static const char edges[]      = "edges";
static const char mat[]        = "mat";
static const char bbox[]       = "bbox";
static const char center[]     = "center";
static const char radius[]     = "radius";
static const char r_squared[]  = "r_squared";
static const char p[]          = "p";
static const char normal[]     = "normal";
static const char u[]          = "u";
static const char v[]          = "v";
static const char t[]          = "t";
static const char hit[]        = "hit";
static const char front_face[] = "front_face";
static const char left[]       = "left";
static const char right[]      = "right";
static const char ray[]        = "ray";
static const char interval[]    = "interval";
static const char data[]       = "data";

void register_type_properties() {
    Usertype<Ray>::initialize_type(
        TList<Lens<origin, &Ray::origin>, Lens<direction, &Ray::direction>>(), TList<>()
    );

    Usertype<Interval>::initialize_type(
        TList<Lens<lo, &Interval::lo>, Lens<hi, &Interval::hi>>(), TList<>()
    );

    Usertype<AABB>::initialize_type(
        TList<Lens<x, &AABB::x>, Lens<y, &AABB::y>, Lens<z, &AABB::z>>(), TList<>()
    );

    Usertype<Lambertian>::initialize_type(TList<Lens<albedo, &Lambertian::albedo>>(), TList<>());

    Usertype<Triangle>::initialize_type(
        TList<Lens<v1, &Triangle::v1>,
           Lens<v2, &Triangle::v2>,
           Lens<v3, &Triangle::v3>,
           Lens<id, &Triangle::id>,
           Lens<edges, &Triangle::edges>,
           Lens<mat, &Triangle::mat>,
           Lens<bbox, &Triangle::bbox>>(),
        TList<Lambertian>()
    );

    Usertype<Sphere>::initialize_type(
        TList<Lens<center, &Sphere::center>,
            Lens<radius, &Sphere::radius>,
            Lens<r_squared, &Sphere::r_squared>,
            Lens<mat, &Sphere::mat>,
            Lens<bbox, &Sphere::bbox>>(),
        TList<Lambertian>()
    );

    Usertype<HitRecord>::initialize_type(
        TList<Lens<p, &HitRecord::p>,
           Lens<normal, &HitRecord::normal>,
           Lens<t, &HitRecord::t>,
           Lens<u, &HitRecord::u>,
           Lens<v, &HitRecord::v>,
           Lens<hit, &HitRecord::hit>,  
           Lens<mat, &HitRecord::mat>,
           Lens<front_face, &HitRecord::front_face>>(),
        TList<Triangle, Sphere, Lambertian>()
    );

   Usertype<RGBVec3>::initialize_type(
        TList<Lens<data, &RGBVec3::data>>(), TList<>()
   );

    Usertype<RayPath>::initialize_type(
        TList<Lens<ray, &RayPath::ray>, Lens<interval, &RayPath::interval>>(), TList<>()
    );

    Usertype<BVHNode>::initialize_type(
        TList<Lens<left, &BVHNode::left>, Lens<right, &BVHNode::right>, Lens<bbox, &BVHNode::bbox>>(),
        TList<Sphere, BVHNode, Triangle>()
    );
}

void implement_types() {
    Usertype<Interval>::implement();
    Usertype<AABB>::implement();
    Usertype<Ray>::implement();
    Usertype<Hittable>::implement();
    Usertype<Material>::implement();
    Usertype<Lambertian>::implement<Material>();
    Usertype<Sphere>::implement<Hittable>();
    Usertype<Triangle>::implement<Hittable>();
    Usertype<HitRecord>::implement();
    Usertype<RGBVec3>::implement();
    Usertype<RayPath>::implement();
    Usertype<BVHNode>::implement<Hittable>();
}

void register_types() {
    register_type_properties();
    implement_types();
}