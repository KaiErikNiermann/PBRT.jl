struct image
	width::Int64
	height::Int64
	samples_per_pixel::Int64
	max_depth::Int64
end

struct scene
	world::hittable_list
	cam::camera
	img::image
end

function empty_scene()::scene
	aspect_ratio = 16.0 / 9.0
	width = 400
	height = trunc(Int, width / aspect_ratio)
	samples_per_pixel = 50
	max_depth = 50
	cam = camera(
		[13.0, 2.0, 3.0], [0.0, 0.0, 0.0], [0.0, 1.0, 0.0], 20, 16.0 / 9.0, 10.0, 0.1,
	)

	world = hittable_list()
	node = bvh_node()

	world = bvh_node(world, node)
	world = hittable_list([world], world.bbox)

	scene(world, cam, image(width, height, samples_per_pixel, max_depth))
end

function final_scene()::scene
	# image 
	aspect_ratio = 3.0 / 2.0
	width = 1200
	height = trunc(Int, width / aspect_ratio)
	samples_per_pixel = 500
	max_depth = 50

	# world
	world = hittable_list()
	ground_material = lambertian(color([0.5, 0.5, 0.5]))
	push!(world, sphere([0.0, -1000.0, 0.0], 1000.0, ground_material))
	for a in -11:1:11
		for b in -11:1:11
			choose_mat = random_double()
			center = [a + 0.9 * random_double(), 0.2, b + 0.9 * random_double()]
			if (norm(center - [4.0, 0.2, 0.0]) > 0.9)
				if (choose_mat < 0.8)
					# diffuse
					albedo = color(random()) * color(random())
					sphere_material = lambertian(albedo)
					push!(world, sphere(center, 0.2, sphere_material))
				elseif (choose_mat < 0.95)
					# metal
					albedo = color(random(0.5, 1.0))
					fuzz = random_double(0.0, 0.5)
					sphere_material = metal(albedo, fuzz)
					push!(world, sphere(center, 0.2, sphere_material))
				else
					# glass
					sphere_material = dielectric(1.5)
					push!(world, sphere(center, 0.2, sphere_material))
				end
			end
		end
	end

	material1 = dielectric(1.5)
	push!(world, sphere([0.0, 1.0, 0.0], 1.0, material1))

	material2 = lambertian(color([0.4, 0.2, 0.1]))
	push!(world, sphere([-4.0, 1.0, 0.0], 1.0, material2))

	material3 = metal(color([0.7, 0.6, 0.5]), 0.0)
	push!(world, sphere([4.0, 1.0, 0.0], 1.0, material3))

	# camera
	cam = camera(
		[13.0, 2.0, 3.0], [0.0, 0.0, 0.0], [0.0, 1.0, 0.0], 20, 16.0 / 9.0, 10.0, 0.1,
	)

	scene(world, cam, image(width, height, samples_per_pixel, max_depth))
end

function basic_scene()::scene
	# image
	aspect_ratio = 16.0 / 9.0
	width = 400
	height = trunc(Int, width / aspect_ratio)
	samples_per_pixel = 50
	max_depth = 50

	# world
	world_l = hittable_list()
	node = bvh_node()

	ground_materal = lambertian(color([0.8, 0.8, 0.0]))
	center_material = lambertian(color([0.1, 0.2, 0.5]))
	left_material = dielectric(1.50)
	right_material = metal(color([0.8, 0.6, 0.2]), 1.0)

	push!(world_l, sphere([0.0, -100.5, -1.0], 100.0, ground_materal))
	push!(world_l, sphere([0.0, 0.0, -1.0], 0.5, center_material))
	push!(world_l, sphere([-1.0, 0.0, -1.0], 0.5, left_material))
	push!(world_l, sphere([-1.0, 0.0, -1.0], -0.45, left_material))
	push!(world_l, sphere([1.0, 0.0, -1.0], 0.5, right_material))

	world = bvh_node(world_l, node)

	print_bvh(world)

	world = hittable_list([world], world.bbox)

	# camera
	cam = camera(
		[3, 3, 2], [0, 0, -1], [0, 1, 0], 20, 16.0 / 9.0, 2, norm([3, 3, 2] - [0, 0, -1]),
	)

	scene(world, cam, image(width, height, samples_per_pixel, max_depth))
end

function angle_between(A::Vector{Float64}, B::Vector{Float64})::Float64
	return acosd(clamp(A ⋅ B / (norm(A) * norm(B)), -1, 1))
end

function split_quad(vertices)
    A, B, C, D = vertices

    # Calculate the lengths of the diagonals
    AC_length = norm(A - C)
    BD_length = norm(B - D)

    # Compare the lengths and split the quad accordingly
    if AC_length <= BD_length
        return [
            Triangle(A, B, C, metal(random_color(), 0.0)),
            Triangle(A, D, C, metal(random_color(), 0.0)),
        ]
    else 
        return [
            Triangle(A, B, D, metal(random_color(), 0.0)),
            Triangle(B, D, C, metal(random_color(), 0.0)),
        ]
    end

    return valid_triangles
end

function random_color()::color
    color([rand([0.0, 1.0]), rand([0.0, 1.0]), rand([0.0, 1.0])])
end

function custom_scene(obj_file)::scene
    sc = reader(obj_file)

    # image
    aspect_ratio = 16.0 / 9.0
    width = 400
    height = trunc(Int, width / aspect_ratio)
    samples_per_pixel = 50
    max_depth = 50

    # world
    world_l = hittable_list()
    node = bvh_node()

    ground_material = metal(color([0.8, 0.8, 0.0]), 0.4)

    push!(world_l, sphere([0.0, -100.5, -1.0], 100.0, ground_material))

    println("num faces in obj: ", length(sc.f_array))
    for face in sc.f_array
        if length(face.vertices) == 3
            t1 = Triangle(face.vertices[1], face.vertices[2], face.vertices[3], metal(random_color(), 0.0))
            push!(world_l, t1)
		elseif length(face.vertices) == 4
            triangles = split_quad(face.vertices)
            for t in triangles
                push!(world_l, t)
            end
        end
    end

    world = bvh_node(world_l, node)
    # print_bvh(world)
    world = hittable_list([world], world.bbox)

    # camera
    cam = camera(
        [-170, 20, 0], [0, 0, -1], [0, 1, 0], 20, 16.0 / 9.0, 2, norm([-170, 20, 0] - [0, 0, -1]),
    )

    return scene(world, cam, image(width, height, samples_per_pixel, max_depth))
end


function print_bvh(world, indent = "")
	# if type is a bvh node 
	if typeof(world) == bvh_node
		println(indent, "BVH Node:")
		println(indent, "├─ Left:")
		print_bvh(world.left, indent * "│  ")
		println(indent, "└─ Right:")
		print_bvh(world.right, indent * "   ")
	else
		println(indent, world)
	end
end
