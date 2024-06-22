#ifndef MATERIAL_H
#define MATERIAL_H

#include <vector>
#include <iostream>
#include <jluna.hpp>

class material {};

class lambertian : public material {
    public:
        std::vector<double> albedo;
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

#endif // !MATERIAL_H