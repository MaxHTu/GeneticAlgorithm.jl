"""
solveKnapsack(
	data::Vector{Tuple{String, Int64, Int64}},
	weightLimit::Real
	;
	popSize::Integer,
    fitnessFunc::Function,
    unitValues::Union{Type,AbstractVector{Float64},AbstractRange{<:Real}},
    unitShape::AbstractVector{<:Integer},
    genNum::Integer,
    crossRate::Real,
    mutRate::Real,
    nextGenAmt::Number,
    selectionFunc::Function,
    crossoverFunc::Function,
    mutationFunc::Function,
	terminationNum::Real
)

Gets the variables for the knapsack solver and passes them to the geneticAlgorithm pipeline. 
The data for the knapsack solver has to be in the format Vector{Tuple{String, Int64, Int64}} with the second value indicating the value of the thing and the third value indicating the weight of it.  

example data: 
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


# Arguments
- `data`: possible elements and their capacities for the knapsack problem
- `weightLimit`: maximum weight the knapsack can hold
- `popSize`: Size of population.
- `fitnessFunc`: Fitness function.
- `unitValues`: Type of unit.
- `unitShape`: Length of a unit vector.
- `genNum`: Number of generations.
- `crossRate`: Crossover rate.
- `mutRate`: Mutation rate.
- `nextGenAmt`: amount of genes that are automatically copied to new generation
- `selectionFunc`: Selection function.
- `crossoverFunc`: Crossover function.
- `mutationFunc`: Mutation function.
- `terminationNum`: number of iteration after which the algorithm aborts if there is no change in fitness value from the best gene

"""

function solveKnapsack(
	data::Vector{Tuple{String, Int64, Int64}},
	weightLimit::Real
	;
	popSize::Integer = 1000,
    fitnessFunc::Function = x -> fitness(x, sudoku),
    unitValues::Union{Type,AbstractVector{Float64},AbstractRange{<:Real}} = Bool,
    unitShape::AbstractVector{<:Integer} = [length(data)],
    genNum::Integer = 250,
    crossRate::Real = 1,
    mutRate::Real = 0.2,
    nextGenAmt::Number = 2,
    selectionFunc::Function = GeneticAlgorithm.weighted_selection,
    crossoverFunc::Function = GeneticAlgorithm.uniform_crossover,
    mutationFunc::Function = GeneticAlgorithm.mutation!,
	terminationNum::Real = 100
)

	pop = geneticAlgorithm(
		v -> knapsackFitness(v, data, weightLimit),
		popSize,
		unitValues,
		unitShape,
		genNum,
		selectionFunc,
		crossoverFunc,
		mutationFunc,
		crossRate,
		mutRate,
		nextGenAmt,
		terminationNum
	)

	println("Combination for the knapsack:")
	c = 0
	for i in range(1,length(pop[1]))
		if pop[1][i] == 1
			if c == 0
				print(data[i][1])
				c += 1
			end
				print(" + " * data[i][1])
		end
	end
    
end

function knapsackFitness(
	genome::Vector{Bool},
	data::Vector{Tuple{String, Int64, Int64}},
	weight_limit::Int64
)
	weight = 0
	value = 0
	for (i, thing) in enumerate(data)
		if genome[i] != 0
			weight += thing[3]
			value += thing[2]

			if weight > weight_limit
				return 0.001
			end
		end
	end
	return weight
end