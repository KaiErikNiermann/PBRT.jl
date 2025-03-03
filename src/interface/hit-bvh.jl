function PBRT.hit!(node::PBRT.BVHNode, ray::PBRT.Ray, interval::PBRT.Interval, rec::PBRT.HitRecord)::Bool
    updated_record = Main.hit_bvh(node, PBRT.RayData(ray, interval), rec)

    rec.t = updated_record.t
    rec.p = updated_record.p
    rec.normal = updated_record.normal
    red = updated_record.mat.albedo.r
    green = updated_record.mat.albedo.g
    blue = updated_record.mat.albedo.b
    rec.mat = PBRT.Lambertian(PBRT.Color([red, green, blue]))
    rec.front_face = updated_record.front_face
    
    return Bool(updated_record.hit)
end