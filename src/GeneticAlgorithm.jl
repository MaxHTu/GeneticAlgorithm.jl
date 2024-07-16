module GeneticAlgorithm

    include("initiation.jl")
    include("evaluation.jl")
    include("selection.jl")
    include("crossover.jl")
    include("mutation.jl")
    include("ga.jl")
    include("sudoku/sudoku.jl")
    include("knapsack/knapsack.jl")
    include("helper.jl")

    export
        # ga.jl
        geneticAlgorithm,
        genAlgo,
        solveRosenbrock,
        solveSudoku,
        solveKnapsack,

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
