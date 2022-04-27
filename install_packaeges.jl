import Pkg

packageslist = ["Plots", "CSV", "DataFrames", "StatsPlots",
	       "GLM", "LsqFit", "DifferentialEquations",
	       "LaTeXStrings"]

# install IJulia?
print("Do you want to use Jupyter with Julia? [y/n] ")
('y' in readuntil(stdin, '\n')) && push!(packageslist, "IJulia")

if "IJulia" in packageslist
	print("Do you use Jupyter lab/notebook that is alrady instaled on this device? [y/n] ")
	('y' in readuntil(stdin, '\n')) || (ENV["JUPYTER"] = "")
end

# in what env?
println("Do you want to install all packages in general env?? [y/n] ")
wantsingeneral = ('y' in readuntil(stdin, '\n'))
wantsingeneral || Pkg.activate(".")

# install all packages
Pkg.add(packageslist)

# if IJulia is installed outside general, than install a kernel with a correct project path
if ("IJulia" in packageslist) && !(wantsingeneral)
	import IJulia
	IJulia.installkernel("Julia-corse", "--project=$( pwd() )")
end

