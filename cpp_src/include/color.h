#ifndef COLOR_H
#define COLOR_H
#include <jluna.hpp>

class color {
    public:
        float r;
        float g;
        float b;
};

set_usertype_enabled(color);
set_usertype_enabled(color*);

#endif // !COLOR_H