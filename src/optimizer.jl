function optimize(
    ga,
    fitness::Function,
    epochs::Int,
    next_generation_amt::Int,
    crossover::Function,
    mutation::Function
)
    for i in range(1,epochs)
        println(i)
        GeneticAlgorithm.update_state!(
            ga,
            fitness,
            next_generation_amt,
            crossover,
            mutation
        )
    end

    println(ga.population)
    return ga
end