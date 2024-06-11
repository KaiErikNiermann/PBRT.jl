#ifndef COLOR_H
#define COLOR_H
#include <jluna.hpp>

class color {
    public:
        double r;
        double g;
        double b;
};

set_usertype_enabled(color);

#endif // !COLOR_H