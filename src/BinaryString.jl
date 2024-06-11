"""
    BinaryString

Problem: maximizing the sum of elements in a binary string.

Contains the modular GA components (population initialisation,
selection, crossover, mutation, fitness evaluation) and an
optimization loop which combines the components to solve the problem.
"""
module BinaryString

    """
        createUnit

    Creates an unit of the population, which is a binary sting of size [unitLen]-
    """
    function createUnit(unitLen::Int)
        return rand(Bool, unitLen)
    end

    """
        createPop

    Creates the population, which is a vector of [numPop] binary stings of size [unitLen].
    """
    function createPop(numPop::Int, unitLen::Int)
        return [createUnit(unitLen) for i in 1 : numPop]
    end

    """
        fitness

    Evaluate the fitness of an [unit] by calculating the sum of elements in the binary string.
    """
    function fitness(unit::Vector{Bool})
        return sum(unit)
    end

    """
        selection

    Selects one unit with higher [fitness] out of two randomly chosen units from the whole [pop]ulation.
    """
    function selection(pop::Vector{Vector{Bool}}, fitness::Vector{Int})
        id1, id2 = rand(1 : length(pop), 2)
        return (fitness[id1] > fitness[id2]) ? pop[id1] : pop[id2]
    end

    """
        mutate!

    Mutates one [unit] by changing/flipping its elements depending on a mutation rate [mutRate].
    """
    function mutate!(unit::Vector{Bool}, mutRate::Float64)
        for i in 1 : length(unit)
            if rand() < mutRate
                unit[i] = !unit[i]
            end
        end
    end

    """
        crossover

    Recombinates two units [parent1, parent2] by exchanging their elements from a random index onward.
    """
    function crossover(parent1::Vector{Bool}, parent2::Vector{Bool})
        coPoint = rand(1 : length(parent1) - 1)
        child1 = vcat(parent1[1 : coPoint], parent2[coPoint + 1 : end])
        child2 = vcat(parent2[1 : coPoint], parent1[coPoint + 1 : end])
        return child1, child2
    end

    """
        evolvePop

    Evolves the population of [numPop] units of size [unitLen] for [geneNum] generations.
    The loop creates a new population every generation by selecting two random units with
    better fitness, recombinating and mutating them until the old population can be replaced
    by a fitter one.
    """
    function evolvePop(numPop::Int, unitLen::Int, geneNum::Int, mutRate::Float64)
        pop = createPop(numPop, unitLen)
        for gen in 1 : geneNum
            fitnesses = [fitness(ind) for ind in pop]

			newPop = Vector{Vector{Bool}}()
            while length(newPop) < numPop
                parent1 = selection(pop, fitnesses)
                parent2 = selection(pop, fitnesses)
                child1, child2 = crossover(parent1, parent2)
                mutate!(child1, mutRate)
                mutate!(child2, mutRate)
                push!(newPop, child1)
                push!(newPop, child2)
			end

	        pop = newPop[1 : numPop]
	        
	        bestFit = maximum(fitnesses)
	        println("Generation $gen: Best Fitness = $bestFit")
        end

    end

    # example usage
        # Parameters
        numPop = 20
        unitLen = 50
        geneNum = 50
        mutRate = 0.01
    
	    #evolvePop(numPop, unitLen, geneNum, mutRate)
end