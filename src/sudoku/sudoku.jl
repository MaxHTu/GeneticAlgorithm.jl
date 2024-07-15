using StatsBase

# variables
global n = 9*9 # size of sudoku
global exp = [1,2,3,4,5,6,7,8,9] # array of expected values

#s = [0 4 8 2 0 0 0 0 1;1 0 0 3 8 4 7 2 6;3 0 0 7 0 1 9 4 8;0 7 2 6 4 5 1 8 0;8 0 0 0 0 2 4 0 0;0 0 0 0 0 0 0 0 7;0 8 4 0 0 0 3 0 0;6 0 0 4 1 0 0 0 2;0 0 3 0 0 0 0 7 4]

s = [0 0 0 8 2 0 0 9 0;0 5 7 6 0 9 0 1 3;0 8 4 0 3 1 0 0 0;0 7 8 0 6 0 4 5 0;0 0 9 1 0 0 0 0 6;5 6 0 3 0 0 9 8 0;8 3 0 4 0 6 0 0 0;0 0 5 0 1 8 0 0 0;1 0 6 7 5 0 2 0 0]

#s = [0 6 0 0 3 0 0 0 1;0 0 1 7 4 5 0 6 3;7 3 0 0 9 0 8 0 0;5 1 3 9 0 0 0 2 0;0 0 0 0 5 7 0 1 8;8 7 0 6 0 3 0 0 0;9 0 6 0 0 0 0 5 0;1 0 0 4 2 9 0 0 7;0 0 0 5 0 1 2 8 0]

#s = [0 1 0 0 7 5 9 4 0;4 0 2 0 0 6 0 0 7;0 3 0 9 0 1 0 0 8;6 0 0 5 2 0 4 9 0;0 5 8 0 0 3 0 2 6;1 0 4 0 0 7 0 3 0;0 0 9 8 0 0 0 0 2;7 0 0 1 6 0 3 0 0;2 0 0 0 3 0 6 5 4]

#s = [0 3 0 0 7 0 0 5 0;5 0 0 1 0 6 0 0 9;0 0 1 0 0 0 4 0 0;0 9 0 0 5 0 0 6 0;6 0 0 4 0 2 0 0 7;0 4 0 0 1 0 0 3 0;0 0 2 0 0 0 8 0 0;9 0 0 3 0 5 0 0 2;0 1 0 0 2 0 0 7 0]

function solveSudoku(
	sudoku::Matrix{Int64}
    ;
    popSize::Integer = 500,
    fitnessFunc::Function = x -> fitness(x, sudoku),
    unitValues::Union{Type,AbstractVector{Float64},AbstractRange{<:Real}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 250,
    crossRate::Real = 0.9,
    mutRate::Real = 0.9,
    nextGenAmt::Number = 2,
    selectionFunc::Function = GeneticAlgorithm.weighted_selection,
    crossoverFunc::Function = GeneticAlgorithm.single_point_crossover,
    mutationFunc::Function = GeneticAlgorithm.mutation!
)

    pop = geneticAlgorithm(
		fitnessFunc,
		popSize,
		unitValues,
		unitShape,
		genNum,
		selectionFunc,
		(x,y) -> crossoverSudoku(x,y),
		(a,b,c) -> sudokuMutation(a,mutRate),
		crossRate,
		mutRate,
		nextGenAmt,
		initFunc=x -> generatePopulation(x, sudoku)
	)

	display(pop[1])

	return pop

end

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

function generatePopulation(n::Int, s::Matrix{Int64})
	return [initialState(s) for i in range(1, n)]
end

function fitness(genome::Matrix{Int64}, sudoku::Matrix{Int64})
	sudoku = s
	f = 0
	#for x in range(1,9)
	#	for y in range(1,9)
	#		if genome[x,y] != 0 && sudoku[x,y] == 0
	#			if !(genome[x,y] in sudoku[x,:]) && !(genome[x,y] in sudoku[:,y]) && !(genome[x,y] in sudoku[x-(x-1)%3:x-(x-1)%3+2,y-(y-1)%3:y-(y-1)%3+2])
	#				f = f + 2
	#			end
	#		end
	#	end
	#end
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

function crossoverSudoku(s_1::Matrix{Int64}, s_2::Matrix{Int64})
	s1 = copy(s_1)
	s2 = copy(s_2)
	# swap rows
	r = rand(1:9)
	return [s1[1:r,:]; s2[r+1:end,:]], [s2[1:r,:]; s1[r+1:end,:]]
end

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

function sudokuMutation(o::Matrix{Int64}, probability=0.2)
	sudoku = copy(s)
	# pick random row where there are more than 2 values equal to 0 in the original sudoku
	r = rand(1:9)
	while sort(sudoku[r,:])[2] != 0
		r = rand(1:9)
	end
	p = rand()
	# if p < probability swap 2 numbers from selected row ()
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
	return o
end