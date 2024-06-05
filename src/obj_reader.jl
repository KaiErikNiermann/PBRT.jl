import MacroTools.rmlines

mutable struct obj <: hittable
    faces::Vector{Triangle}
    bbox::aabb
end

mutable struct Face
    vertices::Vector{Vector{Float64}}
    normals::Vector{Vector{Float64}}
    textures::Vector{Vector{Float64}}
end

Base.show(io::IO, f::Face) = print(io, "Face($(f.vertices), $( length(f.normals) ), $( length(f.textures) )")

mutable struct obj_scene
    # metadata
    name::String

    # obj_scene information 
    v_array::Vector{Float64}
    vn_array::Vector{Float64}
    vt_array::Vector{Float64}
    f_array::Vector{Face}
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

    f_array = Vector{Face}()

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
                            Face = split(i, "/")
                            push!(vertices, v_array[parse(Int64, Face[1])])
                            push!(textures, vt_array[parse(Int64, Face[2])])
                            push!(normals, vn_array[parse(Int64, Face[3])])
                        end
                        # vertex, normal
                        occursin(r"\d+\/\/\d+", i) => begin
                            Face = split(i, "//")
                            push!(vertices, v_array[parse(Int64, Face[1])])
                            push!(normals, vn_array[parse(Int64, Face[2])])
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

function has_vertex(t::Triangle, v::Vector{Float64})::Bool
    return v in [t.A, t.B, t.C]
end

"""
Creats a super Triangle that bounds a Face
"""
function create_super_triangle(v::Vector{Vector{Float64}}, vn::Vector{Vector{Float64}})::Triangle
    # TODO - implement super triangulation for delauny triangulation
end

function rot_matrix(v::Vector{Float64}, vn::Vector{Float64})::Matrix{Float64}
    k = [0.0, 0.0, 1.0]
    # Compute rotation axis and angle
    rot_axis = cross(vn, k)
    rot_angle = acos(dot(vn, k) / (norm(vn) * norm(k)))

    # Normalize rotation axis
    if norm(rot_axis) != 0.0
        rot_axis /= norm(rot_axis)
    end

    # Rotation matrix (Rodrigues' rotation formula)
    K = [
        0.0 -rot_axis[3] rot_axis[2];
        rot_axis[3] 0.0 -rot_axis[1];
        -rot_axis[2] rot_axis[1] 0.0
    ]

    I_m = Matrix{Float64}(I, 3, 3)
    rot_matrix = I_m + sin(rot_angle) * K + (1 - cos(rot_angle)) * K^2
    rot_matrix
end

function point_dim_reduction(p::Vector{Vector{Float64}}, rot_matrix)::Vector{Vector{Float64}}
    p_rot = Vector{Vector{Float64}}()
    for v in p
        v_rot = rot_matrix * v
        push!(p_rot, [v_rot[1], v_rot[2]])
    end
    p_rot
end

"""
Function to check if a point is inside the circumcircle of a Triangle
"""
function in_circumcircle(t::Triangle, v::Vector{Float64}, vn::Vector{Float64})::Bool
    rot_matrix = rot_matrix(v, vn)
    P1_2D, P2_2D, P3_2D, v_2D = point_dim_reduction([P1, P2, P3, v], rot_matrix)

    # Setup matrix for determinant calculation
    cc_det = det([
        P1_2D[1]-v_2D[1] P1_2D[2]-v_2D[2] (P1_2D[1]-v_2D[1])^2+(P1_2D[2]-v_2D[2])^2;
        P2_2D[1]-v_2D[1] P2_2D[2]-v_2D[2] (P2_2D[1]-v_2D[1])^2+(P2_2D[2]-v_2D[2])^2;
        P3_2D[1]-v_2D[1] P3_2D[2]-v_2D[2] (P3_2D[1]-v_2D[1])^2+(P3_2D[2]-v_2D[2])^2
    ])

    return cc_det > 0
end

"""
Function to check if an edge is not shared by an array of triangles
"""
function not_shared(e::Set{Vector{Float64}}, triangles::Vector{Triangle})::Bool
    return all([e ∉ t.edges for t in triangles])
end

"""
Boywer-Watson triangulation algorithm
"""
function triangulation(v::Vector{Vector{Float64}}, vn::Vector{Vector{Float64}})::Vector{Triangle}
    triangles = Vector{Triangle}()

    # Create super Triangle
    super_triangle = create_super_triangle(v, vn)
    push!(triangles, super_triangle)

    for (v, vn) in zip(v, vn)
        println("curr p ", v, " ", vn)

        # Find bad triangles
        bad_triangles = Vector{Triangle}()
        for t in triangles
            if in_circumcircle(t, v, vn)
                push!(bad_triangles, t)
            end
        end

        # Find boundary of polygonal hole
        polygon = Vector{Set{Vector{Float64}}}()
        for t in bad_triangles
            for e in t.edges
                if not_shared(e, bad_triangles)
                    push!(polygon, e)
                end
            end
        end

        # Remove bad triangles from triangulation
        filter!(x -> x ∉ bad_triangles, triangles)

        for e in polygon
            push!(triangles[idx], Triangle(e[1], e[2], v))
        end
    end

    triangles
end


