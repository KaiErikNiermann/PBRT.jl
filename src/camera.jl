@kwdef struct Camera
    origin::Vec3
    ll_corner::Vec3
    horizontal::Vec3
    vertical::Vec3
    u::Vec3
    v::Vec3
    w::Vec3
    lens_radius::Float64
end

function compute_camera(lookfrom, lookat, vup, vfov, aspect_ratio, aperture, focus_dist)
    theta               = vfov * (pi / 180)
    viewport_height = 2.0 * tan(theta / 2)
    viewport_width  = aspect_ratio * viewport_height

    w = (lookfrom - lookat) / norm(lookfrom - lookat)
    u = (cross(vup, w)) / norm(cross(vup, w))
    v = cross(w, u)

    horizontal = focus_dist * viewport_width * u
    vertical = focus_dist * viewport_height * v

    Camera(
        origin      = lookfrom,
        ll_corner   = lookfrom - (horizontal / 2) - (vertical / 2) - (focus_dist * w),
        horizontal  = horizontal,
        vertical    = vertical,
        u           = u,
        v           = v,
        w           = w,
        lens_radius = aperture / 2
    )
end

function compute_ray(camera::Camera, p::Vec2)
    u, v   = p

    rd     = camera.lens_radius * random_in_unit_disk()
    offset = (camera.u * rd[1]) + (camera.v * rd[2])

    origin = camera.origin + offset
    direction = camera.ll_corner + (u * camera.horizontal) + (v * camera.vertical) - camera.origin - offset

    if length(direction) <= 1
        error("Direction vector must have at least 2 dimensions.")
    end

    Ray(
        camera.origin + offset,
        camera.ll_corner + (u * camera.horizontal) + (v * camera.vertical) - camera.origin - offset
    )
end

export compute_camera, compute_ray, Camera