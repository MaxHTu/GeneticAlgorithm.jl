using StatsBase

# variables
global exp = [1,2,3,4,5,6,7,8,9] # array of expected values

"""
solveSudoku(
	sudoku::Matrix{Int64}
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

Gets the variables for the sudoku solver and passes them to the geneticAlgorithm pipeline

# Arguments
- `sudoku`: Sudoku to be solved
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

function solveSudoku(
	sudoku::Matrix{Int64}
    ;
    popSize::Integer = 1000,
    fitnessFunc::Function = x -> fitness(x, sudoku),
    unitValues::Union{Type,AbstractVector{Float64},AbstractRange{<:Real}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 250,
    crossRate::Real = 1,
    mutRate::Real = 0.2,
    nextGenAmt::Number = 2,
    selectionFunc::Function = GeneticAlgorithm.weighted_selection,
    crossoverFunc::Function = (x,y) -> crossoverSudoku(x,y),
    mutationFunc::Function = (a,b,c) -> sudokuMutation(a,sudoku,mutRate),
	terminationNum::Real = 100,
	initFunc::Function = x -> generatePopulation(x, sudoku)
)

    pop = geneticAlgorithm(
		fitnessFunc,
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
		terminationNum,
		initFunc=initFunc
	)

	println("Best Sudoku Solution:")
	display(pop[1])

	return pop

end

"""
	initialState(s::Matrix{Int64})

Generate a filled out sudoku (without zeros) from given base sudoku (with zeros). The sudoku is filled so that all the rows are already properly filled. If possible the function tries to also fill the columns and boxes properly.

# Arguments
- `s`: Given sudoku with zeros

# Returns
- Sudoku without zeros

"""
function initialState(s::Matrix{Int64})
	g = copy(s)
	for x in range(1,9)
		for y in range(1,9)
			if s[x,y] == 0
				t = exp[exp .∉ Ref(g[x,:])]
				t2 = t[t .∉ Ref(g[:,y])]
				if t2 != []
					g[x,y] = rand(t2)
				else
					g[x,y] = rand(exp[exp .∉ Ref(t)])
				end
			end
		end
	end
	return g
end

"""
	generatePopulation(n::Int, s::Matrix{Int64})

Generate an array of n filled out sudokus

# Arguments
- `n`: size of the population
- `s`: Given sudoku with zeros

# Returns
- Array of n possible Sudoku solutions without zeros

"""
function generatePopulation(n::Int, s::Matrix{Int64})
	return [initialState(s) for i in range(1, n)]
end

"""
	fitness(genome::Matrix{Int64}, sudoku::Matrix{Int64})

Evaluates the fitness of a given genome and the base sudoku. Starting from 0 a genome gets 10 points for each correctly filled column (reminder the rows are filled per definition by the initialization function) and each 3x3 box. 2 points are deducted for each value that cannot be in this column or box because of the values in the base sudoku.

# Arguments
- `genome`: filled out sudoku to be evaluated
- `s`: Base sudoku

# Returns
- A fitness value

"""
function fitness(genome::Matrix{Int64}, sudoku::Matrix{Int64})
	f = 0
	for x in range(1,9)
		for y in range(1,9)
			if genome[x,y] != 0 && sudoku[x,y] == 0
				if (genome[x,y] in sudoku[x,:]) || (genome[x,y] in sudoku[:,y]) || (genome[x,y] in sudoku[x-(x-1)%3:x-(x-1)%3+2,y-(y-1)%3:y-(y-1)%3+2])
					f = f - 2
				end
			end
		end
	end
	# check all rows and columns, for each completed row/col +10
	for i in range(1,9)
		#if sort(genome[i,:]) == exp
		#	f = f + 10
		#end
		if sort(genome[:,i]) == exp
			f = f + 10
		end
	end
	# check all cubes, for each completed cube +10
	for i in range(1,3)
		for j in range(1,3)
			if sort(vec(genome[i+(i-1)*2:i+(i-1)*2+2,j+(j-1)*2:j+(j-1)*2+2])) == exp
				f = f + 10
			end
		end
	end
	if f < 0
		return 0
	end
	return f
end


"""
	crossoverSudoku(s_1::Matrix{Int64}, s_2::Matrix{Int64})

Crosses 2 given sudokus row wise at a randomly generated row index.

# Arguments
- `s_1`: first filled out sudoku
- `s_2`: second filled out sudoku

# Returns
- 2 altered sudokus

"""
function crossoverSudoku(s_1::Matrix{Int64}, s_2::Matrix{Int64})
	s1 = copy(s_1)
	s2 = copy(s_2)
	# swap rows
	r = rand(1:9)
	return [s1[1:r,:]; s2[r+1:end,:]], [s2[1:r,:]; s1[r+1:end,:]]
end

"""
	uniformCrossover(s_1::Matrix{Int64}, s_2::Matrix{Int64})

Crosses 2 given sudokus row wise by generating a random value that indicates if the current row of both sudokus should be changed between them

# Arguments
- `s_1`: first filled out sudoku
- `s_2`: second filled out sudoku

# Returns
- 2 altered sudokus
"""
function uniformCrossover(s_1::Matrix{Int64}, s_2::Matrix{Int64})
	s1 = copy(s_1)
	s2 = copy(s_2)
	for i in range(1,9)
		if rand(0:1) == 1
			s1[i,:] = s_2[i,:]
			s2[i,:] = s_1[i,:]
		end
	end
	return s1,s2
end

"""
	sudokuMutation(o::Matrix{Int64}, sudoku::Matrix{Int64},  probability=0.2)

Go through all the rows of a sudoku and if a random value is larger than a probability, swap 2 values in that row

# Arguments
- `o`: sudoku to be mutated
- `sudoku`: base sudoku
- `probability`: probability with which we mutate a row

# Returns
- a mutated sudoku
"""
function sudokuMutation(o::Matrix{Int64}, sudoku::Matrix{Int64},  probability::Real=0.2)
	# if p < probability swap 2 numbers from selected row ()
	for r in range(1,9)
		p = rand()
		if p < probability
			pot = []
			for i in range(1,9)
				if sudoku[r,i] == 0
					push!(pot,i)
				end
			end
			i1 = rand(eachindex(pot))
			c1 = pot[i1]
			deleteat!(pot, i1)
			i2 = rand(eachindex(pot))
			c2 = pot[i2]

			v1 = o[r,c1]
			o[r,c1] = o[r,c2]
			o[r,c2] = v1
		end
	end
	return o
end