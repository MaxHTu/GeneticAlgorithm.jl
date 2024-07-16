"""
    mutation!(
        gene::Union{AbstractMatrix{<:Real}, AbstractMatrix{<:Bool}, AbstractVector{<:Real}, AbstractVector{Bool}}, 
        mutation_prob::Real, 
        unitValues::Union{Type, AbstractVector{Bool}, AbstractVector{<:Real}, AbstractRange{<:Real}}
    )

Implements mutation that changes a element in a given genes with a given probability mutation_prob. 

# Arguments
- `gene`: Gene to be mutated.
- `mutation_prob`: Probability with which each single element in a gene is mutated
- `unitValues`: Type of unit.

# Returns
- A mutated gene.
"""

function mutation!(
    gene::Union{AbstractMatrix{<:Real}, AbstractMatrix{<:Bool}, AbstractVector{<:Real}, AbstractVector{Bool}}, 
    mutation_prob::Real, 
    unitValues::Union{Type, AbstractVector{Bool}, AbstractVector{<:Real}, AbstractRange{<:Real}}
    )

    for i in range(1, length(gene))
        if rand() < mutation_prob
            #mutation type switch on gene containing Bools or Reals
            if unitValues isa AbstractRange && unitValues[1] isa AbstractFloat && unitValues[end] isa AbstractFloat
                gene[i] = transformRange(rand(Float64), 1, 0, unitValues[end], unitValues[1])
            else
                gene[i] = gene isa Vector{Bool} ? !gene[i] : rand(unitValues)
            end
        end
    end

    return gene
end