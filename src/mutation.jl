"""
    mutation!(unit::Vector{AbstractFloat}, mutRate::Real)
    mutation!(unit::Vector{Bool}, mutRate::Real)

Implements a bit string mutation that flips a single bit in a gene with the probability 1/length(gene)

# Arguments
- `gene`: Gene to be mutated.

# Returns
- A mutated gene.
"""
function mutation!(gene::Vector{Bool})
    prob = 1/length(gene)
    for i in range(1,length(gene))
        if rand() < prob
            gene[i] = !gene[i]
        end
    end
    return gene
end

"""
    mutation!(gene::Vector{Bool}, prob::Float64)

Implements a bit string mutation that flips a single bit in a gene with the probability prob

# Arguments
- `gene`: Gene to be mutated.
- `prob`: Probability with which a single bit is flipped

# Returns
- A mutated gene.
"""
function mutation!(gene::Vector{Bool}, prob::Float64)
    for i in range(1,length(gene))
        if rand() < prob
            gene[i] = !gene[i]
        end
    end
    return gene
end

"""
    mutation!(gene::Vector{Real}, prob::Real)

Implements a bit string mutation that selects a random number for a single bit in a gene with the probability prob

# Arguments
- `gene`: Gene to be mutated.
- `prob`: Probability with which a single bit is flipped

# Returns
- A mutated gene.
"""
function mutation!(gene::Vector{<:Real}, mutation_prob::Real, range::UnitRange{Float64})
    for i in 1:length(gene)
        if rand() < mutation_prob
            g = gene[i] + rand(range)
            if g > range[end] g = g - range[end] end
            if g < range[1] g = g + range[end] end
            gene[i] = g
        end
    end 
    return gene
end
