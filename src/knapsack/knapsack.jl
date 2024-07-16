function knapsack(
	population_size::Int,
	weight_limit::Int,
    epochs::Int,
    next_generation_amt::Int,
	fitness=knapsack_fitness,
    crossover=single_point_crossover,
    mutation=bit_string_mutation
)
	data = [
		("Laptop", 500, 2200),
		("Headphones", 150, 160),
		("Coffee Mug", 60, 350),
		("Notepad", 40, 333),
		("Water Bottle", 30, 192),
		("Mints", 50, 25),
		("Socks", 100, 38),
		("Tissues", 150, 80),
		("Phone", 500, 200),
		("Baseball Cap", 100, 70),
		("Shirt", 150, 75),
		("A", 1000, 50),
		("B", 105, 80),
		("C", 200, 400),
		("D", 130, 70)
	]

	initial_state = binary_initial_state(length(data),population_size)

	fitness_handler = v -> fitness(v, data, weight_limit)

	#println(sample(initial_state, Weights(fitness_handler), 2))
	#println(sample(initial_state, Weights(fitness), 2))

	ga = GeneticAlgorithm.GA(
		population_size,
    	next_generation_amt,
    	epochs,
    	0.2,
    	1.0,
    	initial_state	
	)

	GeneticAlgorithm.optimize(
		ga,
    	fitness_handler,
    	epochs,
    	next_generation_amt,
    	crossover,
    	mutation
	)
    
end

function knapsack_fitness(
	genome,
	data,
	weight_limit::Int64
)
	weight = 0
	value = 0
	for (i, thing) in enumerate(data)
		if genome[i] != 0
			weight += thing[3]
			value += thing[2]

			if weight > weight_limit
				return 0
			end
		end
	end
	return weight
end

"""
function knapsack(things::Vector{Tuple{String, Real, Real}}, weight_limit::Int)

end
"""