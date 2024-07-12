"""
    initBinPop(popSize::Integer, unitLen::Integer)

Initialize the population of units. Each unit is a vector of Boolean values.

# Arguments
- `popSize` Size of population.
- `unitLen` Length of a unit vector.

# Returns
- Full vector of units with random Boolean values.

"""
function initBinPop(popSize::Integer, unitLen::Integer)
    population = Vector{AbstractVector{Bool}}(undef, popSize)

    for i in eachindex(population)
        population[i] = rand(Bool, unitLen)
    end

    return population
end

"""
    initFloatPop(popSize::Integer, unitLen::Integer)

Initialize the population of units. Each unit is a vector of Float values.

# Arguments
- `popSize` Size of population.
- `unitLen` Length of a unit vector.

# Returns
- Full vector of units with random Float values.

"""
function initFloatPop(popSize::Integer, unitLen::Integer)
    population = Vector{AbstractVector{Float64}}(undef, popSize)

    for i in eachindex(population)
        population[i] = rand(Float64, unitLen)
    end

    return population
end