using Random
using GeneticAlgorithm

@testset "Crossover" begin
    @testset "crossover" begin
        child1, child2 = GeneticAlgorithm.crossover([false,true,true,false],[true,true,true,true])
        rng = Random.seed!(1)
        @test (child1, child2) == ([false,true,true,true],[true,true,true,false])

        child1, child2 = GeneticAlgorithm.crossover([false,true,true,false,false,true,true,false],[true,false,true,false,true,false,true])
        rng = Random.seed!(6)
        @test (child1, child2) == ([false,false,true,false,true,false,true],[true,true,true,false,false,true,true,false])

        child1, child2 = GeneticAlgorithm.crossover([0.07,0.35,0.7,0.63],[0.91,0.19,0.77,0.78])
        rng = Random.seed!(6)
        @test (child1, child2) == ([0.07,0.35,0.7,0.78],[0.91,0.19,0.77,0.63])

        child1, child2 = GeneticAlgorithm.crossover([0.66,0.28,0.63,0.38,0.94,0.49,0.89,0.47,0.24,0.32],[0.06,0.92,0.33,0.83,0.70,0.11,0.36,0.46,0.95,0.51])
        rng = Random.seed!(1)
        @test (child1, child2) == ([0.66,0.28,0.63,0.38,0.94,0.49,0.89,0.47,0.95,0.51],[0.06,0.92,0.33,0.83,0.70,0.11,0.36,0.46,0.24,0.32])
    end
end