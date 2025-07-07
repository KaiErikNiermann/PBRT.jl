#include <jluna.hpp>
#include "aabb.h"
#include "triangle.h"
#include "sphere.h"
#include "color.h"
#include "hittable.h"
#include "bvh.h"
#include "material.h"

using namespace jluna;

REGISTER_VPTR(Triangle, Registry);
REGISTER_VPTR(Sphere, Registry);
REGISTER_VPTR(BVHNode, Registry);
REGISTER_VPTR(Lambertian, Registry);
REGISTER_VPTR(Metal, Registry);

void register_type_properties() {
    Usertype<Ray>::initialize_type(
        lenses<
            Lens<"origin"_ct, &Ray::origin>, 
            Lens<"direction"_ct, &Ray::direction>
        >()
    );

    Usertype<Interval>::initialize_type(
        lenses<
            Lens<"lo"_ct, &Interval::lo>, 
            Lens<"hi"_ct, &Interval::hi>
        >()
    );

    Usertype<AABB>::initialize_type(
        lenses<
            Lens<"x"_ct, &AABB::x>, 
            Lens<"y"_ct, &AABB::y>, 
            Lens<"z"_ct, &AABB::z>
        >()
    );

    Usertype<Lambertian>::initialize_type(
        lenses<
            Lens<"albedo"_ct, &Lambertian::albedo>
        >()
    );

    Usertype<Metal>::initialize_type(
        lenses<
            Lens<"albedo"_ct, &Metal::albedo>, 
            Lens<"fuzz"_ct, &Metal::fuzz>
        >()
    );

    Usertype<Triangle>::initialize_type(
        lenses<
            Lens<"v1"_ct, &Triangle::v1>,
            Lens<"v2"_ct, &Triangle::v2>,
            Lens<"v3"_ct, &Triangle::v3>,
            Lens<"mat"_ct, &Triangle::mat>,
            Lens<"bbox"_ct, &Triangle::bbox>
        >(),
        types<Lambertian, Metal>()
    );

    Usertype<Sphere>::initialize_type(
        lenses<
            Lens<"center"_ct,  &Sphere::center>,
            Lens<"radius"_ct,  &Sphere::radius>,
            Lens<"r_squared"_ct,&Sphere::r_squared>,
            Lens<"mat"_ct,     &Sphere::mat>,
            Lens<"bbox"_ct,    &Sphere::bbox>
        >(),
        types<Lambertian, Metal>()
    );

    Usertype<HitRecord>::initialize_type(
        lenses<
            Lens<"p"_ct, &HitRecord::p>,
            Lens<"normal"_ct, &HitRecord::normal>,
            Lens<"mat"_ct, &HitRecord::mat>,
            Lens<"t"_ct, &HitRecord::t>,
            Lens<"front_face"_ct, &HitRecord::front_face>,
            Lens<"u"_ct, &HitRecord::u>,
            Lens<"v"_ct, &HitRecord::v>,
            Lens<"hit"_ct, &HitRecord::hit>
        >(),
        types<Triangle, Sphere, Lambertian, Metal>()
    );

    Usertype<RGBVec3>::initialize_type(
        lenses<Lens<"data"_ct, &RGBVec3::data>>()
    );

    Usertype<RayPath>::initialize_type(
        lenses<
            Lens<"ray"_ct, &RayPath::ray>, 
            Lens<"interval"_ct, &RayPath::interval>
        >()
    );

    Usertype<BVHNode>::initialize_type(
        lenses<
            Lens<"left"_ct, &BVHNode::left>,
            Lens<"right"_ct, &BVHNode::right>,
            Lens<"bbox"_ct, &BVHNode::bbox>
        >(),
        types<Sphere, BVHNode, Triangle>()
    );
}

void implement_types() {
    jluna::Module MiniRT = jluna::Main["MiniRTInterop"]["MiniRT"];

    Usertype<RGBVec3>::implement(MiniRT);
    Usertype<Interval>::implement(MiniRT);
    Usertype<AABB>::implement(MiniRT);
    Usertype<Ray>::implement(MiniRT);
    Usertype<Hittable>::implement(MiniRT);
    Usertype<Material>::implement(MiniRT);
    Usertype<Lambertian>::implement<Material>(MiniRT);
    Usertype<Metal>::implement<Material>(MiniRT);
    Usertype<Sphere>::implement<Hittable>(MiniRT);
    Usertype<Triangle>::implement<Hittable>(MiniRT);
    Usertype<HitRecord>::implement(MiniRT);
    Usertype<RayPath>::implement(MiniRT);
    Usertype<BVHNode>::implement<Hittable>(MiniRT);
}

void register_types() {
    register_type_properties();
    implement_types();
}