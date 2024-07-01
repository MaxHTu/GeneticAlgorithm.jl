using GeneticAlgorithm
using Test
using Random

@testset "GeneticAlgorithm.jl" begin
    include("test_evaluation.jl")
    include("test_mutation.jl")
end
