module GeneticAlgorithm

    using Random

    include("evaluation.jl")
    include("crossover.jl")
    include("selection.jl")
    include("mutation.jl")
    include("rosenbrock/rosenbrock.jl")
    include("knapsack/knapsack.jl")
    include("ga.jl")
    include("sudoku/sudoku.jl")
    include("optimizer.jl")

    export
    knapsack,
    rosenbrock,
    bit_string_mutation,
    optimize,
    sphere,
    rosenbrock,
    quartic,
    schwefel,
    rastrigin,
    griewank,
    single_point_crossover,
    k_point_crossover,
    uniform_crossover,
    baseSudoku,
    initialState,
    generate_binary_genome,
    binary_initial_state,
    default_select_pair,
    float_initial_state,
    real_value_mutation,
    GA

end