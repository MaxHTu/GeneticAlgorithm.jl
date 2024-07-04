#ToDO
function default_select_pair(population, fitness_arr)
	return sample(population, 2)
	#return sample(population, Weights(fitness_arr), 2)
end

"""
    selection(population::Vector, fitness::Vector)

Select one unit with higher fitness out of two randomly chosen unit from the population.

# Arguments
- `population`: Population vector.
- `fitness`: Vector of fitness values.

# Returns
- The unit with better fitness value.

"""
function selection(population::Vector, fitness::Vector)
    unit1, unit2 = rand(1:length(population), 2)
    return (fitness[unit1] > fitness[unit2]) ? population[unit1] : population[unit2]
end

"""
    tournamentSelection(population::Vector, fitness::Vector, tournamentSize::Int)

Select one unit with higher fitness over several tournament rounds with randomly chosen groups of unit from the population .

# Arguments
- `population`: Population vector.
- `fitness`: Vector of fitness values.
- `tournamentSize`: Size of tournament groups.

# Returns
- The unit with better fitness value.

"""
function tournamentSelection(population::Vector, fitness::Vector, tournamentSize::Int)
    choice = []

    for _ in 1:length(population)
        tournament = rand(1:length(population), tournamentSize)
        bestUnit = argmax(fitness[tournament])
        choice = population[tournament[bestUnit]]
    end

    return choice
end

export selection, tournamentSelection
