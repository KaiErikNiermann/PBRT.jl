from .fast_math import dot


def set_face_normal(record, ray, outward_normal):
    record.front_face = dot(ray.direction, outward_normal) < 0
    record.normal = outward_normal if record.front_face else (
        -1 * outward_normal)
