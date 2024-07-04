using Random
using GeneticAlgorithm

@testset "GenAlgo" begin
    @testset "genAlgo" begin
        rng = Random.seed!(1)
        state = GeneticAlgorithm.genAlgo(50, true, 2, rosenbrock, 50, 0.25, 0.1);
        @test state.bestUnit ≈ [0.05, 1.0] rtol = 0.01
        @test state.bestFitness ≈ 100.1 rtol = 0.01
    end
end