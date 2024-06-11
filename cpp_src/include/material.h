#ifndef MATERIAL_H
#define MATERIAL_H

#include <vector>
#include <iostream>

class material {

};

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

#endif // !MATERIAL_H