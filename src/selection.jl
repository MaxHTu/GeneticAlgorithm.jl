"""
selection

Selects one individual with higher fitness out of two randomly chosen individuals from the population.
"""
function selection(pop::Vector{Individual}, fitnesses::Vector{Float64})::Individual
    id1, id2 = rand(1:length(pop), 2)
    return (fitnesses[id1] > fitnesses[id2]) ? pop[id1] : pop[id2]
end

export selection