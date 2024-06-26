module GeneticAlgorithm

    include("initiation.jl")
    include("evaluation.jl")
    include("selection.jl")
    include("crossover.jl")
    include("mutation.jl")

    """
        evolvePop

    Evolves the population of [numPop] individuals of size [unitLen] for [geneNum] generations.
    The loop creates a new population every generation by selecting two random individuals with
    better fitness, recombinating and mutating them until the old population can be replaced
    by a fitter one.
    """
    function evolvePop(numPop::Int, unitLen::Int, geneNum::Int, mutRate::Float64)
        pop = createPop(numPop, unitLen)
        for gen in 1:geneNum
            fitnesses = [bs_fit(ind) for ind in pop]

            newPop = Vector{Individual}()
            while length(newPop) < numPop
                parent1 = selection(pop, fitnesses)
                parent2 = selection(pop, fitnesses)
                child1, child2 = crossover(parent1, parent2)
                mutation!(child1, mutRate)
                mutation!(child2, mutRate)
                push!(newPop, child1)
                push!(newPop, child2)
            end

            pop = newPop[1:numPop]

            bestFit = maximum(fitnesses)
            println("Generation $gen: Best Fitness = $bestFit")
        end

    end

    export evolvePop

end
