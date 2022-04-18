
#=
In this file:
 - Type structure (basics)
 - Union
 - UnionAll
=#

#=
------------------------------------------------------------
                    Type structure
------------------------------------------------------------
# Every object has a type (a=7.0; typeof(a) will return Float64).
# There is also something called AbstractType (for example: Number is na AbstractType)
# You can't make an object of type T being an AbstractType.
# An AbstractType may have subtypes being both types and AbstractTypes (Integer and Int64 are both subtypes of Number)
# Types operation:
# "<:" is subtype of
=#
# important note first. Int is an alias for Int64 or Int32 (depends on your system)
# Just type Int in julia REPL and look at the output

typeof(Number) # DataType
typeof(Int8) # DataType

Integer<:Number # true
Int8<:Number # true
Int8<:Integer # true

Int8<:Int64 # false
Int8<:Complex # false

Complex<:Number # true
Integer<:Real # true
Complex<:Real # false
Real<:Complex # false (this might be unintuitive for mathematicians)

# more IT examples, this is quite related to multiple dispatch (more later)
UInt128<:Unsigned # true
Float64<:AbstractFloat # true

AbstractVector<:AbstractArray # true
Vector<:AbstractVector # true

typeof(1:10) == UnitRange{Int64} # true
UnitRange{Int64}<:UnitRange # true
UnitRange<:AbstractArray # true
UnitRange<:AbstractMatrix # false

# functions are objects of type Function (but it looks a bit different)
typeof(Function) # DataType
typeof(sin) # typeof(sin) (singleton type of function sin, subtype of Function)
sin::Function # no error, type assertion passed

# + is a function so you can call it as a function
typeof(+) # typeof(+) (singleton type of function +, subtype of Function)
+(1,2,3) == 6 # true

# == equality is a function
typeof(==) # (singleton type of function ==, subtype of Function)
==(1,2) # false

#=
------------------------------------------------------------
                        Union
------------------------------------------------------------
=#
# It is sometimes useful to take a Union of types. Example:
MyUnion = Union{Int16, String, Char} # declare a variable
typeof(MyUnion) == Union # true

UInt16<:MyUnion # false
a = "abc"; typeof(a)<:MyUnion # true
a::MyUnion # type assertion also works

#=
------------------------------------------------------------
                        UnionAll
------------------------------------------------------------
# UnionAll from doc:
# A union of types over all values of a type parameter.
# UnionAll is used to describe parametric types where the values of some parameters are not known.
# (more about parametric types later)
=#

typeof(Rational) # is UnionAll which we will use our first example
# all those types have a parameter Int8, Int16, UInt128:
Rational{Int8}<:Rational # true
Rational{Int16}<:Rational # true
Rational{UInt128}<:Rational # true
# we can use Rational to declare a variable
a = Rational(4,5)
typeof(a) == Rational{Int64} # but a is an instance of Rational{Int64} the parameter is now specified

# Array works the same way, but has two parameters: ElementType and DimensionsNumber
typeof(Array) # is UnionAll

Array{Int64, 2} <: Array # two dimensional array of Int64

a = Array{Any, 3}(undef,3,3,3) # three dimensional array of Any
a::Array # three dimensional array of Any

# Matrix and Vector are UnionAll based on Array
Vector == Array{T, 1} where T # One dimensional Array
Matrix == Array{T, 2} where T # Two dimensional Array


# lets construct our own UnionAll based on Array (more later)
MyUnionAll = Array{Int8,n} where n # Array of Int8 elements but can have any dimension

a = MyUnionAll([1 2; 3 4])
a::Array{Int8,2} # is a Matrix of elementType Int8
a::MyUnionAll # passes this type check
# if we declare it in a traditional way we will get different output
[1 2; 3 4]::MyUnionAll # error
[1 2; 3 4]::Array{Int, 2} # works fine because the default type picked by Array (the constructor) was Int
