using Random
using GeneticAlgorithm

@testset "Initiation" begin
    @testset "initPop" begin
        rng = Random.seed!(1)
        @test GeneticAlgorithm.initPop(4, false, 4) == [[false,true,true,false],[true,true,true,true],[true,true,true,false],[true,false,false,false]]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.initPop(2, false, 10) == [[false,false,true,true,false,false,false,true,true,false],[false,true,false,true,false,true,true,true,false,false]]

        rng = Random.seed!(1)
        @test isapprox(GeneticAlgorithm.initPop(4, true, 4), [[0.07,0.35,0.7,0.63],[0.91,0.19,0.77,0.78],[0.67,0.17,0.57,0.45],[0.3,0.0,0.57,0.62]], atol=0.05)
        rng = Random.seed!(6)
        @test isapprox(GeneticAlgorithm.initPop(2, true, 10), [[0.66,0.28,0.63,0.38,0.94,0.49,0.89,0.47,0.24,0.32],[0.06,0.92,0.33,0.83,0.70,0.11,0.36,0.46,0.95,0.51]], atol=0.05)
    end
end