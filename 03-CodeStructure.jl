
#=
In this file:
 - control flow (for, while, if-elseif-else, try-catch-finally)
 - begin-end
 - function declaration
 - structure declaration
 - module
=#


#=
------------------------------------------------------------
                    Basics
------------------------------------------------------------
In julia there are many reasons to put code into blocks (loops, function declaration etc.).
The rule is as follows:

startingKeyword something-optional
    code is here
end

startingKeyword - examples: for, while, struct, function, begin
=#

#=
------------------------------------------------------------
                    Control Flow
------------------------------------------------------------
=#

#                       while
t = 0
while t<10
    println(sin(t))
    t += 1
end

#                       for
for i in 1:10
    println(i^2)
end

# 1:10 is inclusive!!!
# very important when indexing arrays

a = [1, 10, 11, 22]
for i in 1:4
    println(a[i]^2)
end
#=
The same code in python:
"""
a = [1, 10, 11, 22]
for i in range(4):
    print(a[i]**2)
"""
The same code in C:
"""
int a[] = [1, 10, 11, 22]
for (int i=0; i<4; i++)
    printf("&i\n", a[i]*a[i])
"""
=#

a = Int[1, 10, 11, 22]
for i in a
    println(i)
end

a = Int[1, 10, 11, 22]
for i in eachindex(a)
    println(a[i])
end

# "in" can be replaced with '='
for i=1:10
    println(i^2)
end

# sometimes no need for loops inside loops
for i=1:3, j=10:10:30
    println("i: ", i, " and j: ", j)
end


#               if-elseif-else
a = 3
if a < 0
    println("negative")
elseif a > 0
    println("positive")
else
    println("equal 0")
end

# useful short forms
a < 0 && println("negative") # println will be executed IF a < 0
# the same as
if a < 0
    println("negative")
end

a < 0 || println("not negative") # println will be executed IF a < 0 will be false
# the same as
if !(a < 0)
    println("not negative")
end

# C like conditional expression
a > 0 ? "positive" : "not positive"



#               try-catch-finally
try
    sqrt("ten")
catch e
    println("You should have entered a numeric value")
    println(e)
end

try
    sqrt(-1)
catch x
    println("some error")
finally
    println("finish")
end


#=
------------------------------------------------------------
                    begin - end
------------------------------------------------------------
Returns the value of the lase expression.
=#
z = begin
    x = 7
    y =1
    x + y
end

z == 8

z = (x=7; y=1; x+y)



#=
------------------------------------------------------------
                    Functions
------------------------------------------------------------
=#

# basic structure
function foo()
    println("hello")
end

# une line shorthand
foo() = println("hello")

# with args
function baz(x, y)
    println("Hello $x and $y")
end

function baz2(x, y=nothing)
    if isnothing(y)
        println("Hello $x")
    else
        println("Hello $x and $y")
    end
end

# vararg functions example
bar(a,b,x...) = (a,b,x)

# keyword arguments with a semicolon ;
function myplot(x, y; style="solid", width=1, color="black")
    return (x, y, "$style-$width-$color")
end

# return something, by default the value of the lase expression
function myadd(x, y)
    x + y
end
# works the same as
function myadd(x, y)
    return x + y
    println("x+y") # won't be evaluated
end

# Type specifications
mysub(x::Int, y::Int) = x - y
mysub(x::Int16, y::Int16) = x - y

# retyrn value specification
mymul(x, y)::Float16 = x * y

# more advanced stuff
function mypower(x::T, y::T, n::Integer)::T where T<:Number
    n < 0 && error("n < 0")
    t::T = one(T)
    n == 1 && return t
    for i in 1:n
        t = t * (x+y)
    end
    return t
end



#=
------------------------------------------------------------
                    Structures
------------------------------------------------------------
=#

struct MyPoint
    x
    y
end
# constructor works
p = MyPoint(3, 7.0)
# access fields
p.x == 3
p.y == 7.0

struct MyPoint16
    x::Float16
    y::Float16
end

# parametric type
struct MyPointT{T<:Number}
    x::T
    y::T
end

# mutable now can be modified
mutable struct MyPointM
    x
    y
end

# abstract types
abstract type AbstractPoint end
abstract type AbstractPoint2D <: AbstractPoint end

mutable struct MyFinalPoint{T<:Real}<:AbstractPoint2D
    x::T
    y::T
end

# structures is structures
struct MyPointPair{T<:Real}
    first::MyFinalPoint{T}
    second::MyFinalPoint{T}
end


#=
------------------------------------------------------------
                    Module
------------------------------------------------------------
this is how code is grouped in larger projects
=#
module MyMod
    # here some code
    # local scope here

    export hello # what will be available for the user who imports this module with "using" statement
    mymod_abc = "abc"
    mymod_hello(t) = println("hello $t, $abc");
end # module

# we can use import or using
import .MyMod # needs a dot (package manager later)
MyMod.mymod_hello("name")

using .MyMod
mymod_hello("name")
mymod_abc # error, still undefined, only hello was exported
