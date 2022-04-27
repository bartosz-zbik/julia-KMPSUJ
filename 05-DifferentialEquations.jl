
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
                    DifferentialEquations
------------------------------------------------------------
=#

# harmonic oscilator
hosc(du, u, p, t) = -u;
# problem definitoin
prob = SecondOrderODEProblem(hosc, 0.0, 1.0, (0.0, 10.0))
# solve
sol = solve(prob)
# plot results
plot(sol)

# SIRS model (inplace)
function sirs_model!(us, s, p, t)
    si = p[1] * s[2] * s[1]
    ir = p[2] * s[2]
    rs = p[3] * s[3]
    us[1] = rs - si # dS/dt
    us[2] = si - ir # dI/dt
    us[3] = ir - rs # dR/dt
end
initState = [0.99, 0.01, 0.0]
pvec = (2.0, 0.3, 0.01)
sirsp = ODEProblem(sirs_model!, initState, (0.0, 100.0), pvec)
sol = solve(sirsp)
plot(sol)
