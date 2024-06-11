#ifndef HITTABLE_H
#define HITTABLE_H

#include "aabb.h"

class hittable {

};

class hittable_list {
    public:
        std::vector<hittable> objects;
        aabb bbox;
};

#endif // !HITTABLE_H