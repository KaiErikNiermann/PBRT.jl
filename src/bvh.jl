
mutable struct BVHNode <: Hittable
    left::Hittable
    right::Hittable
    bbox::AABB
    function BVHNode(left::Hittable, right::Hittable, bbox::AABB)
        new(left, right, bbox)
    end
    BVHNode() = new(NULLHittable(), NULLHittable(), AABB())
end

function box_compare(a, b)
    a.lo < b.lo
end

box_x_compare(a, b) = box_compare(a.bbox.x, b.bbox.x)
box_y_compare(a, b) = box_compare(a.bbox.y, b.bbox.y)
box_z_compare(a, b) = box_compare(a.bbox.z, b.bbox.z)

function BVHNode(objects::Vector{Hittable}, start, end_, node::BVHNode)::BVHNode
    bbox = AABB()
    for i in start:end_
        bbox = AABB(bbox, objects[i].bbox)
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
        BVHNode(node.left, node.right, bbox)
    elseif object_span == 2
        node.left = objects[start]
        node.right = objects[start + 1]
        BVHNode(node.left, node.right, bbox)
    else
        objects[start:end_] = sort(objects[start:end_], lt=comparator)
        mid = start + trunc(Int, object_span / 2)

        node.left = BVHNode(objects, start, mid, BVHNode())
        node.right = BVHNode(objects, mid, end_, BVHNode())
        BVHNode(node.left, node.right, bbox)
    end

end

BVHNode(list::HittableList, node::BVHNode) = BVHNode(list.objects, 1, length(list.objects), node)

function hit!(node::BVHNode, r::Ray, ray_t::Interval, rec::HitRecord)::Bool
    if(!hit!(node.bbox, r, ray_t))
        return false
    end

    hit_left = hit!(node.left, r, ray_t, rec)
    hit_right = hit!(node.right, r, Interval(ray_t.lo, ifelse(hit_left, rec.t, ray_t.hi)), rec)

    return (hit_left || hit_right)
end
