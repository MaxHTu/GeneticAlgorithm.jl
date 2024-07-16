"""
initPop(
    popSize::Integer,
    unitShape::AbstractVector{<:Integer},
    unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}}
)

Generate an initial Population with popSize genes. The genes have the shape unitShape and contain values of a given type or between a given range (the resulting values are of the type of the range borders).

# Arguments
'popSize' Determines how many genomes in one population, e.g. 10
'unitShape' Determines the dimension of the genome, e.g. [1] = Skalar, [3] = xyz-Vektor, [3,3] = 3x3 Matrix
'unitValues' Determines the possible genome states, either as type (e.g. Bool), Vector of possible elements or as Range

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