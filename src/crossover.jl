include("initiation.jl")

"""
crossover

Recombinates two individuals by exchanging their genes from a random index onward.
TODO: This function should be problem-specific and should be provided by the user.
"""
function crossover(parent1::Individual, parent2::Individual)::Tuple{Individual, Individual}
    coPoint = rand(1:length(parent1.genes) - 1)
    child1 = BinaryIndividual(vcat(parent1.genes[1:coPoint], parent2.genes[coPoint+1:end]))
    child2 = BinaryIndividual(vcat(parent2.genes[1:coPoint], parent1.genes[coPoint+1:end]))
    return child1, child2
end

export crossover