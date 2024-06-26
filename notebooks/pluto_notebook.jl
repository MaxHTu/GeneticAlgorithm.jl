### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ 9d73e086-354e-426e-828f-7155fbe20ac3
#PSEUDOCODE
evolution(
	#Fitness Funktion
	fitness=func,
	#Crossover Funktion
	crossover=func,
	#Kollektion aller Grunddaten
	data=array,
	#Größe der Population pro Epoche
	population_size=10,
	#Mögliche Ausgänge (bspw. Sudoku: Zahlen zwischen 1 und 9)
	gen_range=[0,1]/[1:9...]/[0.0001,0.01,0.02],
	#Modus, damit werden Fitness Funktion usw. schon preselected package intern
	mode=knapsack/sudoku/dgl,
	#Anzahl Kandidaten die direkt in die nächste Generation übernommen werden
	#TODO: Anteil oder absolute Zahl?
	k=0.2,
	#Anzahl Iterationen
	epochs=50,
	#TODO: Crossover Modus nachdenken ... Nur Cut oder auch Fenster z.B.
	crossover_mode=cut/window,
	#Funktion wonach parents fürs Crossover gewählt werden
	select_pair=func,
	#Mutation Funktion
	mutation=func,
	#Maximale Anzahl an Mutationen
	#TODO: Anteil oder absolute Zahl?
	max_mutation_amount=3
	#Wahrscheinlickeit dass mutiert wird
	#Auto:
	#Je näher die aktuelle Iteration an der Endepoche dran ist, desto weniger soll mutiert werden
	#Je mehr die Kandidaten der aktuellen Iteration sich gleichen, desto mehr soll mutiert werden (nach Fitnessscore)
	mutation_prob=0.2/auto,
)

# ╔═╡ 3af630ca-3051-42c7-aa39-000220018c38
#DONE
function generate_genome(size::Int, rng::Array{<:Number})  rand(rng,size) end

# ╔═╡ 226db1a9-4fb1-4326-9136-e278ce4563bf
#DONE
function init_population(size::Int, n::Int, rng::Vector{Int64})  
	return [generate_genome(size,rng) for i in range(1, n)]
end

# ╔═╡ 93b6d893-1d57-4368-a329-e13ecfdfe768
#DONE
function default_select_pair(population, fitness_arr)
	return sample(population, Weights(fitness_arr), 2)
end

# ╔═╡ 7b8396b6-8c02-4390-a18d-63b810dc5be5
#TODO: code default fitness
function default_fitness(genome, data)
	weight_limit=3000
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

# ╔═╡ 3e9b92dd-eaea-40f1-a4f3-f51858050d30
#TODO: window mode implementation
function default_crossover(ga, gb, mode)
	if(mode == "window") return end
	r = rand(1:length(ga))
	return [ga[1:r]; gb[r+1:length(ga)]], [gb[1:r]; ga[r+1:length(ga)]]
end

# ╔═╡ 9b5da072-0ba1-4fa1-8cb3-1f77c44d733f
#TODO: mutation function
function default_mutation(genome, prob, amount)
	 return genome
end

# ╔═╡ 2e40842a-de4c-4dea-a716-fbc59df0092c
function new_run(
	pop_size,
	data,
	gen_range,
	epochs,
	fitness,
	k,
	select_pair,
	crossover,
	crossover_mode,
	mutation,
	max_mutation_amount,
	mutation_prob
)
	#Default values
	POP_SIZE=10
	DATA=[]
	GEN_RANGE=[0,1]
	EPOCHS=10
	FITNESS=default_fitness
	K=2
	SELECT_PAIR=default_select_pair
	CROSSOVER=default_crossover
	CROSSOVER_MODE="cut"
	MUTATION=default_mutation
	MAX_MUTATION_AMOUNT=1
	MUTATION_PROB=0.2
		
	#Enums
	if(pop_size != undef) POP_SIZE=pop_size end
	if(!isempty(DATA)) DATA=data end
	if(!isempty(gen_range)) GEN_RANGE=gen_range end
	if(epochs != undef) EPOCHS=epochs end
	if(fitness != undef) FITNESS=fitness end
	if(k != undef) K=k end
	if(select_pair != undef) SELECT_PAIR=select_pair end
	if(crossover != undef) CROSSOVER=crossover end
	if(crossover_mode != undef) CROSSOVER_MODE=crossover_mode end
	if(mutation != undef) MUTATION=mutation end
	if(max_mutation_amount != undef) MAX_MUTATION_AMOUNT=max_mutation_amount end
	if(mutation_prob != undef) MUTATION_PROB=mutation_prob end

	dsize = size(DATA)[1]
	
	#Initialize start population for generation 0 
	population = init_population(dsize,POP_SIZE,GEN_RANGE)

	handler = v -> FITNESS(v,DATA)
	
	for i in range(1,EPOCHS)
		population = sort(population, by=handler, rev=true)
		fitness_arr = handler.(population)
		K = K<1 ? K*size(population) : K

		next_generation = population[1:K]

		for j in range(1, trunc(Int, POP_SIZE/2)-1)
			#select pair to crossover and mutate
			parents = SELECT_PAIR(population, fitness_arr)
			#ka ab hier geht das nicht mehr, hab nicht weiter geschafft
			#---------------------------------------
			#call crossover function
			a, b = CROSSOVER(parents[1], parents[2],CROSSOVER_MODE)
			#mutation step
			a = MUTATION(a, MUTATION_PROB, MAX_MUTATION_AMOUNT)
			b = MUTATION(b, MUTATION_PROB, MAX_MUTATION_AMOUNT)
			push!(next_generation, a)
			push!(next_generation, b)
		end

		population = next_generation
	end
end

# ╔═╡ 65ba9e2d-2014-4813-a5fd-4caf72779cfb
things = [
	("Laptop", 500, 2200),
    ("Headphones", 150, 160),
    ("Coffee Mug", 60, 350),
    ("Notepad", 40, 333),
    ("Water Bottle", 30, 192),
	("Mints", 5, 25),
	("Socks", 10, 38),
    ("Tissues", 15, 80),
    ("Phone", 500, 200),
    ("Baseball Cap", 100, 70),
	("Shirt", 5, 75),
	("A", 10, 50),
    ("B", 105, 80),
    ("C", 200, 400),
    ("D", 130, 70)
]

# ╔═╡ 0f0ab8d4-d2f2-443c-857d-4f4a83a6ee81
rslt = new_run(10,
	things,
	[0,1],
	10,
	undef,
	2,
	undef,
	undef,
	undef,
	undef,
	1,
	0.2)

# ╔═╡ Cell order:
# ╠═9d73e086-354e-426e-828f-7155fbe20ac3
# ╠═3af630ca-3051-42c7-aa39-000220018c38
# ╠═226db1a9-4fb1-4326-9136-e278ce4563bf
# ╠═93b6d893-1d57-4368-a329-e13ecfdfe768
# ╠═7b8396b6-8c02-4390-a18d-63b810dc5be5
# ╠═3e9b92dd-eaea-40f1-a4f3-f51858050d30
# ╠═9b5da072-0ba1-4fa1-8cb3-1f77c44d733f
# ╠═2e40842a-de4c-4dea-a716-fbc59df0092c
# ╠═0f0ab8d4-d2f2-443c-857d-4f4a83a6ee81
# ╠═65ba9e2d-2014-4813-a5fd-4caf72779cfb
