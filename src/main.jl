function ray_color(ray::Ray, world::Union{HList, BVHNode}, depth::Int64)::RGBVec3
    record       = HitRecord()
    color        = RGBVec3(@vec3 0.0, 0.0, 0.0)
    scatter_data = ScatterRecord(RGBVec3(), Ray()) 

    @guard depth ≤ 0 color

    if (hit!(world, ray, Interval(0.001, Inf), record))
        if (scatter(record.mat, record, scatter_data, ray))
            return scatter_data.attenuation * ray_color(scatter_data.scattered, world, depth - 1)
        end
        return color
    end
    
    t = 0.5 * (unit_v(ray.direction)[1] + 1.0)

    RGBVec3((1.0 - t) .* V3([1.0, 1.0, 1.0]) .+ t .* V3([0.5, 0.7, 1.0]))
end

function write_color(file::IOStream, rgb::RGBVec3, scale)
    colors = trunc.(Int, 256 .* clamp.(sqrt.(scale .* rgb.data), 0.0, 0.999))
    write(file, "$(colors[1]) $(colors[2]) $(colors[3])\n")
end

"""
    render(fp::Union{String, Nothing} = nothing) 


"""
function render(scene_file_path::Union{String, Nothing} = nothing)
    open("image.ppm", "w") do file
        scene = custom_scene(scene_file_path)
        image = scene.image
        scale = inv(scene.image.spp)

        write(file, "P3\n$(image.width) $(image.height)\n255\n")

        @info "[$(@__FILE__)] Starting rendering of scene with $(image.width) x $(image.height) pixels, $(image.spp) samples per pixel, and max depth of $(image.max_depth)."

        scan_lines = tqdm(image.height-1:-1:0)
        for y in scan_lines
            set_description(scan_lines, "[Rendering] At scan line: $y")
            for x in 0:image.width-1
                pixel_color = RGBVec3(@vec3 0.0, 0.0, 0.0)
                for _ in 1:image.spp
                    pixel_color += ray_color(
                        compute_ray(scene.camera, 
                            norm_coords(
                                V2([Float64(x), Float64(y)]), 
                                [image.width, image.height]
                            )
                        ),
                        scene.world,
                        image.max_depth
                    )
                end
                write_color(file, pixel_color, scale)
            end
        end

    end
end

export ray_color, write_color, render_scene