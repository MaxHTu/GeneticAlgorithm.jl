#ToDO
# https://en.wikipedia.org/wiki/Mutation_(genetic_algorithm)


"""
    bit_string_mutation(gene)
"""
function bit_string_mutation(gene::Vector{Bool})
    prob = 1/length(gene)
    for i in range(1,length(gene))
        if rand() < prob
            gene[i] = !gene[i]
        end
    end
    return gene
end

"""
    bit_string_mutation(gene, prob)
"""
function bit_string_mutation(gene, prob::Float64)
    for i in range(1,length(gene))
        if rand() < prob
            gene[i] = !gene[i]
        end
    end
    return gene
end

function real_value_mutation(gene::Vector{Float64}, mutation_prob::Float64)
    for i in range(1,length(gene))
        if rand() < mutation_prob
            g = gene[i] + rand(-100:100)
            if g > 100 g = g -100 end
            if g < -100 g = g + 100 end
            gene[i] = g
        end
    end 
    return gene
end

"""
    mutation!(unit::Vector, unitReal::Bool, mutRate::Float64)

Mutate an unit by changing its genes depending on its type and a mutation rate.

# Arguments
- `unit`: Unit to be mutated.
- `unitReal`: Type of unit, Real or Binary.
- `mutRate`: Mutation rate.

# Returns
- A mutated unit.
"""
function mutation(unit::Vector, unitReal::Bool, mutRate::Float64)
    for i in eachindex(unit)
        if rand() < mutRate
            unit[i] = unitReal ? rand(Float64) : !unit[i]
        end
    end

    return unit
end
