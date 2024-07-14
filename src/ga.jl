#TODO: Decide which parameters to keep.
struct GAState
    popSize::Integer
    unitType::Type
    population::AbstractVector
    fitness::AbstractVector
    generation::Integer
    crossRate::Real
    mutRate::Real
    selection::Function
    crossover::Function
    mutation::Function

    GAState(;
        popSize::Integer = 50,
        unitType::Type = Real,
        population::AbstractVector,
        fitness::AbstractVector,
        generation::Integer = 50,
        crossRate::Real = 0.25,
        mutRate::Real = 0.1,
        selection::Function = selection,
        crossover::Function = crossover,
        mutation::Function = mutation!
    ) = new(
        popSize,
        unitType,
        population,
        fitness,
        generation,
        crossRate,
        mutRate,
        selection,
        crossover,
        mutation
    )
end
