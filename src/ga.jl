"""
geneticAlgorithm(
    popSize::Integer,
    unitValues::Type,
    unitShape::Integer,
    fitnessFunc::Function,
    genNum::Integer,
    selection::Function,
    crossover::Function,
    mutation::Function,
    crossRate::Real,
    mutRate::Real
)

Evolve the population of units for a specified number of generations.
The loop creates a new population every generation by selecting units with
higher fitness, recombinating and mutating them until the old population can
be replaced by a fitter one.

# Arguments
- `fitnessFunc`: Fitness function.
- `popSize`: Size of population.
- `unitValues`: Type of unit.
- `unitShape`: Length of a unit vector.
- `genNum`: Number of generations.
- `selection`: Selection function.
- `crossover`: Crossover function.
- `mutation`: Mutation function.
- `crossRate`: Crossover rate.
- `mutRate`: Mutation rate.

"""
function geneticAlgorithm(
    fitnessFunc::Function,
    popSize::Integer,
    unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}},
    unitShape::AbstractVector{<:Integer},
    genNum::Integer,
    selectionFunc::Function,
    crossoverFunc::Function,
    mutationFunc::Function,
    crossRate::Real,
    mutRate::Real,
    nextGenAmt::Real;
    initFunc::Function = initPop
)
    if initFunc == initPop
        population = initFunc(popSize, unitShape, unitValues)
    else
        population = initFunc(popSize)
    end

    # define how many genes go straight to the new population
    nextGenAmt = nextGenAmt<1 ? nextGenAmt*length(population) : nextGenAmt

    # sort population by fitness and calculate fitness
    population = sort(population, by=fitnessFunc, rev=true)
    fitness = [fitnessFunc(unit) for unit in population]

    nextGen = typeof(population)(undef, popSize)

    for gen in 1:genNum
        i = 1
        while i <= popSize
            if i <= nextGenAmt
                nextGen[i] = copy(population[i])
                i += 1
            else
                #select pair to crossover and mutate
                parent1,parent2 = selectionFunc(population, fitness, 2)
                #call crossover function
                if rand() < crossRate
                    child1, child2 = crossoverFunc(parent1, parent2)
                else
                    child1, child2 = parent1, parent2
                end
                #mutation step
                #child1 = mutationFunc(child1)
                #child2 = mutationFunc(child2)
                child1 = mutationFunc(child1, mutRate, unitValues)
                child2 = mutationFunc(child2, mutRate, unitValues)
                nextGen[i] = child1
                i += 1
                if i <= popSize
                    nextGen[i] = child2
                    i += 1
                end
            end
        end

        nextGen = sort(nextGen, by=fitnessFunc, rev=true)

        population = nextGen

        fitness = [fitnessFunc(unit) for unit in population]
        bestFitness = fitness[1]

        println("Generation $gen: Best Fitness = $bestFitness")
    end
    return population 
end

function solveRosenbrock(
    ;
    a::Integer=1,
    b::Integer=100,
    popSize::Integer = 500,
    fitnessFunc::Function = rosenbrock,
    unitValues::Union{Type,AbstractVector{Float64},AbstractRange{<:Real}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 10,
    crossRate::Real = 0.25,
    mutRate::Real = 0.5,
    nextGenAmt::Number = 4,
    selectionFunc::Function = GeneticAlgorithm.weighted_selection,
    crossoverFunc::Function = GeneticAlgorithm.single_point_crossover,
    mutationFunc::Function = GeneticAlgorithm.mutation!
)

    return geneticAlgorithm(x -> GeneticAlgorithm.rosenbrock(x,a=a,b=b),popSize,unitValues,unitShape,genNum,selectionFunc,crossoverFunc,mutationFunc,crossRate,mutRate,nextGenAmt)

end


"""
genAlgo(
    popSize::Integer,
    unitValues::Type,
    unitShape::Integer,
    fitnessFunc::Function,
    genNum::Integer,
    selection::Function,
    crossover::Function,
    mutation::Function,
    crossRate::Real,
    mutRate::Real
)

TODO: description

# Arguments
- `fitnessFunc`: Fitness function.
- `popSize`: Size of population.
- `unitValues`: Type of unit.
- `unitShape`: Length of a unit vector.
- `genNum`: Number of generations.
- `selection`: Selection function.
- `crossover`: Crossover function.
- `mutation`: Mutation function.
- `crossRate`: Crossover rate.
- `mutRate`: Mutation rate.

"""
function genAlgo(
    fitnessFunc::Function,
    popSize::Integer,
    unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}},
    unitShape::AbstractVector{<:Integer},
    genNum::Integer,
    selection::Function,
    crossover::Function,
    mutation::Function,
    crossRate::Real,
    mutRate::Real,
    nextGenAmt::Real
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt)
end

function genAlgo(
    fitnessFunc::Function;
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = weighted_selection,
    crossover::Function = single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt)
end

function genAlgo(
    fitnessFunc::typeof(sphere);
    popSize::Integer = 50,
    unitValues::Union{Type,AbstractVector{<:Real},AbstractRange{<:Real}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = (a,b,c) -> default_selection(a,c),
    crossover::Function = single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt)
end

function genAlgo(
    fitnessFunc::typeof(quartic);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = default_selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.25,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt)
end

function genAlgo(
    fitnessFunc::typeof(schwefel);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::Vector{Int} = [2],
    genNum::Integer = 50,
    selection::Function = default_selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt)
end

function genAlgo(
    fitnessFunc::typeof(rastrigin);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = default_selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt)
end

function genAlgo(
    fitnessFunc::typeof(griewank);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Integer}} = Integer,
    unitShape::AbstractVector{<:Integer} = [4],
    genNum::Integer = 50,
    selection::Function = default_selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt)
end

function genAlgo(
    fitnessFunc::typeof(binarystring);
    popSize::Integer = 50,
    unitValues::Type = Bool,
    unitShape::AbstractVector{<:Integer} = [50],
    genNum::Integer = 50,
    selection::Function = default_selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt)
end
