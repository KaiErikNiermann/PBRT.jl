#include <jluna.hpp>
#include <string>
#include <stdlib.h>

using namespace jluna;

class Color {
public:
    double r;
    double g;
    double b;

    // mul overload
    Color operator*(const Color& c) const {
        return Color {r * c.r, g * c.g, b * c.b};
    }

    // scalar add overload
    Color operator+(const double& s) const {
        return Color {r + s, g + s, b + s};
    }

    // add overload
    Color operator+(const Color& c) const {
        return Color {r + c.r, g + c.g, b + c.b};
    }

    // scalar mul overload
    Color operator*(const double& s) const {
        return Color {r * s, g * s, b * s};
    }
};

typedef struct {
    double aspect_ratio; 
    double width; 
    double height;
} image;

class Point {
public:
    double _x; 
    double _y;
    double _z;

    // add overload
    Point operator+(const Point& p) const {
        return Point {_x + p._x, _y + p._y, _z + p._z};
    }

    // sub overload
    Point operator-(const Point& p) const {
        return Point {_x - p._x, _y - p._y, _z - p._z};
    }

    // mul overload
    Point operator*(const Point& p) const {
        return Point {_x * p._x, _y * p._y, _z * p._z};
    }

    // scalar mul overload
    Point operator*(const double& s) const {
        return Point {_x * s, _y * s, _z * s};
    }

    // scalar div overload
    Point operator/(const double& s) const {
        return Point {_x / s, _y / s, _z / s};
    }
};

Point operator*(const double& s, const Point& p) {
    return Point {p._x * s, p._y * s, p._z * s};
}

typedef struct {
    double viewport_width;
    double viewport_height;
    double focal_length;
    Point  origin;
    Point  horizontal;
    Point  vertical;
    Point  lower_left_corner;
} camera;

typedef struct {
    Point  origin;
    Point  direction;
} ray;

Point at(const ray& r, double t) {
    return r.origin + r.direction * t;
}

void write_color(Color pixel_color) {
    std::cout << static_cast<int>(255.999 * pixel_color.r) << ' '
              << static_cast<int>(255.999 * pixel_color.g) << ' '
              << static_cast<int>(255.999 * pixel_color.b) << '\n';
}

double dot(const Point& u, const Point& v) {
    return u._x * v._x + u._y * v._y + u._z * v._z;
}

double norm(const Point& v) {
    return sqrt(v._x * v._x + v._y * v._y + v._z * v._z);
}

float hit_sphere(const Point& center, const double radius, const ray& r) {
    Point oc = r.origin - center; 
    double a = dot(r.direction, r.direction);
    double half_b = dot(oc, r.direction);
    double c = dot(oc, oc) - radius * radius;
    double discriminant = half_b * half_b - a * c;
    if (discriminant < 0) 
        return -1.0;
    
    return (-half_b - sqrt(discriminant)) / a;
}

Color ray_color(const ray& r) {
    const Point dir = {0, 0, -1};
    double t = hit_sphere(dir, 0.5, r);
    if (t > 0.0) {
        Point v = at(r, t) - dir;
        Point N = v / norm(v);
        Point res = (N + Point {1, 1, 1}) * 0.5;
        return Color {res._x, res._y, res._z};
    }

    Point unit_direction = r.direction / norm(r.direction);
    t = 0.5 * (unit_direction._y + 1.0);
    return Color {1.0, 1.0, 1.0} * (1.0 - t) + Color {0.5, 0.7, 1.0} * t;
}
 
void render(image& img, camera& cam) {
    std::cout << "P3\n" << img.width << ' ' << img.height << "\n255\n";
    for (int j = img.height - 1; j >= 0; --j) {
        for (int i = 0; i < img.width; ++i) {
            double u = double(i) / (img.width - 1);
            double v = double(j) / (img.height - 1);
            ray r = {cam.origin, cam.lower_left_corner + u * cam.horizontal + v * cam.vertical - cam.origin};
            Color pixel_color = ray_color(r);
            write_color(pixel_color);
        }
    }
}

set_usertype_enabled(Point);

int main() {
    jluna::initialize();
    
    Main.safe_eval("using Pkg; Pkg.activate(\"..\")");
    Main.safe_eval("using PBRT");
    
    // --------------------------------------


    image img = {16.0 / 9.0, 400, floor(400 / (16.0 / 9.0))};
    double viewport_height = 2.0;
    double viewport_width = img.aspect_ratio * viewport_height;
    double focal_length = 1.0;

    Point origin = {0, 0, 0};
    Point horizontal = {viewport_width, 0, 0};
    Point vertical = {0, viewport_height, 0};
    Point lower_left_corner = origin - horizontal / 2 - vertical / 2 - Point {0, 0, focal_length};
    camera cam = {viewport_width, viewport_height, focal_length, origin, horizontal, vertical, lower_left_corner};
    render(img, cam);

    return 0;
}