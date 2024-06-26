module GeneticAlgorithm

    include("evaluation.jl")
    include("crossover.jl")
    include("sudoku/sudoku.jl")

    export 
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
    initialState

end