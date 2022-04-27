
# something that must be here
println("Hello world!")
print("Hello world using print instead of println!\n") # '\n' to go to new line

#=
In this file:
 - Variable declaration
 - Basic boolean operations
 - Math
=#

#=
------------------------------------------------------------
                Variable declaration
------------------------------------------------------------
To declare a variable use "=".
Julia is a dynamic language so there is no need to explicitly pass types.
You can use:
typeof(x)
to get the type of x
=#

a = 7 # Int
a = 1.2 # Float64
a = 1//2 # Rational{Int64}
# Important note array indexing starts from 1!!!
a = [1, 3, 2] # Vector{Int64} (alias for Array{Int64, 1})
a = ["a", 2, pi] # Vector{Any}
a = 1:5 # UnitRange{Int64}
a = "Hello" # String
a = Dict(1 => '1', 2 => '2') # Dict{Int, Char}

typeof(a) # return the type of a 

b = Int8(3) # use a constructor to specify type of b as na Int8
b = Vector{Int8}(1:5) # Vector{Int8}
b = Vector{Complex{Float64}}(1:5) # Vector{Complex{Float64}}
b = Vector{Rational{Int8}}(1:5) # Vector{Rational{Int8}}
b = convert(Float16, 123) # function to convert types

typeof(b)

#=
# Static Types???
# not yet supported in global scope but you can use static types in functions:
function foo()
    x::Int8 = 3
    return x
end
# (more details later)
# Type assertion:
# "::" - from doc: :: operator is read as "is an instance of"
=#

a = 7; (a+1)::Int # will rise a TypeError if the type is wrong
#=
julia> a = 7.0; (a+1)::Int # will rise a TypeError
ERROR: TypeError: in typeassert, expected Int64, got a value of type Float64
Stacktrace:
 [1] top-level scope
   @ REPL[31]:1
=#


#=
------------------------------------------------------------
                Boolean operations
------------------------------------------------------------
# Use "==" for equality
# Use "===" to check if it's the same object (pythons "is" operator)
# Other math operations <, >, >=, <=.
# Julia supports utf-8 so ≥ and ≤ also work.
# Syntax for And, Or:  &&, ||
=#
a = 5; b = 7.0;
c = (a < b) # true
c = (a > 0 && b < 0) # false
c = (a > 0 || b < 0) # true

a = [1,2,3]
b = [1,2,3]
a == b # true
a === b # false
b = a # b now points to a
a === b # true

#=
------------------------------------------------------------
                        Math
------------------------------------------------------------
basic operators (actually functions, more later): + - * / (and % for modulo)
power: x^y
math functions work out of the box: sqrt, sin, cos, exp, log ...
Some consts are already declared: pi
Complex numbers: im (is the imagery part im^2 == -1 )
variable name can't begin with a number, because: 2x == 2*x
=#
1 + 1
2 * 3
exp(1)
sqrt(4)
sin(pi/2)
1 + exp(im*pi) # approx 0 + 0im
2π / 2 # approx π

Complex(1, 4) == 1 + 4im # true
cis(pi) == cos(pi) + im * sin(pi) # useful for complex calculations

div(3, 2) == 1 # true (used for division in integers)
3 ÷ 2 == 1 # true

# sqrt will rise an error if taken from negative number
sqrt(-1) #  DomainError with -1.0 ...
sqrt(Complex(-1)) # works fine

# some linear algebra (probably more later)
A = rand(3,3) # 3×3 Matrix{Float64}
b = rand(3) # 3-element Vector{Float64}
A\b # solve Ax = b
exp(A) # works fine
A^2 == A * A
A + A
A * b # 3×3 Matrix{Float64} × 3-element Vector{Float64} -> 3-element Vector{Float64}
[1.0 2.0 3.0] * [1.0, 2.0, 3.0] # 3-element Vector{Float64} × 3×3 Matrix{Float64}  -> 1-element Vector{Float64}
[1.0, 2.0, 3.0] * [1.0 2.0 3.0] # 3-element Vector{Float64} × 1×3 Matrix{Float64}  -> 3×3 Matrix{Float64}
