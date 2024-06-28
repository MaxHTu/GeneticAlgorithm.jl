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
end