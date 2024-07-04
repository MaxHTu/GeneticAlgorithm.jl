#ToDO
abstract type AbstractOptimizer end

"""
fitness::function
crossover::function
select_pair::function
mutation::function


struct GeneticAlgorithm <: AbstractOptimizer
    data::Array
    population_size::Int
    gen_range::Array
    mode::String
    k
    crossover_mode::String
    epochs::Int64
    max_mutation_amount::Int
    mutation_prob::String
end

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
"""

mutable struct GA <: AbstractOptimizer
    population_size::Int
    next_generation_amt::Int
    epochs::Int
    mutation_rate::Float64
    crossover_rate::Float64
    population

    GA(
        population_size::Int,
        next_generation_amt::Int,
        epochs::Int,
        mutation_rate::Float64,
        crossover_rate::Float64,
        population
    ) = new(
        population_size,
        next_generation_amt,
        epochs,
        mutation_rate,
        crossover_rate,
        population
    )
end

function generate_binary_genome(size::Int)
    return rand(Bool,size)
end


function binary_initial_state(gene_size::Int, population_size::Int)
    return [generate_binary_genome(gene_size) for i in range(1, population_size)]
end

function float_initial_state(population_size::Int)
    pop = Vector{Vector{Float64}}(undef, population_size)
     for i in range(1,population_size)
        pop[i] = Float64[0.,0.] + rand(-100:100,2)
    end
    return pop
end


function update_state!(
    ga,
    fitness::Function,
    next_generation_amt::Number,
    crossover::Function,
    mutation::Function
)
    population = sort(ga.population, by=fitness, rev=true)

    println(population[1])

    next_generation_amt = next_generation_amt<1 ? next_generation_amt*length(population) : next_generation_amt

    next_generation = population[1:next_generation_amt]

    for j in range(1, trunc(Int, length(population)/2)-1)
        #select pair to crossover and mutate
        parents = default_select_pair(population, fitness)
        #call crossover function
        a, b = crossover(parents[1], parents[2])
        #mutation step
        a = mutation(a,0.2)
        b = mutation(b,0.2)
        push!(next_generation, a)
        push!(next_generation, b)
    end

    ga.population = next_generation
end
