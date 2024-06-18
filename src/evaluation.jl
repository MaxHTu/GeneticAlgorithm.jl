function sphere(x)
    return sum(x .^ 2)
end

function rosenbrock(x)
    return sum(100.0 * (x[2:end] .- x[1:end-1] .^ 2) .^ 2 .+ (1.0 .- x[1:end-1]) .^ 2)
end

function step(x)
    return sum(floor.(x))
end

function quartic(x)
    return sum((1:length(x)) .* (x .^ 4)) + randn()
end

function schwefel(x)
    return 418.9829 * length(x) - sum(x .* sin.(sqrt.(abs.(x))))
end

function rastrigin(x)
    return 10 * length(x) + sum(x.^2 .- 10 .* cos.(2 * π .* x))
end

function F8(x)
    term1 = sum(x.^2) / 4000
    term2 = prod(cos.(x ./ sqrt.(1:length(x))))
    return term1 - term2 + 1
end