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

macro time_exec(file_expr, expr)
    quote
        # GC state **before** `expr`
        local _gc_stats0 = Base.gc_num()
        local _gc_time0  = Base.gc_time_ns()      # total GC time so far

        # wall-clock start
        local _t0 = time_ns()

        # run the payload
        local _val = $(esc(expr))

        # wall-clock stop
        local _t1 = time_ns()

        # GC state **after** `expr`
        local _gc_time1 = Base.gc_time_ns()
        local _gc_ns    = _gc_time1 - _gc_time0    # ns spent in GC

        # emit one CSV row
        open($(esc(file_expr)), "a") do io
            # start , end , elapsed , gc_time , elapsed_without_gc
            write(io,
                  "$_t0,$_t1,$(_t1-_t0),$_gc_ns,$((_t1-_t0)-_gc_ns)\n")
        end

        _val
    end
end


export guard, match, vec2, vec3, time_exec