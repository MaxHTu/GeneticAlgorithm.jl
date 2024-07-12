"""
    binary_initial_state(unitLen::Int, popSize::Int)

Initialize the population of popSize units. Each unit is a vector of unitLen Boolean values.

# Arguments
- `popSize` Size of population.
- `unitLen` Length of a unit vector.

# Returns
- Vector of units with random Boolean values.

"""
function binary_initial_state(popSize::Int, unitShape::Vector{Int})
    # SKALAR and VECTOR shape
    if(length(unitShape)==1) return [rand(Bool, unitShape[1]) for _ in 1:popSize] end
    # MATRIX shape
    return [[rand(Bool, unitShape[1]) for _ in 1:unitShape[2]] for _ in 1:popSize]
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
function float_initial_state(popSize::Int, unitShape::Vector{Int}, values::Vector{Union{Int, Float64}})
    # make sure value is always between range
    # SKALAR and VECTOR shape
    if(length(unitShape)==1) return [clamp.(offset + rand(values,unitShape[1]), range[1], range[end]) for _ in 1:popSize] end
    # MATRIX shape
    return [[clamp.(rand(range,length(offset)), range[1], range[end]) for _ in 1:unitShape[2]] for _ in 1:popSize]
end

"""
    'popSize' Determines how many genomes in one population, e.g. 10
    'unitShape' Determines the dimension of the genome, e.g. [1] = Skalar, [3] = xyz-Vektor, [3,3] = 3x3 Matrix
    'values' Determines the Range of possible genome states, e.g. [0,1]
    'offset' Variable to set an arbitrary offset for the rand genome state generation
"""

function initPop(popSize::Int, unitShape::Vector{Int}, values::Union{Vector{Bool},Vector{Int},Vector{Float64},Vector{UnitRange{Int64}}})
    #function router for different range types
    #Wir supporten Int, Float, Binary // alles andere kann man versuchen zu casten oder wird gemappt auf irgendwas
    #Bedingung: Alle Zahlen in der Range müssen denselben type habe
    if(length(values) <= 0)
        return error("The values vector shouldn't be empty. Atm, the 'values' parameter accepts vectors of type: Bool, Int, Float64.") end
    if(values isa Vector{UnitRange{Int64}})
        print("This is a Range and still needs to get implemented.")
    end
    # SKALAR and VECTOR shape
    if(length(unitShape)==1) return [rand(values,unitShape[1]) for _ in 1:popSize] end
    # MATRIX shape
    return [[rand(values,unitShape[1]) for _ in 1:unitShape[2]] for _ in 1:popSize]
end

print(initPop(3,[3],[1,2,3]))