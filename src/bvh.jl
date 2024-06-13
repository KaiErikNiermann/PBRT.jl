
mutable struct bvh_node <: hittable
    left::hittable
    right::hittable
    bbox::aabb
    function bvh_node(left::hittable, right::hittable, bbox::aabb)
        new(left, right, bbox)
    end
    bvh_node() = new(null_obj(), null_obj(), aabb())
end

function box_compare(a, b)
    a.lo < b.lo
end

box_x_compare(a, b) = box_compare(a.bbox.x, b.bbox.x)
box_y_compare(a, b) = box_compare(a.bbox.y, b.bbox.y)
box_z_compare(a, b) = box_compare(a.bbox.z, b.bbox.z)

function bvh_node(objects::Vector{hittable}, start, end_, node::bvh_node)::bvh_node
    bbox = aabb()
    for i in start:end_
        bbox = aabb(bbox, objects[i].bbox)
    end

    axis = longest_axis(bbox)

    comparator = if axis == 1 
                    box_x_compare
                elseif axis == 2
                    box_y_compare
                else
                    box_z_compare
                end
    
    object_span = end_ - start

    if object_span == 1
        node.left = objects[start]
        node.right = objects[start]
        bvh_node(node.left, node.right, bbox)
    elseif object_span == 2
        node.left = objects[start]
        node.right = objects[start + 1]
        bvh_node(node.left, node.right, bbox)
    else
        objects[start:end_] = sort(objects[start:end_], lt=comparator)
        mid = start + trunc(Int, object_span / 2)

        node.left = bvh_node(objects, start, mid, bvh_node())
        node.right = bvh_node(objects, mid, end_, bvh_node())
        bvh_node(node.left, node.right, bbox)
    end

end

bvh_node(list::hittable_list, node::bvh_node) = bvh_node(list.objects, 1, length(list.objects), node)

function hit!(node::bvh_node, r::ray, ray_t::interval, rec::hit_record)::Bool
    if(!hit!(node.bbox, r, ray_t))
        return false
    end

    hit_left = hit!(node.left, r, ray_t, rec)
    hit_right = hit!(node.right, r, interval(ray_t.lo, ifelse(hit_left, rec.t, ray_t.hi)), rec)

    return (hit_left || hit_right)
end
