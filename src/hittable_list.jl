import Base.push!

mutable struct hittable_list 
    objects::Vector{hittable}
    bbox::aabb
    function hittable_list()
        objects::Vector{hittable} = [] 
        bbox::aabb = aabb()
        new(objects, bbox)
    end
    function hittable_list(objects, bbox)
        new(objects, bbox)
    end
end

function push!(list::hittable_list, object::hittable)
    push!(list.objects, object)
    list.bbox = aabb(list.bbox, object.bbox)
end

function clear!(list::hittable_list)
    list.objects = []
end

function hit!(list::hittable_list, r::ray, ray_t::interval, rec::hit_record)
    temp_rec = hit_record()
    hit_anything = false
    closest_so_far = ray_t.hi
    for object in list.objects
        if(hit!(object, r, interval(ray_t.lo, closest_so_far), temp_rec))
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