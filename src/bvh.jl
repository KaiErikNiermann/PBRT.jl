
mutable struct bvh_node <: hittable
    left::hittable
    right::hittable
    bbox::aabb
    function bvh_node(left::hittable, right::hittable, bbox::aabb)
        new(left, right, bbox)
    end
    bvh_node() = new(null_obj(), null_obj(), aabb())
end


function box_compare(a::interval, b::interval)::Bool
    return a.lo < b.lo
end

function box_x_compare(a::hittable, b::hittable)::Bool
    return box_compare(a.bbox.x, b.bbox.x)
end

function box_y_compare(a::hittable, b::hittable)::Bool
    return box_compare(a.bbox.y, b.bbox.y)
end

function box_z_compare(a::hittable, b::hittable)::Bool
    return box_compare(a.bbox.z, b.bbox.z)
end

function bvh_node(objects::Vector{hittable}, start, end_, node::bvh_node)::bvh_node
    bbox = aabb()
    for i in start:end_
        bbox = aabb(bbox, objects[i].bbox)
    end

    axis = longest_axis(bbox)

    comparator = Nothing
    if axis == 1 
        comparator = (a::hittable, b::hittable) -> box_x_compare(a, b)
    elseif axis == 2
        comparator = (a::hittable, b::hittable) -> box_y_compare(a, b)
    else
        comparator = (a::hittable, b::hittable) -> box_z_compare(a, b)
    end
    
    object_span = end_ - start

    if object_span == 1
        node.left = objects[start]
        node.right = objects[start]
    elseif object_span == 2
        node.left = objects[start]
        node.right = objects[start + 1]
    else
        objects = [objects[1:start]; sort(objects[start:end_], lt=comparator); objects[end_+1:end]]
        mid = trunc(Int, start + object_span / 2)

        node.left = bvh_node(objects, start, mid, bvh_node())
        node.right = bvh_node(objects, mid, end_, bvh_node())
    end
    return bvh_node(node.left, node.right, bbox)
end

bvh_node(list::hittable_list, node::bvh_node) = bvh_node(list.objects, 1, Base.size(list.objects)[1], node)

function hit!(node::bvh_node, r::ray, ray_t::interval, rec::hit_record)::Bool
    if (!hit!(node.bbox, r, ray_t))
        return false
    end

    hit_left = hit!(node.left, r, ray_t, rec)
    hit_right = hit!(node.right, r, interval(ray_t.lo, ifelse(hit_left, rec.t, ray_t.hi)), rec)

    return hit_left || hit_right
end
