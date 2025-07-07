import MacroTools.rmlines

mutable struct Object <: Hittable
    faces::Vector{Triangle}
    bbox::AABB
end

mutable struct Face
    vertices::Vector{Vector{Float64}}
    normals::Vector{Vector{Float64}}
    textures::Vector{Vector{Float64}}
end

mutable struct ObjectScene
    name::String
    v_array::Vector{Float64}
    vn_array::Vector{Float64}
    vt_array::Vector{Float64}
    f_array::Vector{Face}
end

function scene_summary(sc::ObjectScene)
    println("Scene: ", sc.name)
    println("Vertices: ", length(sc.v_array))
    println("Normals: ", length(sc.vn_array))
    println("Textures: ", length(sc.vt_array))
    println("Faces: ", length(sc.f_array))
end

function scene_parser(file_path::String)::ObjectScene
    v_array  = Vector{Vector{Float64}}()
    vn_array = Vector{Vector{Float64}}()
    vt_array = Vector{Vector{Float64}}()

    f_array = Vector{Face}()

    sc = ObjectScene("", v_array, vn_array, vt_array, f_array)
    sc_meta = Vector{String}()

    for line in eachline(file_path)
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
                        # object planes
                        occursin(r"\d+\/\d+\/\d+", i) => begin
                            # vertex, texture, normal
                            Face = split(i, "/")
                            push!(vertices, v_array[parse(Int64, Face[1])])
                            push!(textures, vt_array[parse(Int64, Face[2])])
                            push!(normals, vn_array[parse(Int64, Face[3])])
                        end
                        # lights and ground planes
                        occursin(r"\d+\/\/\d+", i) => begin
                            # vertex, normal
                            Face = split(i, "//")
                            # push!(vertices, v_array[parse(Int64, Face[1])])
                            # push!(normals, vn_array[parse(Int64, Face[2])])
                        end
                    end
                end
                push!(f_array, Face(vertices, normals, textures))
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
            startswith(line, "o ") => begin end
            # groups
            startswith(line, "g ") => begin end
            # smoothing group
            startswith(line, "s ") => begin end
            # headers and metadata 
            startswith(line, "# ") => begin
                push!(sc_meta, line)
            end
            # material library
            startswith(line, "mtllib ") => begin end
            # material name
            startswith(line, "usemtl ") => begin end
        end
    end
    sc.name = join(sc_meta, "\n")
    sc
end