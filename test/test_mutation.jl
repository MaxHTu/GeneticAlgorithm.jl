using Random
using GeneticAlgorithm

@testset "Mutation" begin
    @testset "bit_string_mutation" begin
        rng = Random.seed!(1)
        @test GeneticAlgorithm.mutation!([true,true,true,true]) == [false,true,true,true]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.mutation!([false,false,true,true,false,true]) == [false,true,true,false,true,true]
        rng = Random.seed!(1)
        @test GeneticAlgorithm.mutation!([true,true,true,true,true,true],0.2) == [false,true,true,true,true,false]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.mutation!([false,false,true,true,false,true],0.2) == [false,true,true,false,true,false]

        rng = Random.seed!(1)
        @test GeneticAlgorithm.mutation!([true,true,true,true], 0.2) == [false,true,true,true]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.mutation!([false,false,true,true,false,true], 0.2) == [false,true,true,false,true,false]
        rng = Random.seed!(1)
        @test GeneticAlgorithm.mutation!([true,true,true,true,true,true], 0.5) == [false,false,true,true,true,false]
    end

    @testset "float_mutation" begin
        rng = Random.seed!(1)
        @test GeneticAlgorithm.mutation!([0.5,0.1], 0.2, [0,1]) == [0.5,0.1]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.mutation!([0.5,0.1,0.6,0.2], 0.2, [0,1]) == [0.5, 0.10000000000000009, 0.6, 0.19999999999999996]
        rng = Random.seed!(1)
        @test GeneticAlgorithm.mutation!([0.5,0.1,0.6,0.2,0.5,0.1,0.6,0.2], 0.5, [0,1]) == [0.5, 0.1, 0.6, 0.2, 0.5, 0.1, 0.6, 0.19999999999999996]

        rng = Random.seed!(25)
        @test GeneticAlgorithm.mutation!([3.0,-9.0,18.0,6.0,1.0,9.0,-1.0,-4.0],0.2,[-100,100]) == [81.0, -9.0, 18.0, -1.0, 1.0, 9.0, -1.0, -4.0]
        rng = Random.seed!(32)
        @test GeneticAlgorithm.mutation!([1.0,4.0,-8.0,16.0,2.0,5.0,-4.0,7.0],0.5,[-10,10]) == [9.0, 1.0, 0.0, 7.0, -3.0, 5.0, -3.0, 7.0]
    end
end
