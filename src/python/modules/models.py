from dataclasses import dataclass, field
import julia
import juliacall
import numpy as np
from typing import Literal, Optional
from .material import Material
from functools import lru_cache
from functools import cache
import re


LIB_SCOPE = "MiniRT"
TYPE_RE = re.compile(r"^Julia: ([\w\.]+)\(")


@cache
def extract_jl_type(obj_repr: str) -> str:
    match = TYPE_RE.match(obj_repr)
    if not match:
        raise ValueError(f"Could not extract type from repr: {obj_repr}")
    return match.group(1)


def make_wrapper_gen_for(name: str):
    class MetaWrapper(type):
        def __new__(cls, clsname, bases, attrs):
            attrs["__module__"] = "__main__"
            return super().__new__(cls, name, bases, attrs)

        def __repr__(cls):
            return f"<class '__main__.{name}'>"
    return MetaWrapper


wrapper_generator_cache = {
    f"{LIB_SCOPE}.BVHNode": make_wrapper_gen_for(f"{LIB_SCOPE}.BVHNode"),
    f"{LIB_SCOPE}.AABB": make_wrapper_gen_for(f"{LIB_SCOPE}.AABB"),
    f"{LIB_SCOPE}.Triangle": make_wrapper_gen_for(f"{LIB_SCOPE}.Triangle"),
    f"{LIB_SCOPE}.Sphere": make_wrapper_gen_for(f"{LIB_SCOPE}.Sphere"),
}


def make_wrapper_of(parsed_type: str):
    class TypedWrapper(metaclass=wrapper_generator_cache[parsed_type]):
        def __init__(self, raw):
            self.raw = raw

        def __getattr__(self, attr):
            return getattr(self.raw, attr)

    return TypedWrapper


_AABB = make_wrapper_of(f"{LIB_SCOPE}.AABB")
_Triangle = make_wrapper_of(f"{LIB_SCOPE}.Triangle")
_Sphere = make_wrapper_of(f"{LIB_SCOPE}.Sphere")
_BVHNode = make_wrapper_of(f"{LIB_SCOPE}.BVHNode")

wrapper_cache = {
    f"{LIB_SCOPE}.AABB": _AABB,
    f"{LIB_SCOPE}.Triangle": _Triangle,
    f"{LIB_SCOPE}.Sphere": _Sphere,
    f"{LIB_SCOPE}.BVHNode": _BVHNode,
}


_seen_types = {}


def wrapper_dispatch(obj):
    if obj in _seen_types:
        cls = _seen_types[obj]
    else:
        parsed_type = extract_jl_type(repr(obj))
        cls = wrapper_cache[parsed_type]
        _seen_types[obj] = cls
    return cls(obj)


class Hittable:
    pass


@dataclass
class Ray:
    origin: np.ndarray
    direction: np.ndarray


@dataclass
class Interval[T]:
    lo: T
    hi: T


@dataclass
class Sphere(Hittable):
    center: np.ndarray
    radius: float
    mat: Optional[Material]

    def __post_init__(self):
        self.radius = max(0.0, self.radius)
        self.r_squared = self.radius * self.radius
        self.bbox = AABB(
            x=Interval[float](
                lo=self.center[0] - self.radius, hi=self.center[0] + self.radius
            ),
            y=Interval[float](
                lo=self.center[1] - self.radius, hi=self.center[1] + self.radius
            ),
            z=Interval[float](
                lo=self.center[2] - self.radius, hi=self.center[2] + self.radius
            ),
        )


@dataclass
class AABB(Hittable):
    x: Interval[float]
    y: Interval[float]
    z: Interval[float]


@dataclass
class RayPath:
    ray: Ray
    interval: Interval[float]


@dataclass
class HittableList:
    objects: list[Hittable] = field(default_factory=list)
    bbox: Optional[AABB] = None


@dataclass
class HitRecord:
    t: float
    p: np.ndarray
    normal: np.ndarray
    front_face: bool
    mat: Material
    u: float
    v: float
    hit: Literal[True, False] = False


@dataclass
class Triangle(Hittable):

    v1: np.ndarray
    v2: np.ndarray
    v3: np.ndarray
    ident: int
    edges: list[set[list[float]]]
    mat: Optional[Material]
    bbox: Optional[AABB]


@dataclass
class BVHNode(Hittable):
    left: Hittable
    right: Hittable
    bbox: AABB
