var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = GeneticAlgorithm","category":"page"},{"location":"#GeneticAlgorithm","page":"Home","title":"GeneticAlgorithm","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for GeneticAlgorithm.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [GeneticAlgorithm]","category":"page"},{"location":"#GeneticAlgorithm.binarystring-Tuple{Any}","page":"Home","title":"GeneticAlgorithm.binarystring","text":"binarystring(x)\n\nCompute the fitness of a binary string unit.\n\nArguments\n\nx: Input vector.\n\nReturns\n\nThe digit sum of input vector.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.crossover-Tuple{Vector, Vector}","page":"Home","title":"GeneticAlgorithm.crossover","text":"crossover(parent1::Vector, parent2::Vector)\n\nRecombinate two units by exchanging their genes from a random index onward.\n\nArguments\n\nparent1: Parent unit 1.\nparent2: Parent unit 2.\n\nReturns\n\nTwo recombined child units.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.genAlgo-Tuple{Int64, Bool, Int64, Function, Int64, Float64, Float64}","page":"Home","title":"GeneticAlgorithm.genAlgo","text":"genAlgo(\n    popSize::Int,\n    unitReal::Bool,\n    unitLen::Int,\n    fitnessFunc::Function,\n    genNum::Int,\n    crossRate::Float64,\n    mutRate::Float64\n)\n\nEvolve the population of units for a specified number of generations. The loop creates a new population every generation by selecting two units with higher fitness, recombinating and mutating them until the old population can be replaced by a fitter one.\n\nArguments\n\npopSize: Size of population.\nunitReal: Binary or real unit representation.\nunitLen: Length of a unit vector.\nfitnessFunc: Fitness function.\ngenNum: Number of generations.\ncrossRate: Crossover rate.\nmutRate: Mutation rate.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.griewank-Tuple{Any}","page":"Home","title":"GeneticAlgorithm.griewank","text":"griewank(x)\n\nCompute the Griewank function value for a given input vector x.\n\nThe Griewank function is a multimodal function used as a performance test problem for optimization algorithms. It is defined as the difference between two terms: the sum of the squares of each element in x divided by 4000, and the product of the cosine of each element in x divided by the square root of its index.\n\nArguments\n\nx: Input vector.\n\nReturns\n\nThe Griewank function value.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.initPop-Tuple{Int64, Bool, Int64}","page":"Home","title":"GeneticAlgorithm.initPop","text":"initPop(popSize::Int, unitReal::Bool, unitLen::Int)\n\nInitialize the population of units. Each unit is a vector of Boolean or Real values.\n\nArguments\n\npopSize Size of population.\nunitReal Binary or real unit representation.\nunitLen Length of a unit vector.\n\nReturns\n\nFull vector of units with random Boolean or Real values.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.mutation-Tuple{Vector, Bool, Float64}","page":"Home","title":"GeneticAlgorithm.mutation","text":"mutation!(unit::Vector, unitReal::Bool, mutRate::Float64)\n\nMutate an unit by changing its genes depending on its type and a mutation rate.\n\nArguments\n\nunit: Unit to be mutated.\nunitReal: Type of unit, Real or Binary.\nmutRate: Mutation rate.\n\nReturns\n\nA mutated unit.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.quartic-Tuple{Any}","page":"Home","title":"GeneticAlgorithm.quartic","text":"quartic(x)\n\nCompute the quartic function value for a given input vector x.\n\nThe quartic function is defined as the sum of the product of each element in x raised to the power of 4 and its index, plus a random number.\n\nArguments\n\nx: Input vector.\n\nReturns\n\nThe quartic function value.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.rastrigin-Tuple{Any}","page":"Home","title":"GeneticAlgorithm.rastrigin","text":"rastrigin(x)\n\nCompute the Rastrigin function value for a given input vector x.\n\nThe Rastrigin function is a multimodal function used as a performance test problem for optimization algorithms. It is defined as a sum of terms involving the square of each element in x, minus 10 times the cosine of 2π times each element in x.\n\nArguments\n\nx: Input vector.\n\nReturns\n\nThe Rastrigin function value.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.rosenbrock-Tuple{Any}","page":"Home","title":"GeneticAlgorithm.rosenbrock","text":"rosenbrock(x)\n\nCompute the Rosenbrock function value for a given input vector x.\n\nThe Rosenbrock function is a non-convex function used as a performance test problem for optimization algorithms. It is defined as the sum of a series of terms involving the squares of differences between adjacent elements of x.\n\nArguments\n\nx: Input vector.\n\nReturns\n\nThe Rosenbrock function value.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.schwefel-Tuple{Any}","page":"Home","title":"GeneticAlgorithm.schwefel","text":"schwefel(x)\n\nCompute the Schwefel function value for a given input vector x.\n\nThe Schwefel function is a multimodal function used as a performance test problem for optimization algorithms. It is defined as a sum of terms involving the sine function and the square root of the absolute value of each element in x.\n\nArguments\n\nx: Input vector.\n\nReturns\n\nThe Schwefel function value.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.selection-Tuple{Vector, Vector}","page":"Home","title":"GeneticAlgorithm.selection","text":"selection(population::Vector, fitness::Vector)\n\nSelect one unit with higher fitness out of two randomly chosen unit from the population.\n\nArguments\n\npopulation: Population vector.\nfitness: Vector of fitness values.\n\nReturns\n\nThe unit with better fitness value.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.sphere-Tuple{Any}","page":"Home","title":"GeneticAlgorithm.sphere","text":"sphere(x)\n\nCompute the sphere function value for a given input vector x.\n\nThe sphere function is defined as the sum of the squares of each element in x.\n\nArguments\n\nx: Input vector.\n\nReturns\n\nThe sphere function value.\n\n\n\n\n\n","category":"method"},{"location":"#GeneticAlgorithm.tournamentSelection-Tuple{Vector, Vector, Int64}","page":"Home","title":"GeneticAlgorithm.tournamentSelection","text":"tournamentSelection(population::Vector, fitness::Vector, tournamentSize::Int)\n\nSelect one unit with higher fitness over several tournament rounds with randomly chosen groups of unit from the population .\n\nArguments\n\npopulation: Population vector.\nfitness: Vector of fitness values.\ntournamentSize: Size of tournament groups.\n\nReturns\n\nThe unit with better fitness value.\n\n\n\n\n\n","category":"method"}]
}