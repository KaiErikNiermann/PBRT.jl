mutable struct A
    A() = new()
end

mutable struct var"A*"
    var"A*"() = new()
end

mutable struct B
    str::String
    B() = new("default B")
end

mutable struct var"B*"
    var"B*"() = new()
end

mutable struct C
    val::var"A*"
    C() = new(var"A*"())
end

mutable struct var"C*"
    var"C*"() = new()
end

mutable struct D
    val::var"A*"
    D() = new(var"A*"())
end

mutable struct var"D*"
    var"D*"() = new()
end