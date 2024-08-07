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
    mutRate::Real,
    nextGenAmt::Real,
    terminationNum::Real;
    initFunc::Function
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
- `nextGenAmt`: amount of genes that are automatically copied to new generation
- `terminationNum`: number of iteration after which the algorithm aborts if there is no change in fitness value from the best gene
- `initFunc`: function to generate initial population

"""
function geneticAlgorithm(
    fitnessFunc::Function,
    popSize::Integer,
    unitValues::Union{Type, AbstractVector{Bool} ,AbstractVector{<:Real}, AbstractRange{<:Real}},
    unitShape::AbstractVector{<:Integer},
    genNum::Integer,
    selectionFunc::Function,
    crossoverFunc::Function,
    mutationFunc::Function,
    crossRate::Real,
    mutRate::Real,
    nextGenAmt::Real,
    terminationNum::Real;
    initFunc::Function = initPop
)
    if initFunc == initPop
        population = initFunc(popSize, unitShape, unitValues)
    else
        population = initFunc(popSize)
    end

    # define how many genes go straight to the new population
    nextGenAmt = nextGenAmt < 1 ? nextGenAmt * length(population) : nextGenAmt

    # sort population by fitness and calculate fitness
    population = sort(population, by=fitnessFunc, rev=true)
    fitness = [fitnessFunc(unit) for unit in population]

    nextGen = typeof(population)(undef, popSize)

    terminator = 0
    bestFitness = 0

    for gen in 1:genNum
        i = 1
        if terminator > terminationNum
            break
        end
        while i <= popSize
            if i <= nextGenAmt
                nextGen[i] = copy(population[i])
                i += 1
            else
                #select pair to crossover and mutate
                parent1,parent2 = selectionFunc(population, fitness, 2)
                #call crossover function
                if rand() < crossRate
                    child1, child2 = crossoverFunc(copy(parent1), copy(parent2))
                else
                    child1, child2 = copy(parent1), copy(parent2)
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
                end
            end
        end

        nextGen = sort(nextGen, by=fitnessFunc, rev=true)

        population = nextGen

        fitness = [fitnessFunc(unit) for unit in population]

        # check if fitness improves overtime, otherwise terminate
        terminator = fitness[1] == bestFitness ? terminator + 1 : 0

        bestFitness = fitness[1]

        println("Generation $gen: Best Fitness = $bestFitness")
    end

    return population 
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
    unitValues::Union{Type, AbstractVector{Bool}, AbstractVector{<:Real}, AbstractRange{<:Real}},
    unitShape::AbstractVector{<:Integer},
    genNum::Integer,
    selection::Function,
    crossover::Function,
    mutation::Function,
    crossRate::Real,
    mutRate::Real,
    nextGenAmt::Real,
    terminationNum::Real
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt, terminationNum)
end

function genAlgo(
    fitnessFunc::Function;
    popSize::Integer = 50,
    unitValues::Union{Type, AbstractVector{Bool}, AbstractVector{<:Real}, AbstractRange{<:Real}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = weighted_selection,
    crossover::Function = single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2,
    terminationNum::Real = 100
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt, terminationNum)
end

function genAlgo(
    fitnessFunc::typeof(sphere);
    popSize::Integer = 50,
    unitValues::Union{Type, AbstractVector{<:Real}, AbstractRange{<:Real}} = -5.12:5.12,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = (a,b,c) -> default_selection(a,c),
    crossover::Function = single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2,
    terminationNum::Real = 100
)
    function s(x)
        v = abs(fitnessFunc(x))
        if v >= 1000
            return 0.0001
        end
        return 1000 - v
    end
    return geneticAlgorithm(s, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt, terminationNum)
end

function genAlgo(
    fitnessFunc::typeof(quartic);
    popSize::Integer = 50,
    unitValues::Union{Type, AbstractVector{<:AbstractFloat}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = (a,b,c) -> weighted_selection(a,b,c),
    crossover::Function = GeneticAlgorithm.single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.25,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 4,
    terminationNum::Real = 100
)
    function q(x)
        v = abs(fitnessFunc(x))
        if v >= 1000
            return 0.0001
        end
        return 1000 - v
    end
    return geneticAlgorithm(q, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt, terminationNum)
end

function genAlgo(
    fitnessFunc::typeof(schwefel);
    popSize::Integer = 50,
    unitValues::Union{Type, AbstractVector{<:AbstractFloat}} = -500.0:500.0,
    unitShape::AbstractVector{<:Integer} = [3],
    genNum::Integer = 100,
    selection::Function = (a,b,c) -> weighted_selection(a,b,c),
    crossover::Function = GeneticAlgorithm.single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.5,
    nextGenAmt::Real = 2,
    terminationNum::Real = 100
)

    function s(x)
        v = abs(fitnessFunc(x))
        if v >= 1000
            return 0.0001
        end
        return 1000 - v
    end
    return geneticAlgorithm(s, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt, terminationNum)
end

function genAlgo(
    fitnessFunc::typeof(rastrigin);
    popSize::Integer = 50,
    unitValues::Union{Type, AbstractVector{<:AbstractFloat}} = -5.12:5.12,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 100,
    selection::Function = (a,b,c) -> weighted_selection(a,b,c),
    crossover::Function = GeneticAlgorithm.single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.75,
    mutRate::Real = 0.1,
    nextGenAmt::Real = 2,
    terminationNum::Real = 100
)
    function r(x)
        v = abs(fitnessFunc(x))
        if v >= 1000
            return 0.0001
        end
        return 1000 - v
    end
    return geneticAlgorithm(r, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt, terminationNum)
end

function genAlgo(
    fitnessFunc::typeof(griewank);
    popSize::Integer = 50,
    unitValues::Union{Type, AbstractVector{Integer}, AbstractRange{<:Real}} = -600.0:600.0,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 100,
    selection::Function = (a,b,c) -> weighted_selection(a,b,c),
    crossover::Function = GeneticAlgorithm.single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.25,
    nextGenAmt::Real = 2,
    terminationNum::Real = 100
)

    function g(x)
        v = abs(fitnessFunc(x))
        if v >= 1000
            return 0.0001
        end
        return 1000 - v
    end
    return geneticAlgorithm(g, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt, terminationNum)
end

function genAlgo(
    fitnessFunc::typeof(binarystring);
    popSize::Integer = 50,
    unitValues::Type = Bool,
    unitShape::AbstractVector{<:Integer} = [50],
    genNum::Integer = 50,
    selection::Function = (a,b,c) -> default_selection(a,c),
    crossover::Function = GeneticAlgorithm.single_point_crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01,
    nextGenAmt::Real = 2,
    terminationNum::Real = 100
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate, nextGenAmt, terminationNum)
end

"""
solveRosenbrock(;
    a::Integer,
    b::Integer,
    popSize::Integer,
    fitnessFunc::Function,
    unitValues::Union{Type, AbstractVector{<:AbstractFloat}, AbstractRange{<:Real}},
    unitShape::AbstractVector{<:Integer},
    genNum::Integer,
    crossRate::Real,
    mutRate::Real,
    nextGenAmt::Number,
    selectionFunc::Function,
    crossoverFunc::Function,
    mutationFunc::Function ,
    terminationNum::Real
)

Runs the rosenbrock function with the geneticAlgorithm

# Arguments
- `a`: rosenbrock function variable
- `b`: rosenbrock function variable
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
function solveRosenbrock(;
    a::Integer = 1,
    b::Integer = 100,
    popSize::Integer = 500,
    fitnessFunc::Function = rosenbrock,
    unitValues::Union{Type, AbstractVector{<:AbstractFloat}, AbstractRange{<:Real}} = -1000.0:1000.0,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 100,
    crossRate::Real = 0.25,
    mutRate::Real = 0.25,
    nextGenAmt::Number = 4,
    selectionFunc::Function = GeneticAlgorithm.weighted_selection,
    crossoverFunc::Function = GeneticAlgorithm.single_point_crossover,
    mutationFunc::Function = GeneticAlgorithm.mutation!,
    terminationNum::Real = 100
)
    function r(x)
        v = GeneticAlgorithm.rosenbrock(x,a=a,b=b)
        if v >= 1000
            return 0.0001
        end
        return 1000 - v
    end
    return geneticAlgorithm(r, popSize, unitValues, unitShape, genNum, selectionFunc, crossoverFunc, mutationFunc, crossRate, mutRate, nextGenAmt, terminationNum)

end
