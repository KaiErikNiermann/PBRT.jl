
"""
    BVHNode(left::Hittable, right::Hittable, bbox::AABB)

A struct representing a node in a Bounding Volume Hierarchy (BVH) for efficient ray tracing.

- `left` , `right` are the left and right child nodes, which can be either individual hittable objects or other BVH nodes.
- `bbox` is the axis-aligned bounding box that encompasses both child nodes.
"""
@kwdef mutable struct BVHNode <: Hittable
    left::Hittable
    right::Hittable
    bbox::AABB
end

BVHNode(object::Hittable, bbox::AABB) = BVHNode(object, object, bbox)

const comparators = Dict(
    1 => (a, b) -> a.bbox.x.lo < b.bbox.x.lo,
    2 => (a, b) -> a.bbox.y.lo < b.bbox.y.lo,
    3 => (a, b) -> a.bbox.z.lo < b.bbox.z.lo
)

"""
    compute_bvh(objects::Vector{Hittable}, range::UnitRange{Int})::BVHNode

Computes a Bounding Volume Hierarchy (BVH) from a vector of hittable objects.
- `objects` is a vector of hittable objects that will be organized into the BVH.
- `range` is a unit range specifying the indices of the objects to be included in the BVH.
"""
function compute_bvh(objects::Vector{Hittable}, range::UnitRange{Int})::BVHNode
    bbox = reduce(
        (a, i) -> AABB(a, objects[i].bbox),
        collect(range), 
        init = AABB()
    )

    len = length(range)

    if !(len == 1 || len == 2)
        sorted_view = @view objects[range]

        sort!(
            sorted_view,
            lt  = comparators[axis_longest(bbox)],
            rev = false
        )

        mid = first(range) + (len ÷ 2) - 1

        return BVHNode(
            compute_bvh(objects, first(range):mid), 
            compute_bvh(objects, (mid + 1):last(range)), 
            bbox
        )
    end

    BVHNode(objects[range]..., bbox)
end

function count_nodes(node::Hittable)::Int
    if node isa BVHNode
        return 1 + count_nodes(node.left) + count_nodes(node.right)
    else
        return 1
    end
end

compute_bvh(h_list::HList) = begin
    @info "Computing BVH for $(length(h_list.objects)) objects"
    compute_bvh(h_list.objects, 1:length(h_list.objects))
end 

function hit!(node::BVHNode, ray::Ray, interval::Interval, record::HRecord)::Bool
    @guard !hit!(node.bbox, ray, interval) false

    hit_left  = hit!(node.left, ray, interval, record)
    hit_right = hit!(node.right, ray, Interval(interval.lo, ifelse(hit_left, record.t, interval.hi)), record)

    hit_left || hit_right
end

export BVHNode, compute_bvh, hit!
export box_compare, comparators