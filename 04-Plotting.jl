#=
------------------------------------------------------------
                    Pllotting
------------------------------------------------------------
=#

# get some data
x = range(0, 1, length=20)
y = rand(20)

# function to plot anything
plot(x, y)

# other options can be passed
plot(x, y, label="some data", title="First plot")

# specify haw to plot
plot(x, y, st=:scatter)

# you can use an alias
scatter(x, y)

# use ! functions to add something to the plot
plot!(x, y .+ 1, st=scatter)

# other functions usful to edit an existing plot
title!("New title")
xlabel("x values")

# save figure
savefig("someplot.png")
