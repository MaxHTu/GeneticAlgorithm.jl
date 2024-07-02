using GeneticAlgorithm
using Test

@testset "GeneticAlgorithm.jl" begin
    include("test_initiation.jl")
    include("test_evaluation.jl")
    include("test_selection.jl")
    include("test_crossover.jl")
    include("test_mutation.jl")
end
