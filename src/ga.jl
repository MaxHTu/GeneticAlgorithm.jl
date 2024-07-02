#TODO: Decide which parameters to keep.
mutable struct GAState{V1, V2, V3}
    popSize::Int
    population::V1
    fitness::V2
    generation::Int
    bestUnit::V3
    bestFitness::Real
    crossRate::Float64
    mutRate::Float64
    # selection::Function
    # crossover::Function
    # mutation::Function

    # GAState(
    #     popSize::Int,
    #     population::V1,
    #     fitness::V2,
    #     generation::Int,
    #     bestUnit::V3,
    #     bestFitness::Real,
    #     crossRate::Float64,
    #     mutRate::Float64,
    #     selection::Function = selection,
    #     crossover::Function = crossover,
    #     mutation::Function = mutation!
    # ) where{V1<:AbstractVector{<:AbstractVector}, V2<:AbstractVector, V3<:AbstractVector} = 
    #     new{V1<:AbstractVector{<:AbstractVector}, V2<:AbstractVector, V3<:AbstractVector}(
    #     popSize,
    #     population,
    #     fitness,
    #     generation,
    #     bestUnit,
    #     bestFitness,
    #     crossRate,
    #     mutRate,
    #     selection,
    #     crossover,
    #     mutation
    # )
end

export GAState