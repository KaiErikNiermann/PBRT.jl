import MacroTools.rmlines

mutable struct obj <: hittable 
    faces::Vector{triangle}
    bbox::aabb
end

mutable struct face
    vertices::Vector{Vector{Float64}}
    normals::Vector{Vector{Float64}}
    textures::Vector{Vector{Float64}}
end

mutable struct obj_scene
    # metadata
    name::String

    # obj_scene information 
    v_array::Vector{Float64}
    vn_array::Vector{Float64}
    vt_array::Vector{Float64}
    f_array::Vector{face}
end

macro match(v, block)
    block = rmlines(block)
    pairs = block.args
    ex = nothing

    for p in reverse(pairs)
        if isnothing(ex)
            ex = esc(p.args[3])
        else
            ex = Expr(:if, Expr(:call, :(==), esc(v), esc(p.args[2])), esc(p.args[3]), ex)
        end
    end

    ex
end

function scene_summary(sc::obj_scene)
    println("Scene: ", sc.name)
    println("Vertices: ", length(sc.v_array))
    println("Normals: ", length(sc.vn_array))
    println("Textures: ", length(sc.vt_array))
    println("Faces: ", length(sc.f_array))
end


"""
Wavefront .obj file parser
"""
function reader(file_name::String)::obj_scene
    v_array = Vector{Vector{Float64}}()
    vn_array = Vector{Vector{Float64}}()
    vt_array = Vector{Vector{Float64}}()

    f_array = Vector{face}()

    sc = obj_scene("", v_array, vn_array, vt_array, f_array)
    sc_meta = Vector{String}()

    for line in eachline(file_name)
        @match true begin
            startswith(line, "v ") => begin
                v = split(line[3:end], " ")
                vertex = Vector{Float64}()
                for i in v
                    push!(vertex, parse(Float64, i))
                end
                push!(v_array, vertex)
            end
            # faces 
            startswith(line, "f ") => begin
                f = split(line[3:end], " ")
                vertices = Vector{Vector{Float64}}()
                normals = Vector{Vector{Float64}}()
                textures = Vector{Vector{Float64}}()
                for i in f
                    @match true begin
                        # vertex, texture, normal
                        occursin(r"\d+\/\d+\/\d+", i) => begin
                            face = split(i, "/")
                            push!(vertices, v_array[parse(Int64, face[1])])
                            push!(textures, vt_array[parse(Int64, face[2])])
                            push!(normals, vn_array[parse(Int64, face[3])])
                        end
                        # vertex, normal
                        occursin(r"\d+\/\/\d+", i) => begin
                            face = split(i, "//")
                            push!(vertices, v_array[parse(Int64, face[1])])
                            push!(normals, vn_array[parse(Int64, face[2])])
                        end
                    end
                end
                push!(f_array, face(vertices, normals, textures))
            end
            # vertex normals
            startswith(line, "vn ") => begin
                vn = split(line[4:end], " ")
                vertex_normal = Vector{Float64}()
                for i in vn
                    push!(vertex_normal, parse(Float64, i))
                end
                push!(vn_array, vertex_normal)
            end
            # optional texture vertices
            startswith(line, "vt ") => begin
                vt = split(line[4:end], " ")
                vertex_texture = Vector{Float64}()
                for i in vt
                    push!(vertex_texture, parse(Float64, i))
                end
                push!(vt_array, vertex_texture)
            end
            # object name
            startswith(line, "o ") => println(line)
            # groups
            startswith(line, "g ") => println(line)
            # smoothing group
            startswith(line, "s ") => println(line)
            # headers and metadata 
            startswith(line, "# ") => begin
                push!(sc_meta, line)
            end
            # material library
            startswith(line, "mtllib ") => println(line)
            # material name
            startswith(line, "usemtl ") => println(line)
        end
    end
    sc.name = join(sc_meta, "\n")
    sc
end

"""
Function to check if a point is inside the circumcircle of a triangle
"""
function in_circumcircle(t::triangle, v::Vector{Float64}, vn::Vector{Float64})::Bool
    k = [0, 0, 1]
    rot_angle = acos(dot(vn, k) / (norm(vn) * norm(k)))
    rot_matrix = [cos(rot_angle) -sin(rot_angle) 0; sin(rot_angle) cos(rot_angle) 0; 0 0 1]
    
    P1 = t.A 
    P2 = t.B
    P3 = t.C

    P1_rot = rot_matrix * P1
    P2_rot = rot_matrix * P2
    P3_rot = rot_matrix * P3 
    v_rot = rot_matrix * v

    P1_2D = [P1_rot[1], P1_rot[2]]
    P2_2D = [P2_rot[1], P2_rot[2]]
    P3_2D = [P3_rot[1], P3_rot[2]]
    v_2D = [v_rot[1], v_rot[2]]

    p1_x = P1_2D[1] - v_2D[1]
    p1_y = P1_2D[2] - v_2D[2]
    p2_x = P2_2D[1] - v_2D[1]
    p2_y = P2_2D[2] - v_2D[2]
    p3_x = P3_2D[1] - v_2D[1]
    p3_y = P3_2D[2] - v_2D[2]

    return (p1_x^2 + p1_y^2) * (p2_x * p3_y - p2_y * p3_x) - 
           (p2_x^2 + p2_y^2) * (p1_x * p3_y - p1_y * p3_x) + 
           (p3_x^2 + p3_y^2) * (p1_x * p2_y - p1_y * p2_x) > 0
end

"""
Function to check if an edge is not shared by an array of triangles
"""
function not_shared(e::Vector{Float64}, triangles::Vector{triangle})

end

"""
Boywer-Watson triangulation algorithm
"""
function triangulation(faces::Vector{face})::Vector{triangle}
    triangles = Vector{triangle}()

    push!(triangles, triangle(0.0, 0.0, 0.0))

    for (v, vn) in zip(faces.vertices, faces.normals)
        bad_triangles = Vector{triangle}()
        for t in triangles
            if in_circumcircle(t, v, vn)
                push!(bad_triangles, t)
            end
        end
        polygon = Vector{Vector{Int64}}()   
        for t in bad_triangles
            for e in t.edges
                if not_shared(e, bad_triangles)
                    push!(polygon, e)
                end
            end
        end
        for t in bad_triangles
            delete!(triangles, t)
        end
        for e in polygon
            push!(triangles, triangle(e[1], e[2], v))
        end
    end
    for t in triangles
        if has_vertex(t, 0.0) 
            delete!(triangles, t)
        end
    end
    return triangles
end

sc = reader("scenes/cottage_obj.obj")

scene_summary(sc)

faces = sc.f_array

face_1 = faces[10]
triangle_1 = triangle(face_1.vertices[1], face_1.vertices[2], face_1.vertices[3])
v1 = face_1.vertices[4]

println(triangle_1)
println(v1)

print(in_circumcircle(triangle_1, v1, face_1.normals[1]))
