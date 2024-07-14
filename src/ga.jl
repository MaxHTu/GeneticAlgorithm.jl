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
    selection::Function,
    crossover::Function,
    mutation::Function,
    crossRate::Real,
    mutRate::Real
)

    population = initPop(popSize, unitShape, unitValues)

    fitness = [fitnessFunc(unit) for unit in population]

    for gen in 1:genNum
        newPop = []
        while length(newPop) < popSize
            parent1 = selection(population, fitness)
            parent2 = selection(population, fitness)
            
            if rand() < crossRate
                child1, child2 = crossover(parent1, parent2)
            else
                child1, child2 = parent1, parent2
            end

            child1 = mutation(child1, mutRate)
            child2 = mutation(child2, mutRate)
            push!(newPop, child1)
            push!(newPop, child2)
        end

        population = newPop[1:popSize]

        fitness = [fitnessFunc(unit) for unit in population]
        bestFitness = maximum(fitness)

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