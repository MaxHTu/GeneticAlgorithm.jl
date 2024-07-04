"""
    initPop(popSize::Int, unitReal::Bool, unitLen::Int)

Initialize the population of units. Each unit is a vector of Boolean or Real values.

# Arguments
- `popSize` Size of population.
- `unitReal` Binary or real unit representation.
- `unitLen` Length of a unit vector.

# Returns
- Full vector of units with random Boolean or Real values.

"""
function initPop(popSize::Int, unitReal::Bool, unitLen::Int)
    return [rand(unitReal ? Float64 : Bool, unitLen) for _ in 1:popSize]
end

export initPop