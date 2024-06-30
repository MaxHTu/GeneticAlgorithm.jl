#ToDO
# https://en.wikipedia.org/wiki/Mutation_(genetic_algorithm)


"""
    bit_string_mutation(gene)
"""
function bit_string_mutation(gene)
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
function bit_string_mutation(gene, prob)
    for i in range(1,length(gene))
        if rand() < prob
            gene[i] = !gene[i]
        end
    end
    return gene
end

function real_value_mutation(gene, mutation_prob::Float64)
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