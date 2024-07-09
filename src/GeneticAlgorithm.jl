module GeneticAlgorithm

    include("initiation.jl")
    include("evaluation.jl")
    include("selection.jl")
    include("crossover.jl")
    include("mutation.jl")
    include("ga.jl")

    """
        genAlgo(
            popSize::Int,
            unitReal::Bool,
            unitLen::Int,
            fitnessFunc::Function,
            genNum::Int,
            crossRate::Float64,
            mutRate::Float64
        )

    Evolve the population of units for a specified number of generations.
    The loop creates a new population every generation by selecting two units with
    higher fitness, recombinating and mutating them until the old population can be replaced
    by a fitter one.

    # Arguments
    - `popSize`: Size of population.
    - `unitReal`: Binary or real unit representation.
    - `unitLen`: Length of a unit vector.
    - `fitnessFunc`: Fitness function.
    - `genNum`: Number of generations.
    - `crossRate`: Crossover rate.
    - `mutRate`: Mutation rate.

    """
    function genAlgo(
        popSize::Int,
        unitReal::Bool,
        unitLen::Int,
        fitnessFunc::Function,
        genNum::Int,
        crossRate::Float64,
        mutRate::Float64
    )
        population = initPop(popSize, unitReal, unitLen)
        fitness = [fitnessFunc(unit) for unit in population]

        bestUnit = population[argmax(fitness)]
        bestFitness = maximum(fitness)

        state = GAState(popSize, population, fitness, 0, bestUnit, bestFitness, crossRate, mutRate);

        for gen in 1:genNum
            newPop = []
            while length(newPop) < popSize
                parent1 = selection(population, fitness)
                parent2 = selection(population, fitness)
                
                if rand() < state.crossRate
                    child1, child2 = crossover(parent1, parent2)
                else
                    child1, child2 = parent1, parent2
                end

                child1 = mutation(child1, unitReal, mutRate)
                child2 = mutation(child2, unitReal, mutRate)
                push!(newPop, child1)
                push!(newPop, child2)
            end

            population = newPop[1:popSize]

            fitness = [fitnessFunc(unit) for unit in population]
            bestUnit = population[argmax(fitness)]
            bestFitness = maximum(fitness)

            state = GAState(popSize, population, fitness, gen, bestUnit, bestFitness, crossRate, mutRate);

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
        selection,
        tournamentSelection

end
