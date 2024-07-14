#TODO: Decide which parameters to keep.
using GeneticAlgorithm

function transformRange(values::Vector, oldMax, oldMin, newMax, newMin)
    return (((values .- oldMin) .* (newMax - newMin)) ./ (oldMax - oldMin)) .+ newMin
end

"""
    genAlgo(
        popSize::Integer,
        unitType::Type,
        unitLen::Integer,
        fitnessFunc::Function,
        genNum::Integer,
        crossRate::Real,
        mutRate::Real
    )

Evolve the population of units for a specified number of generations.
The loop creates a new population every generation by selecting two units with
higher fitness, recombinating and mutating them until the old population can be replaced
by a fitter one.

# Arguments
- `popSize`: Size of population.
- `unitType`: Type of unit.
- `unitLen`: Length of a unit vector.
- `fitnessFunc`: Fitness function.
- `genNum`: Number of generations.
- `crossRate`: Crossover rate.
- `mutRate`: Mutation rate.

"""
function geneticAlgorithm(
    popSize::Integer,
    unitType::Type,
    unitLen::Integer,
    fitnessFunc::Function,
    genNum::Integer,
    crossRate::Real,
    mutRate::Real,
    nextGenAmt::Number,
    selectionFunc::Function,
    crossoverFunc::Function,
    mutationFunc::Function
)
    # Und dann hier IF
    if unitType == Bool
        population = binary_initial_state(unitLen, popSize)
        newPop = Vector{AbstractVector{Bool}}(undef, popSize)
    elseif unitType <: AbstractFloat
        population = float_initial_state(popSize, zeros(unitLen), UnitRange{Float64}(-100.0,100.0))
        newPop = Vector{AbstractVector{Float64}}(undef, popSize)
    end

    nextGenAmt = nextGenAmt<1 ? nextGenAmt*length(population) : nextGenAmt

    fitness = [fitnessFunc(unit) for unit in population]

    population = sort(population, by=fitnessFunc)

    for gen in 1:genNum
        nextGen = population[1:nextGenAmt]

        for j in range(1, trunc(Int, popSize/2)-nextGenAmt/2)
            #select pair to crossover and mutate
            parent1,parent2 = selectionFunc(population, fitness, 2)
            #call crossover function
            if rand() < crossRate
                child1, child2 = crossoverFunc(parent1, parent2)
            else
                child1, child2 = parent1, parent2
            end
            #mutation step
            child1 = mutationFunc(child1, mutRate, UnitRange{Float64}(-100.0,100.0))
            child2 = mutationFunc(child2, mutRate, UnitRange{Float64}(-100.0,100.0))
            push!(nextGen, child1)
            push!(nextGen, child2)
        end

        population = nextGen
        population = sort(population, by=fitnessFunc)

        fitness = [fitnessFunc(unit) for unit in population]
        bestFitness = fitness[1]

        println("Generation $gen: Best Fitness = $bestFitness")
    end

    return sort(population, by=fitnessFunc) 
end

function solveRosenbrock(
	;
	a::Integer=1,
	b::Integer=100,
	popSize::Integer = 500,
	fitnessFunc::Function = rosenbrock,
    unitType::Type = Float64,
    unitLen::Integer = 2,
    genNum::Integer = 10,
    crossRate::Real = 0.25,
    mutRate::Real = 0.5,
    nextGenAmt::Number = 4,
    selectionFunc::Function = GeneticAlgorithm.weighted_selection,
    crossoverFunc::Function = GeneticAlgorithm.single_point_crossover,
    mutationFunc::Function = GeneticAlgorithm.mutation!)

	return geneticAlgorithm(popSize,unitType,unitLen,x -> GeneticAlgorithm.rosenbrock(x,a=a,b=b),genNum,crossRate,mutRate,nextGenAmt,selectionFunc,crossoverFunc,mutationFunc)
end

function genAlgo(;
    popSize::Integer = 500,
    unitType::Type = Float64,
    unitLen::Integer = 2,
    fitnessFunc,
    genNum::Integer = 10,
    crossRate::Real = 0.25,
    mutRate::Real = 0.5,
    nextGenAmt::Number = 4,
    selectionFunc::Function = GeneticAlgorithm.weighted_selection,
    crossoverFunc::Function = GeneticAlgorithm.single_point_crossover,
    mutationFunc::Function = GeneticAlgorithm.mutation!
)
    return geneticAlgorithm(popSize,unitType,unitLen,fitnessFunc,genNum,crossRate,mutRate,nextGenAmt,selectionFunc,crossoverFunc,mutationFunc)
end