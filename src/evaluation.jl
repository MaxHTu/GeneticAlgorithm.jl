"""
    sphere(x::Vector{<:Number})

Compute the sphere function value for a given input vector `x`.

The sphere function is defined as the sum of the squares of each element in `x`.

# Arguments
- `x`: Input vector.

# Returns
- The sphere function value.

"""
function sphere(x::Vector{<:Number})
    return sum(x .^ 2)
end

"""
    rosenbrock(x::Vector{<:Number}; a::Integer, b::Integer)

Compute the Rosenbrock function value for a given input vector `x`.

The Rosenbrock function is a non-convex function used as a performance test problem for optimization algorithms. It is defined as the sum of a series of terms involving the squares of differences between adjacent elements of `x`.

# Arguments
- `x`: Input vector.
- `a`: value for the variable a
- `b`: value for the variable b

# Returns
- The Rosenbrock function value.

"""
function rosenbrock(x::Vector{<:Number}; a::Integer = 1, b::Integer = 100)
    if length(x) == 2
        return v = (a-x[1])^2 + b * (x[2] - x[1]^2)^2
    end

    s = 0.0
    for i in range(1, length(x) - 1)
        s += 100.0 * (x[i + 1] - x[i] ^ 2) ^ 2 + (1.0 - x[i])^2
    end
    return s
end

"""
    quartic(x::AbstractVector{<:Number})

Compute the quartic function value for a given input vector `x`.

The quartic function is defined as the sum of the product of each element in `x` raised to the power of 4 and its index, plus a random number.

# Arguments
- `x`: Input vector.

# Returns
- The quartic function value.

"""
function quartic(x::AbstractVector{<:Number})
    return sum((1:length(x)) .* (x .^ 4)) + randn()
end

"""
    schwefel(x::AbstractVector{<:Number})

Compute the Schwefel function value for a given input vector `x`.

The Schwefel function is a multimodal function used as a performance test problem for optimization algorithms. It is defined as a sum of terms involving the sine function and the square root of the absolute value of each element in `x`.

# Arguments
- `x`: Input vector.

# Returns
- The Schwefel function value.

"""
function schwefel(x::AbstractVector{<:Number})
    return 418.9829 * length(x) - sum(x .* sin.(sqrt.(abs.(x))))
end

"""
    rastrigin(x::AbstractVector{<:Number})

Compute the Rastrigin function value for a given input vector `x`.

The Rastrigin function is a multimodal function used as a performance test problem for optimization algorithms. It is defined as a sum of terms involving the square of each element in `x`, minus 10 times the cosine of 2π times each element in `x`.

# Arguments
- `x`: Input vector.

# Returns
- The Rastrigin function value.

"""
function rastrigin(x::AbstractVector{<:Number})
    return 10 * length(x) + sum(x.^2 .- 10 .* cos.(2 * π .* x))
end

"""
    griewank(x::AbstractVector{<:Number})

Compute the Griewank function value for a given input vector `x`.

The Griewank function is a multimodal function used as a performance test problem for optimization algorithms. It is defined as the difference between two terms: the sum of the squares of each element in `x` divided by 4000, and the product of the cosine of each element in `x` divided by the square root of its index.

# Arguments
- `x`: Input vector.

# Returns
- The Griewank function value.

"""
function griewank(x::AbstractVector{<:Number})
    term1 = sum(x.^2) / 4000
    term2 = prod(cos.(x ./ sqrt.(1:length(x))))
    return term1 - term2 + 1
end

"""
    binarystring(x::AbstractVector{Bool})

Compute the fitness of a binary string unit.

# Arguments
- `x`: Input vector.

# Returns
- The digit sum of input vector.

"""
function binarystring(x::AbstractVector)
    return sum(x)
end