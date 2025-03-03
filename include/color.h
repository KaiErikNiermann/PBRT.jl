#ifndef COLOR_H
#define COLOR_H
#include <jluna.hpp>

class Color {
    public:
        float r;
        float g;
        float b;
};

set_usertype_enabled(Color);
#endif // !COLOR_H