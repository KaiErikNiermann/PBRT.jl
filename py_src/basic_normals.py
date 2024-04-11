from dataclasses import dataclass
import numpy as np

point = np.array

@dataclass
class ray: 
    origin: point
    direction: point
    
@dataclass 
class color: 
    r: float
    g: float
    b: float
    
    def __mul__(self, other: float):
        return color(self.r * other, self.g * other, self.b * other)
    
    def __add__(self, other):
        return color(self.r + other.r, self.g + other.g, self.b + other.b)
    
@dataclass 
class image: 
    aspect_ratio: float
    width: int
    height: int
    
@dataclass
class camera:
    viewport_height: float
    viewport_width: float
    focal_length: float
    origin: point
    horizontal: point
    vertical: point
    lower_left_corner: point
    
def at(ray: ray, t: float) -> point:
    return ray.origin + t * ray.direction
    
def write_color(pixel_color: color) -> None:
    print(f"{int(255.999 * pixel_color.r)} {int(255.999 * pixel_color.g)} {int(255.999 * pixel_color.b)}")
    
def hit_sphere(center: point, radius: float, r: ray) -> float:
    oc = r.origin - center
    a = np.dot(r.direction, r.direction)
    half_b = np.dot(oc, r.direction)
    c = np.dot(oc, oc) - radius * radius
    discriminant = half_b * half_b - a * c
    if (discriminant < 0):
        return -1.0
    
    return (-half_b - np.sqrt(discriminant)) / a

def ray_color(r: ray) -> color:
    t = hit_sphere(np.array([0, 0, -1]), 0.5, r)
    if t > 0.0:
        v = at(r, t) - np.array([0, 0, -1])
        N = v / np.linalg.norm(v)
        res = 0.5 * np.array([N[0] + 1, N[1] + 1, N[2] + 1])
        return color(res[0], res[1], res[2])
    
    unit_direction = r.direction / np.linalg.norm(r.direction)
    t = 0.5 * (unit_direction[1] + 1.0)
    return color(1.0, 1.0, 1.0) * (1.0 - t) + color(0.5, 0.7, 1.0) * t

def render(width: int, height: int, img: image, cam: camera) -> None:
    print("P3\n" + str(width) + " " + str(height) + "\n255\n")
    for j in range(height - 1, -1, -1):
        for i in range(width):
            u = i / (width - 1)
            v = j / (height - 1)
            r = ray(cam.origin, cam.lower_left_corner + u * cam.horizontal + v * cam.vertical - cam.origin)
            pixel_color = ray_color(r)
            write_color(pixel_color)
    
    
width = 400
aspect_ratio = 16.0 / 9.0

img = image(16.0 / 9.0, 400, int(width // aspect_ratio))

viewport_height = 2.0
viewport_width = aspect_ratio * viewport_height
focal_length = 1.0

origin = np.array([0, 0, 0])
horizontal = np.array([viewport_width, 0, 0])
vertical = np.array([0, viewport_height, 0])
lower_left_corner = origin - horizontal / 2 - vertical / 2 - np.array([0, 0, focal_length])
camera = camera(viewport_height, viewport_width, focal_length, origin, horizontal, vertical, lower_left_corner)

render(img.width, img.height, img, camera)