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
static const char A[]          = "A";
static const char B[]          = "B";
static const char C[]          = "C";
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
static const char r[]          = "r";
static const char g[]          = "g";
static const char b[]          = "b";
static const char left[]       = "left";
static const char right[]      = "right";
static const char ray[]        = "ray";
static const char interval[]    = "interval";

void register_type_properties() {
    Usertype<Ray>::initialize_type(
        TL<Lens<origin, &Ray::origin>, Lens<direction, &Ray::direction>>(), TL<>()
    );

    Usertype<Interval>::initialize_type(
        TL<Lens<lo, &Interval::lo>, Lens<hi, &Interval::hi>>(), TL<>()
    );

    Usertype<AABB>::initialize_type(
        TL<Lens<x, &AABB::x>, Lens<y, &AABB::y>, Lens<z, &AABB::z>>(), TL<>()
    );

    Usertype<Lambertian>::initialize_type(TL<Lens<albedo, &Lambertian::albedo>>(), TL<>());

    Usertype<Triangle>::initialize_type(
        TL<Lens<A, &Triangle::A>,
           Lens<B, &Triangle::B>,
           Lens<C, &Triangle::C>,
           Lens<id, &Triangle::id>,
           Lens<edges, &Triangle::edges>,
           Lens<mat, &Triangle::mat>,
           Lens<bbox, &Triangle::bbox>>(),
        TL<Lambertian>()
    );

    Usertype<Sphere>::initialize_type(
        TL<Lens<center, &Sphere::center>,
           Lens<radius, &Sphere::radius>,
           Lens<r_squared, &Sphere::r_squared>,
           Lens<mat, &Sphere::mat>,
           Lens<bbox, &Sphere::bbox>>(),
        TL<Lambertian>()
    );

    Usertype<HitRecord>::initialize_type(
        TL<Lens<p, &HitRecord::p>,
           Lens<normal, &HitRecord::normal>,
           Lens<t, &HitRecord::t>,
           Lens<u, &HitRecord::u>,
           Lens<v, &HitRecord::v>,
           Lens<hit, &HitRecord::hit>,
           Lens<mat, &HitRecord::mat>,
           Lens<front_face, &HitRecord::front_face>>(),
        TL<Triangle, Sphere, Lambertian>()
    );

    Usertype<Color>::initialize_type(
        TL<Lens<r, &Color::r>, Lens<g, &Color::g>, Lens<b, &Color::b>>(), TL<>()
    );

    Usertype<RayData>::initialize_type(
        TL<Lens<ray, &RayData::ray>, Lens<interval, &RayData::interval>>(), TL<>()
    );

    Usertype<BVHNode>::initialize_type(
        TL<Lens<left, &BVHNode::left>, Lens<right, &BVHNode::right>, Lens<bbox, &BVHNode::bbox>>(),
        TL<Sphere, BVHNode, Triangle>()
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
    Usertype<Color>::implement();
    Usertype<RayData>::implement();
    Usertype<BVHNode>::implement<Hittable>();
}

void register_types() {
    register_type_properties();
    implement_types();
}