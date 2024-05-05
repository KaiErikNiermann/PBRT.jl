mutable struct bvh_node <: hittable
    left::hittable
    right::hittable
    bbox::aabb
end

function bvh_node(list::hittable_list)::bvh_node
    return bvh_node(list.objects, 0, list.bbox)
end

function box_compare(a::hittable, b::hittable, axis_index::Int)::Bool
    a_axis_interval = a.bbox[axis_index]
    b_axis_interval = b.bbox[axis_index]
    return a_axis_interval.lo < b_axis_interval.lo
end

function box_x_compare(a::hittable, b::hittable)::Bool
    return box_compare(a, b, 1)
end

function box_y_compare(a::hittable, b::hittable)::Bool
    return box_compare(a, b, 2)
end

function box_z_compare(a::hittable, b::hittable)::Bool
    return box_compare(a, b, 3)
end


function bvh_node(objects::Vector{hittable}, start, end_, node::bvh_node)::bvh_node
    axis = rand(1:3)

    comparator = Nothing
    if axis == 1 
        comparator = (a, b) -> box_x_compare(a, b)
    elseif axis == 2
        comparator = (a, b) -> box_y_compare(a, b)
    else
        comparator = (a, b) -> box_z_compare(a, b)
    end
    
    object_span = end_ - start

    if object_span == 1
        node.left = objects[start]
        node.right = objects[start]
    elseif object_span == 2
        node.left = objects[start]
        node.right = objects[start + 1]
    else
        sort!(objects, start=start, stop=end_, by=comparator)
        mid = start + object_span / 2
        node.left = bvh_node(objects, start, mid)
        node.right = bvh_node(objects, mid, end_)
    end

    node.bbox = aabb(node.left.bbox, node.right.bbox)
end

function hit!(r::ray, ray_t::interval, rec::hit_record, node::bvh_node)::Bool
    if (!bbox.hit!(r, ray_t))
        return false
    end

    hit_left = node.left.hit!(r, ray_t, rec)
    hit_right = node.right.hit!(r, interval(ray_t.lo, ifelse(hit_left, rec.t, ray_t.hi)), rec)

    return hit_left || hit_right
end
