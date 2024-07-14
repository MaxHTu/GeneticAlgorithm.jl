using StatsBase

# variables
global n = 9*9 # size of sudoku
global exp = [1,2,3,4,5,6,7,8,9] # array of expected values
k = 0 # number of values that need to be filled
global j = 0 # number of values that are already filled

#s = [
#	0 4 8 2 0 0 0 0 1;
#	1 0 0 3 8 4 7 2 6;
#	3 0 0 7 0 1 9 4 8;
#	0 7 2 6 4 5 1 8 0;
#	8 0 0 0 0 2 4 0 0;
#	0 0 0 0 0 0 0 0 7;
#	0 8 4 0 0 0 3 0 0;
#	6 0 0 4 1 0 0 0 2;
#	0 0 3 0 0 0 0 7 4
#]

#s = [0 1 0 0 7 5 9 4 0;4 0 2 0 0 6 0 0 7;0 3 0 9 0 1 0 0 8;6 0 0 5 2 0 4 9 0;0 5 8 0 0 3 0 2 6;1 0 4 0 0 7 0 3 0;0 0 9 8 0 0 0 0 2;7 0 0 1 6 0 3 0 0;2 0 0 0 3 0 6 5 4]

s = [
	0 3 0 0 7 0 0 5 0;
	5 0 0 1 0 6 0 0 9;
	0 0 1 0 0 0 4 0 0;
	0 9 0 0 5 0 0 6 0;
	6 0 0 4 0 2 0 0 7;
	0 4 0 0 1 0 0 3 0;
	0 0 2 0 0 0 8 0 0;
	9 0 0 3 0 5 0 0 2;
	0 1 0 0 2 0 0 7 0
]

function aa(s)
	k = 0
	for x in range(1,9)
		for y in range(1,9)
			if s[x,y] != 0
				k += 1
			end
		end
	end
	println(k)
end

aa(s)

# functions

function baseSudoku(i)
    if i == 1
        r1 = [0,4,8,2,0,0,0,0,1]
	    r2 = [1,0,0,3,8,4,7,2,6]
	    r3 = [3,0,0,7,0,1,9,4,8]
	    r4 = [0,7,2,6,4,5,1,8,0]
	    r5 = [8,0,0,0,0,2,4,0,0]
	    r6 = [0,0,0,0,0,0,0,0,7]
	    r7 = [0,8,4,0,0,0,3,0,0]
	    r8 = [6,0,0,4,1,0,0,0,2]
	    r9 = [0,0,3,0,0,0,0,7,4]

        s = stack((r1,r2,r3,r4,r5,r6,r7,r8,r9))'

        return s
    end
    r1 = [0,3,0,0,7,0,0,5,0]
	r2 = [5,0,0,1,0,6,0,0,9]
	r3 = [0,0,1,0,0,0,4,0,0]
	r4 = [0,9,0,0,5,0,0,6,0]
	r5 = [6,0,0,4,0,2,0,0,7]
	r6 = [0,4,0,0,1,0,0,3,0]
	r7 = [0,0,2,0,0,0,8,0,0]
	r8 = [9,0,0,3,0,5,0,0,2]
	r9 = [0,1,0,0,2,0,0,7,0]

    s = stack((r1,r2,r3,r4,r5,r6,r7,r8,r9))'

    return s
end

function initialState()
	g = copy(s)
	for x in range(1,9)
		for y in range(1,9)
			if s[x,y] == 0
				t = exp[exp .∉ Ref(g[x,:])]
				t2 = t[t .∉ Ref(g[:,y])]
				if t2 != []
					g[x,y] = rand(t2)
				else
					g[x,y] = rand(t)
				end
			end
		end
	end
	return g
end

function fitness(genome)
	sudoku = copy(s)
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
	return f
end

function crossover_sudoku(s_1, s_2)
	s1 = copy(s_1)
	s2 = copy(s_2)
	# swap rows
	r = rand(1:9)
	#println(r)
	#display([s1[1:r,:]; s2[r+1:end,:]])
	#display([s2[1:r,:]; s1[r+1:end,:]])
	return [s1[1:r,:]; s2[r+1:end,:]], [s2[1:r,:]; s1[r+1:end,:]]
end

function uniform_crossover(s_1,s_2)
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

function mutation(o, probability=0.2)
	sudoku = copy(s)
	# pick random row
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

function select_pair(population, fitness_func)
	#return sample(population, 2, replace=false)
	return sample(population, Weights([fitness_func(g) for g in population]), 2)
end

function generate_population(n::Int)
	return [initialState() for i in range(1, n)]
end

function run()
	size = 250
	population = generate_population(size)
	fittest = 0
	generation = 1
	for i in range(1,300)
		if fittest == (2*k + 10*9*3)
			println("found solution")
			break
		end
			
		population = sort(population, by=fitness, rev=true)

		println(i)
		println([fitness(g) for g in population][1])

		if fittest != [fitness(g) for g in population][1]
			fittest = [fitness(g) for g in population][1]
			generation = i
		end

		next_generation = population[1:2]

		for j in range(1,trunc(Int, size/2)-1)
			parents = select_pair(population, fitness)
			#display(parents[1])
			#println(fitness(parents[1]))
			#display(parents[2])
			#println(fitness(parents[2]))
			a, b = uniform_crossover(parents[1], parents[2])
			#a, b = crossover_sudoku(parents[1], parents[2])
			a = mutation(a, 0.9+(i-generation)*0.05)
			b = mutation(b, 0.9+(i-generation)*0.05)
			push!(next_generation, a)
			push!(next_generation, b)
		end

		population = next_generation
	end
	display(population[1])
	println(checkIfSudokuFinished(population[1]))

end

function checkIfSudokuFinished(genome)
	for i in range(1,9)
		println(i)
		if sort(genome[i,:]) != exp
			println(false)
		end
		if sort(genome[:,i]) != exp
			println(false)
		end
	end
	# check all cubes, for each completed cube +10
	for i in range(1,3)
		for j in range(1,3)
			println(i,j)
			if sort(vec(genome[i+(i-1)*2:i+(i-1)*2+2,j+(j-1)*2:j+(j-1)*2+2])) != exp
				println(false)
			end
		end
	end
	return true
end

#println(checkIfSudokuFinished(sud))
run()