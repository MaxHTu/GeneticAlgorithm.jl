"""
    mutation!(gene, mutation_prob, unitValues)

Mutates the given `gene` based on the `mutation_prob` and `unitValues`.

# Arguments
- `gene`: A matrix or vector containing real numbers or boolean values.
- `mutation_prob`: The probability of mutation for each element in the `gene`.
- `unitValues`: A type or vector representing the range of values for mutation.

# Details
- For each element in the `gene`, if a random number is less than `mutation_prob`, the element is mutated.
- If `unitValues` is an abstract range of floating-point numbers, the mutated element is transformed to fit within the range.
- If `unitValues` is a vector of boolean values, the mutated element is negated.
- Otherwise, the mutated element is replaced with a random value from `unitValues`.

# Returns
The mutated `gene`.

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