"""
    crossover(parent1::Vector, parent2::Vector)

Recombinate two units by exchanging their genes from a random index onward.

# Arguments
- `parent1`: Parent unit 1.
- `parent2`: Parent unit 2.

# Returns
- Two recombined child units.

"""
function crossover(parent1::Vector, parent2::Vector)
    coPoint = rand(1:length(parent1) - 1)
    child1 = vcat(parent1[1:coPoint], parent2[coPoint + 1:end])
    child2 = vcat(parent2[1:coPoint], parent1[coPoint + 1:end])
    return child1, child2
end

export crossover