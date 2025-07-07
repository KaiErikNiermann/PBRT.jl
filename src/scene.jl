@kwdef struct Image
	width::Int64
	height::Int64
	spp::Int64
	max_depth::Int64
end

struct Scene
	world::Union{HList, BVHNode} 
	camera::Camera
	image::Image
end

function triangle_parser(scene::ObjectScene)::Vector{Triangle}
    return [triangle for face in scene.f_array for triangle in begin
        if length(face.vertices) == 3
            [compute_triangle(face.vertices[1:3]..., Lambertian(rand_rgbvec3()))]
        elseif length(face.vertices) == 4
            split_quad(face.vertices)
        else
            []
        end
    end]
end

function custom_scene(fp::Union{String, Nothing})::Scene 
	scene = fp !== nothing ? 
		compute_bvh(reduce(
			push!, 
			triangle_parser(scene_parser(fp)),
			init=HList()
		)) : HList()

	@info "[$(@__FILE__)] Scene loaded"

    return Scene(
		scene, 
		compute_camera(
			[-170, 20, 0], 
			[0, 0, -1],    
			[0, 1, 0],   
			20, 
			DEF_ASPECT_RATIO,
			2.0,
			norm([-170, 20, 0] - [0, 0, -1])
		), 
		Image(
			width = 50,
			height = trunc(Int, 50 / DEF_ASPECT_RATIO),
			spp = 1,
			max_depth = 50
		)
	)
end

export Scene, Image, custom_scene, triangle_parser