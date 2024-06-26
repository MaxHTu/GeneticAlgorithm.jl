"""
createUnit

Creates an individual unit of the population.
This function should be problem-specific and should be provided by the user.
"""
function createUnit(unitLen::Int)::Individual
    return BinaryIndividual(rand(Bool, unitLen))
end

"""
createPop

Creates the population, which is a vector of [numPop] individuals.
"""
function createPop(numPop::Int, unitLen::Int)::Vector{Individual}
    return [createUnit(unitLen) for i in 1:numPop]
end

export BinaryIndividual, createUnit, createPop