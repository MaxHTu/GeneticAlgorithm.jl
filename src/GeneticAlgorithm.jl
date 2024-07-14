module GeneticAlgorithm

    include("initiation.jl")
    include("evaluation.jl")
    include("selection.jl")
    include("crossover.jl")
    include("mutation.jl")
    include("ga.jl")

    export
        # ga.jl
        geneticAlgorithm,
        genAlgo,
        solveRosenbrock,

        # initiation.jl
        initPop,

        # evaluation.jl
        sphere,
        rosenbrock,
        quartic,
        schwefel,
        rastrigin,
        griewank,
        binarystring,

        # selection.jl
        default_select_pair,
        weighted_select_pair,
        fitness_selection,
        tournament_selection,

        # crossover.jl
        single_point_crossover,
        k_point_crossover,
        uniform_crossover,

        # mutation.jl
        mutation!

end
