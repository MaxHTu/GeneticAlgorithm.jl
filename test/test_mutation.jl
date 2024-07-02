using Random
using GeneticAlgorithm

@testset "Mutation" begin
    @testset "mutation" begin
        rng = Random.seed!(1)
        @test GeneticAlgorithm.mutation([true,true,true,true], false, 0.2) == [false,true,true,true]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.mutation([false,false,true,true,false,true], false, 0.2) == [false,true,true,false,true,false]
        rng = Random.seed!(1)
        @test GeneticAlgorithm.mutation([true,true,true,true,true,true], false, 0.5) == [false,false,true,true,true,false]

        rng = Random.seed!(1)
        @test isapprox(GeneticAlgorithm.mutation([0.5,0.1], true, 0.2), [0.35,0.1], atol=0.05)
        rng = Random.seed!(6)
        @test isapprox(GeneticAlgorithm.mutation([0.5,0.1,0.6,0.2], true, 0.2), [0.5,0.56,0.1,0.96], atol=0.05)
        rng = Random.seed!(1)
        @test isapprox(GeneticAlgorithm.mutation([0.5,0.1,0.6,0.2,0.5,0.1,0.6,0.2], true, 0.5), [0.35,0.1,0.6,0.2,0.77,0.1,0.6,0.57], atol=0.05)
    end
end