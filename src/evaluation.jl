function rosenbrock(x)
    return sum(100.0 * (x[2:end] .- x[1:end-1] .^ 2) .^ 2 .+ (1.0 .- x[1:end-1]) .^ 2)
end

#x = [2.0, 2.0]
#rosenbrock(x)