"""
    'popSize' Determines how many genomes in one population, e.g. 10
    'unitShape' Determines the dimension of the genome, e.g. [1] = Skalar, [3] = xyz-Vektor, [3,3] = 3x3 Matrix
    'unitValues' Determines the possible genome states, either as type (e.g. Bool), Vector of possible elements or as Range
    'offset' Variable to set an arbitrary offset for the rand genome state generation
"""

function initPop(popSize::Int, unitShape::AbstractVector{<:Integer}, unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}})
    #function router for different range types
    # SKALAR and VECTOR shape
    if(length(unitShape)==1)
        return [rand(unitValues,unitShape[1]) for _ in 1:popSize] end
    # MATRIX shape
    return [rand(unitValues,unitShape[1],unitShape[2]) for _ in 1:popSize]
end