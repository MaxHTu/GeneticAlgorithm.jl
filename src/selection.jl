#ToDO
function default_select_pair(population, fitness_arr)
	return sample(population, 2)
	#return sample(population, Weights(fitness_arr), 2)
end