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
    - `unitLen`: Length of a unit vector.
    - `fitnessFunc`: Fitness function.
    - `genNum`: Number of generations.
    - `crossRate`: Crossover rate.
    - `mutRate`: Mutation rate.

    """
    function genAlgo(
        popSize::Integer,
        unitType::Type,
        unitLen::Integer,
        fitnessFunc::Function,
        genNum::Integer,
        crossRate::Real,
        mutRate::Real
    )
        if unitType == Bool
            population = initBinPop(popSize, unitLen)
            #newPop = Vector{AbstractVector{Bool}}(undef, popSize)
        elseif unitType <: AbstractFloat
            population = initFloatPop(popSize, unitLen)
            #newPop = Vector{AbstractVector{Float64}}(undef, popSize)
        end

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
        binary_initial_state,
        float_initial_state,
        # Evaluation
        sphere,
        rosenbrock,
        quartic,
        schwefel,
        rastrigin,
        griewank,
        binarystring,
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
