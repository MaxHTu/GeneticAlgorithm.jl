# TODO: Umbenennen dass die gleich heißen und die typen für den funktionsaufruf entscheidend sind
"""
    binary_initial_state(unitLen::Int, popSize::Int)

Initialize the population of popSize units. Each unit is a vector of unitLen Boolean values.

# Arguments
- `popSize` Size of population.
- `unitLen` Length of a unit vector.

# Returns
- Vector of units with random Boolean values.

"""
# TODO: Size
function binary_initial_state(unitLen::Int, popSize::Int)
    return [rand(Bool, unitLen) for _ in 1:popSize]
end

"""
    float_initial_state(popSize::Int, initValue::Vector{Float64}, range::UnitRange{Float64})

Initialize the population of popSize units. Each unit is a vector of the same format as initValue with random Values in range range with Real values added to the initValue.

# Arguments
- `popSize` Size of population.
- `initValue` initialValue of Float64 Values. Random values are added to the initialValue 
- `range` the range where the final values are lying between

# Returns
- Vector of units with random Float64 values in certain range.

"""
# TODO: initValue oder genome size, mehrdimensional, range als vector von zwei werten + unit range für int oder float range für float
function float_initial_state(popSize::Int, initValue::Vector{Float64}, range::UnitRange{Float64})
    # make sure value is always between range
    return [clamp.(initValue + rand(range,length(initValue)), range[1], range[end]) for _ in 1:popSize]
end