"""
    initPop(popSize::Integer, unitShape::AbstractVector{<:Integer}, unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}})

This function initializes a population of individuals for a genetic algorithm.

# Arguments
- `popSize::Integer`: The number of individuals in the population.
- `unitShape::AbstractVector{<:Integer}`: The shape of each individual in the population.
- `unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}}`: The range of values for each element in the individual.

# Returns
- `pop::Vector{<:AbstractArray}`: The initialized population.

# Details
- If `unitShape` is a scalar or a vector, the function generates random individuals with values from `unitValues`.
- If `unitShape` is a matrix, the function generates random individuals with values from `unitValues`.
"""

function initPop(popSize::Integer, unitShape::AbstractVector{<:Integer}, unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}})
    #function router for different range types
    # SKALAR and VECTOR shape
    if length(unitShape) == 1
        if unitValues isa AbstractRange && unitValues[1] isa AbstractFloat && unitValues[end] isa AbstractFloat
            return [transformRange(rand(Float64,unitShape[1]), 1, 0, unitValues[end], unitValues[1]) for _ in 1:popSize]
        end
        return [rand(unitValues,unitShape[1]) for _ in 1:popSize]
    end
    # MATRIX shape
    if unitValues isa AbstractRange && unitValues[1] isa AbstractFloat && unitValues[end] isa AbstractFloat
        return [transformRange(rand(Float64,unitShape[1],unitShape[2]), 1, 0, unitValues[end], unitValues[1]) for _ in 1:popSize]
    end
    return [rand(unitValues,unitShape[1],unitShape[2]) for _ in 1:popSize]
end