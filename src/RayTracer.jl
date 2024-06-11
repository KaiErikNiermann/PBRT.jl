rec_buf = hit_record()
sd_buf = scatter_data(color(), ray())

function ray_color(r::ray, world::hittable_list, depth)::color
    rec = rec_buf
    def_color = color([0.0, 0.0, 0.0])

    if(depth <= 0)
        return def_color
    end
    
    # 0.001 to avoid shadow acne
    if(hit!(world, r, interval(0.001, Inf), rec))
        sd = sd_buf
        if(scatter(rec.mat, r, rec, sd))
            return sd.attenuation * ray_color(sd.scattered, world, depth - 1)
        end
        return def_color
    end

    unit_direction = r.direction/norm(r.direction)
    t = 0.5 * (unit_direction[1] + 1.0)
    color((1.0 - t) * [1.0, 1.0, 1.0] + t * [0.5, 0.7, 1.0])
end

function validate_color(color, height, width)
    open("img1.ppm", "r") do valid_file
        open("cum_diff.ppm", "r") do validator_file
            curr_line = height * width
            # read all lines into an array 
            valid_lines = readlines(valid_file)
            validator_lines = readlines(validator_file)
            curr_valid_line = valid_lines[curr_line + 3]
            curr_valid_line = sum([Float64(i) for i in split(curr_valid_line)])
            curr_validator_line = Float64(validator_lines[curr_line])
        end
    end
end

function write_color(file, c::color, scale, height, width, validation=false)
    # Divide the color by the number of samples and gamma-correct 
    r::Float16 = sqrt(scale * c.r)
    g::Float16 = sqrt(scale * c.g)
    b::Float16 = sqrt(scale * c.b)

    color = string(256 * clamp.(r, 0.0, 0.999), " "
                 , 256 * clamp.(g, 0.0, 0.999), " "
                 , 256 * clamp.(b, 0.0, 0.999), "\n")

    if validation
        validate_color(color, height, width)
    end
    
    write(file, color)
end

function gen_img(width::Int64, height::Int64, file, world::hittable_list, img::image, c::camera, scale) 
    max_depth = img.max_depth
    spp = img.samples_per_pixel
    write_counter = 0
    write(file, "P3\n$width $height\n255\n")
    h_iter = tqdm(height-1:-1:0)
    for j in h_iter
        # println(stderr, "Scanlines remaining: ", j)
        set_description(h_iter, "sl remaining: $j")
        for i in 0:1:width-1
            pixel_color = color([0.0, 0.0, 0.0])
            for _ in 1:1:spp
                u = ( Float64(i) + random_double() ) / (width - 1)
                v = ( Float64(j) + random_double() ) / (height - 1)
                r = get_ray(c, u, v)
                pixel_color += ray_color(r, world, max_depth)
            end
            write_counter += 1
            validation = true
            write_color(file, pixel_color, scale, height, width, validation)
        end
    end
    println(write_counter)
end

function example_render()
    sc = custom_scene("../scenes/cottage_obj.obj") 
    open("image.ppm", "w") do file
        scale = 1.0 / sc.img.samples_per_pixel
        gen_img(sc.img.width, sc.img.height, file, sc.world, sc.img, sc.cam, scale)
    end
end