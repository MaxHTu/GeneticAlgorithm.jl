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
    popSize::Integer,
    unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}},
    unitShape::AbstractVector{<:Integer},
    fitnessFunc::Function,
    genNum::Integer,
    crossRate::Real,
    mutRate::Real,
    nextGenAmt::Number,
    selectionFunc::Function,
    crossoverFunc::Function,
    mutationFunc::Function
)
    population = initPop(popSize, unitShape, unitValues)

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

function genAlgo(
    fitnessFunc::typeof(rosenbrock);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function solveRosenbrock(
        ;
        a::Integer=1,
        b::Integer=100,
        popSize::Integer = 500,
        fitnessFunc::Function = rosenbrock,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 10,
    crossRate::Real = 0.25,
    mutRate::Real = 0.5,
    nextGenAmt::Number = 4,
    selectionFunc::Function = GeneticAlgorithm.weighted_selection,
    crossoverFunc::Function = GeneticAlgorithm.single_point_crossover,
    mutationFunc::Function = GeneticAlgorithm.mutation!)

        return geneticAlgorithm(popSize,unitType,unitLen,x -> GeneticAlgorithm.rosenbrock(x,a=a,b=b),genNum,crossRate,mutRate,nextGenAmt,selectionFunc,crossoverFunc,mutationFunc)
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
    unitValues::Union{Type,Vector{Bool},Vector{Int},Vector{Float64}},
    unitShape::AbstractVector{<:Integer},
    genNum::Integer,
    selection::Function,
    crossover::Function,
    mutation::Function,
    crossRate::Real,
    mutRate::Real
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function genAlgo(
    fitnessFunc::typeof(sphere);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function genAlgo(
    fitnessFunc::typeof(quartic);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.25,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function genAlgo(
    fitnessFunc::typeof(schwefel);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::Vector{Int} = [2],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function genAlgo(
    fitnessFunc::typeof(rastrigin);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function genAlgo(
    fitnessFunc::typeof(griewank);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Integer}} = Integer,
    unitShape::AbstractVector{<:Integer} = [4],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function genAlgo(
    fitnessFunc::typeof(binarystring);
    popSize::Integer = 50,
    unitValues::Type = Bool,
    unitShape::AbstractVector{<:Integer} = [50],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function genAlgo(
    fitnessFunc::typeof(rosenbrock);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end

function genAlgo(
    fitnessFunc::typeof(rosenbrock);
    popSize::Integer = 50,
    unitValues::Union{Type,Vector{Float64}} = Float64,
    unitShape::AbstractVector{<:Integer} = [2],
    genNum::Integer = 50,
    selection::Function = selection,
    crossover::Function = crossover,
    mutation::Function = mutation!,
    crossRate::Real = 0.2,
    mutRate::Real = 0.01
)
    return geneticAlgorithm(fitnessFunc, popSize, unitValues, unitShape, genNum, selection, crossover, mutation, crossRate, mutRate)
end
