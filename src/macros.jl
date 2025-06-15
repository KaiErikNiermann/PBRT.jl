macro wtime(ex)
    quote
        local t1 = round(Int64, time() * 1_000_000) * 1_000 
        local val = $(esc(ex))
        local t2 = round(Int64, time() * 1_000_000) * 1_000

        open("/workspaces/Thesis/benchmarks/jl_time.csv", "a") do io
            write(io, "$t1\n")
            write(io, "$t2\n")
            write(io, "$(t2 - t1)\n")
        end
        
        val
    end
end

"""
    guard(cond, val)
    
Macro that simplifies the syntax for early conditional returns
"""
macro guard(cond, val)
    return :( $(esc(cond)) && return $(esc(val)) )
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

macro vec2(xs...) 
    return :(V2([$(xs...)...]))
end

macro vec3(xs...)
    return :(V3([$(xs...)...]))
end