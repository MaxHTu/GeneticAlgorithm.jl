module GeneticAlgorithm
    include("initiation.jl")
    include("evaluation.jl")
    include("selection.jl")
    include("crossover.jl")
    include("mutation.jl")
    include("ga.jl")

    export
    # initiation.jl
    initPop,
    
    # evaluation.jl
    sphere, rosenbrock, quartic, schwefel, rastrigin, griewank, binarystring,

    # selection.jl
    selection, tournamentSelection,

    # crossover.jl
    crossover,

    # mutation.jl
    mutation!,

    # ga.jl
    geneticAlgorithm, genAlgo
end