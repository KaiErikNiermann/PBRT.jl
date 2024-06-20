function PBRT.hit!(node::PBRT.bvh_node, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    return Bool(hit_bvh(node, PBRT.ray_itval(r, ray_t), rec)) # redefined function
end