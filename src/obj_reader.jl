import MacroTools.rmlines

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

function reader(file_name::String) 
    for line in eachline(file_name)
        @match true begin   
            startswith(line, "v ") => println(line)
            startswith(line, "f ") => println(line)
            startswith(line, "vn ") => println(line)
            startswith(line, "vt ") => println(line)
            startswith(line, "o ") => println(line)
            startswith(line, "g ") => println(line)
            startswith(line, "s ") => println(line)
            startswith(line, "# ") => println(line)
            startswith(line, "mtllib ") => println(line)
            startswith(line, "usemtl ") => println(line)
        end
    end
end

reader("scenes/cottage_obj.obj")

