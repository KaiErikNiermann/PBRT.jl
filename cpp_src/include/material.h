#ifndef MATERIAL_H
#define MATERIAL_H

#include <vector>
#include <iostream>
#include <jluna.hpp>
#include "color.h"

class material {
    public:
        virtual ~material() = default;
        virtual void foo() = 0; 
};

class lambertian : public material {
    public:
        color albedo;
        virtual void foo() override {}
};

class metal : public material {
    public:
        std::vector<double> albedo;
        double fuzz;
};

class dielectric : public material {
    public:
        double ref_idx;
};

set_usertype_enabled(material);
set_usertype_enabled(material*);
set_usertype_enabled(metal)
set_usertype_enabled(metal*)
set_usertype_enabled(dielectric)
set_usertype_enabled(dielectric*)
set_usertype_enabled(lambertian)
set_usertype_enabled(lambertian*)

#endif // !MATERIAL_H