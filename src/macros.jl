"""
macro that returns the time taken and writes it to a file for analysis, returns the value of the expression
"""
macro wtime(ex)
    quote
        local t1 = round(Int64, time() * 1_000_000_000) 
        local val = $(esc(ex))
        local t2 = round(Int64, time() * 1_000_000_000)

        open("/workspaces/Thesis/benchmarks/jl_time.csv", "a") do io
            write(io, "$t1\n")
            write(io, "$t2\n")
            write(io, "$(t2 - t1)\n")
        end
        
        val
    end
end


"""
macro to emulate a switch statement for nicer file parsing, allows for boolean matching
"""
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