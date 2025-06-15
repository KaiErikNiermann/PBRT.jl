import Base.push!

"""
    HittableList.jl

A module that defines a list of hittable objects, which can be used for ray tracing.

- `objects` is a vector of `Hittable` objects.
- `bbox` is the axis-aligned bounding box that encompasses all objects in the list.
"""
mutable struct HittableList
    objects::Vector{Hittable}
    bbox::AABB
end

HittableList() = HittableList([], AABB())
HittableList(object::Hittable) = HittableList([object], object.bbox)

const HList = HittableList

function push!(h_list::HList, object::Hittable)
    push!(h_list.objects, object)                 
    h_list.bbox = AABB(h_list.bbox, object.bbox)    
    return h_list
end

function clear!(h_list::HList)
    h_list.objects = []
end

function hit!(h_list::HList, ray::Ray, interval::Interval, record::HRecord)::Bool
    hit_anything = false
    closest_so_far = interval.hi

    for obj in h_list.objects
        if(hit!(obj, ray, Interval(interval.lo, closest_so_far), record))
            hit_anything = true
            closest_so_far = record.t
        end
    end

    return hit_anything
end

export  HittableList, HList, push!, clear!, hit!