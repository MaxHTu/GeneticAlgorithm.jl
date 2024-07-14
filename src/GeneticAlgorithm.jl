module GeneticAlgorithm

    include("initiation.jl")
    include("evaluation.jl")
    include("selection.jl")
    include("crossover.jl")
    include("mutation.jl")
    include("ga.jl")

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
    - `unitShape`: Dimension of a genome, e.g. [1] = Scalar, [3] = xyz-Vector, [3,3] = 3x3 Matrix
    - `values`: Range of possible genome states, e.g. [0,1], [1,2,3,4,5], [1.0,1.3,10.9], ...
    - `fitnessFunc`: Fitness function.
    - `genNum`: Number of generations.
    - `crossRate`: Crossover rate.
    - `mutRate`: Mutation rate.

    """
    function genAlgo(
        popSize::Integer,
        unitType::Type,
        unitShape::Vector{Int},
        values::Union{Vector{Bool},Vector{Int},Vector{Float64}},
        fitnessFunc::Function,
        genNum::Integer,
        crossRate::Real,
        mutRate::Real
    )
        population = initPop(popSize, unitShape, values)

        fitness = [fitnessFunc(unit) for unit in population]

        state = GAState(popSize = popSize, unitType = unitType, population = population, fitness = fitness, generation = 0, crossRate = crossRate, mutRate = mutRate);

        for gen in 1:genNum
            #TODO change newPop to improve memalloc
            newPop = []
            while length(newPop) < popSize
                parent1 = selection(population, fitness)
                parent2 = selection(population, fitness)
                
                if rand() < state.crossRate
                    child1, child2 = crossover(parent1, parent2)
                else
                    child1, child2 = parent1, parent2
                end

                child1 = mutation!(child1, mutRate)
                child2 = mutation!(child2, mutRate)
                push!(newPop, child1)
                push!(newPop, child2)
            end

            population = newPop[1:popSize]

            fitness = [fitnessFunc(unit) for unit in population]
            bestFitness = maximum(fitness)

            state = GAState(population = population, fitness = fitness, generation = gen);

            println("Generation $gen: Best Fitness = $bestFitness")
        end

        return state
    end

    export 
        genAlgo,
        # Population Initiation
        initPop,
        # Evaluation
        sphere,
        rosenbrock,
        quartic,
        schwefel,
        rastrigin,
        griewank,
        binarystring,
        knapsack,
        # Selection
        default_select_pair,
        weighted_select_pair,
        fitness_selection,
        tournament_selection,
        # Crossover
        single_point_crossover,
        k_point_crossover,
        uniform_crossover,
        # Mutation
        mutation!

end
