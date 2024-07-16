"""
    default_selection(population::Union{AbstractVector,AbstractMatrix}, num::Integer)

Select num random genes from population.

# Arguments
- `population`: Population vector.
- `num`: Amount of genes to select

# Returns
- num selected genes

"""
function default_selection(population::Union{AbstractVector, AbstractMatrix}, num::Integer)
	return sample(population, num, replace=false)
end

"""
weighted_selection(population::AbstractVector, fitness::AbstractVector, num::Integer)

Select num random genes from population weight by the fitness of the genes

# Arguments
- `population`: Population vector.
- `fitness`: Vector of fitness values.
- `num`: Amount of genes to select

# Returns
- num selected genes

"""
function weighted_selection(population::AbstractVector, fitness_arr::AbstractVector, num::Integer)
    return sample(population, Weights(transformRange(fitness_arr, findmax(fitness_arr)[1], minimum(fitness_arr), 1, 0.0001)), num, replace=false)
end

"""
    tournament_selection(population::Vector, fitness::Vector, tournamentSize::Int, num::Integer)

Select one unit with higher fitness over several tournament rounds with randomly chosen groups of unit from the population .

# Arguments
- `population`: Population vector.
- `fitness`: Vector of fitness values.
- `tournamentSize`: Size of tournament groups.
- `num`: Amount of genes to select

# Returns
- The unit with better fitness value.

"""
function tournament_selection(population::AbstractVector, fitness::AbstractVector, num::Integer)
    selection = Vector{eltype(population)}(undef, num)
    tournamentSize = max(1, length(population) ÷ 2)
    for i in 1:num
        bestFit = rand(1:length(population))
        for _ in 1:tournamentSize
            competitor = rand(1:length(population))
            if fitness[competitor] > fitness[bestFit]
                bestFit = competitor
            end
        end
        selection[i] = population[bestFit]
    end
    return selection
end
