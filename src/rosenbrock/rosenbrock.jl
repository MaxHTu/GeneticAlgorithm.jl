function rosenbrock(
	population_size::Int,
    epochs::Int,
    next_generation_amt::Int,
    mutation_prob::Float64,
	fitness=rosenbrock,
    crossover=uniform_crossover,
    mutation=real_value_mutation
)
    initial_state = float_initial_state(population_size)

    fitness = x -> -rosenbrock(x)

    mutation = (x) -> mutation(x,mutation_prob)

    ga = GeneticAlgorithm.GA(
		population_size,
    	next_generation_amt,
    	epochs,
    	mutation_prob,
        1.0,
    	initial_state	
	)

    GeneticAlgorithm.optimize(
		ga,
    	fitness,
    	epochs,
    	next_generation_amt,
    	crossover,
    	mutation
	)

end
