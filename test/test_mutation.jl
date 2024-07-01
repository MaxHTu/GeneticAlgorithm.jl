using Random
using GeneticAlgorithm

@testset "Mutation" begin
    @testset "bit_string_mutation" begin
        rng = Random.seed!(1)
        @test GeneticAlgorithm.bit_string_mutation([true,true,true,true]) == [false,true,true,true]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.bit_string_mutation([false,false,true,true,false,true]) == [false,true,true,false,true,true]
        rng = Random.seed!(1)
        @test GeneticAlgorithm.bit_string_mutation([true,true,true,true,true,true],0.2) == [false,true,true,true,true,false]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.bit_string_mutation([false,false,true,true,false,true],0.2) == [false,true,true,false,true,false]
    end

    @testset "real_value_mutation" begin
        rng = Random.seed!(1)
        @test GeneticAlgorithm.real_value_mutation([1.0,1.0], 0.2) == [-29.0,1.0]
        rng = Random.seed!(2)
        @test GeneticAlgorithm.real_value_mutation([1.0,1.0,1.0], 0.30) == [37.0,1.0,1.0]
    end
end