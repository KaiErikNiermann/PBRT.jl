import Base.push!

mutable struct HittableList 
    objects::Vector{Hittable}
    bbox::AABB
    function HittableList()
        objects::Vector{Hittable} = [] 
        bbox::AABB = AABB()
        new(objects, bbox)
    end
    function HittableList(objects, bbox)
        new(objects, bbox)
    end
end

function push!(list::HittableList, object::Hittable)
    push!(list.objects, object)
    list.bbox = AABB(list.bbox, object.bbox)
end

function clear!(list::HittableList)
    list.objects = []
end

function hit!(list::HittableList, r::Ray, ray_t::Interval, rec::HitRecord)
    temp_rec = HitRecord()
    hit_anything = false
    closest_so_far = ray_t.hi
    for object in list.objects
        if(hit!(object, r, Interval(ray_t.lo, closest_so_far), temp_rec))
            hit_anything = true
            closest_so_far = temp_rec.t

            rec.front_face = temp_rec.front_face
            rec.normal = temp_rec.normal
            rec.mat = temp_rec.mat
            rec.p = temp_rec.p
            rec.t = temp_rec.t
        end
    end

    return hit_anything
end