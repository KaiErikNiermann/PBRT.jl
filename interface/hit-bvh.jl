function PBRT.hit!(node::PBRT.bvh_node, r::PBRT.ray, ray_t::PBRT.interval, rec::PBRT.hit_record)::Bool
    new_hit_rec = hit_bvh(node, PBRT.ray_itval(r, ray_t), rec)
    rec.t = new_hit_rec.t
    rec.p = new_hit_rec.p
    rec.normal = new_hit_rec.normal
    red = new_hit_rec.mat.albedo.r
    green = new_hit_rec.mat.albedo.g
    blue = new_hit_rec.mat.albedo.b
    rec.mat = PBRT.lambertian(PBRT.color([red, green, blue]))
    rec.front_face = new_hit_rec.front_face
    return Bool(new_hit_rec.hit)
end