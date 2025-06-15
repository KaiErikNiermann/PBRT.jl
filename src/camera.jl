@kwdef struct Camera
    origin::V3
    ll_corner::V3
    horizontal::V3
    vertical::V3
    u::V3
    v::V3
    w::V3
    lens_radius::Float64
end

function compute_camera(lookfrom, lookat, vup, vfov, aspect_ratio, aperture, focus_dist)
    θ               = vfov * (pi / 180)
    viewport_height = 2.0 * tan(θ / 2)
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

function compute_ray(camera::Camera, p::V2)
    u, v   = p

    rd     = camera.lens_radius * random_in_unit_disk()
    offset = (camera.u * rd[1]) + (camera.v * rd[2])

    Ray(
        camera.origin + offset,
        camera.ll_corner + (u * camera.horizontal) + (v * camera.vertical) - camera.origin - offset
    )
end

export compute_camera, compute_ray, Camera