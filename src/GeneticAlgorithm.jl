module GeneticAlgorithm

    include("initiation.jl")
    include("evaluation.jl")
    include("selection.jl")
    include("crossover.jl")
    include("mutation.jl")
    include("ga.jl")

    export 
        genAlgo,
        solveRosenbrock,
        # Population Initiation
        binary_initial_state,
        float_initial_state,
        # Evaluation
        sphere,
        rosenbrock,
        quartic,
        schwefel,
        rastrigin,
        griewank,
        binarystring,
        # Selection
        default_select_pair,
        weighted_select_pair,
        fitness_selection,
        tournament_selection,
        # Crossover
        single_point_crossover,
        k_point_crossover,
        uniform_crossover,
        # Mutation
        mutation!

end
