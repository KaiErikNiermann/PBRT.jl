#ifndef ABS_HITTABLE_H
#define ABS_HITTABLE_H
#include "hittable.h"

class Hittable {
    public: 
        virtual ~Hittable() = default;
};

set_usertype_enabled(Hittable);

#endif // !ABS_HITTABLE_H