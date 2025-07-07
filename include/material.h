#ifndef Material_H
#define Material_H

#include <vector>
#include <iostream>
#include <jluna.hpp>
#include "color.h"

using namespace jluna;

class Material {
    public:
        virtual ~Material() = default;
        virtual RGBVec3 get_albedo() = 0; 
};

class Lambertian : public Material {
    public:
        RGBVec3 albedo;
        virtual RGBVec3 get_albedo() override {
            return this->albedo;
        }
};

class Metal : public Material {
    public:
        RGBVec3 albedo;
        virtual RGBVec3 get_albedo() override {
            return this->albedo;
        }
        double fuzz;
};

class Dielectric : public Material {
    public:
        double ref_idx;
};

set_usertype_enabled(Material);
set_usertype_enabled(Metal)
set_usertype_enabled(Dielectric)
set_usertype_enabled(Lambertian)

#endif // !Material_H