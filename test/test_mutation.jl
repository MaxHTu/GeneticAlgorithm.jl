using Random
using GeneticAlgorithm

@testset "Mutation" begin
    @testset "boolean mutation" begin
        Random.seed!(1)
        @test GeneticAlgorithm.mutation!([true,true,true,true], 0.2, Bool) == [false,true,true,true]
        Random.seed!(6)
        @test GeneticAlgorithm.mutation!([false,false,true,true,false,true], 0.5, 0:1) == [false,true,true,false,true,false]
        Random.seed!(1)
        @test GeneticAlgorithm.mutation!([true,true,true,true,true,true],0.2, Bool) == [false,true,true,true,true,false]
        Random.seed!(6)
        @test GeneticAlgorithm.mutation!([false,false,true,true,false,true],0.7, Bool) == [false,true,false,false,true,false]
        Random.seed!(187)
        @test GeneticAlgorithm.mutation!([true true true;false false false;true true false;false true true], 0.25, Bool) == Bool[1 1 1; 0 0 0; 1 1 0; 0 1 1]
    end

    @testset "integer mutation" begin
        Random.seed!(45)
        t = [1,2,3,1,2,3,12,123,13,23]
        @test GeneticAlgorithm.mutation!([1,2,3,1,2,3,12,123,13,23], 0.2, Int64) == [711960564822610084, 2, -324017115208327961, 1, 2, 3, -8286716134043366933, 123, 13, 23]
        Random.seed!(678)
        @test GeneticAlgorithm.mutation!([1 2 3;1 2 3;12 123 13], 0.5, Int64) == [-755277176399581444 585156596226581799 3368135234670354038; 1 2 3; 12 -8908258767267589722 13]
        Random.seed!(999)
        @test GeneticAlgorithm.mutation!([1 2 3;1 2 3;12 123 13], 0.5, 0:100) == [1 15 85; 5 2 3; 12 2 80]
    
    end

    @testset "float mutation" begin
        Random.seed!(1)
        @test GeneticAlgorithm.mutation!([0.5,0.1], 0.02, Float64) == [0.5,0.1]
        Random.seed!(6)
        @test GeneticAlgorithm.mutation!([0.5,0.1,0.6,0.2], 0.25, Float64) == [0.5, 0.5606541099945747, 0.10497680261518871, 0.9673191696891903]
        Random.seed!(1)
        @test GeneticAlgorithm.mutation!([0.5,0.1,0.6,0.2,0.5,0.1,0.6,0.2], 0.5, Float64) == [0.34924148955718615, 0.1, 0.6, 0.2, 0.7701803478856664, 0.1, 0.6, 0.5710874493423871]
        Random.seed!(25)
        @test GeneticAlgorithm.mutation!([3.0,-9.0,18.0,6.0,1.0,9.0,-1.0,-4.0],0.2,-100:100) == [78.0, -9.0, 18.0, -7.0, 1.0, 9.0, -1.0, -4.0]
        Random.seed!(32)
        @test GeneticAlgorithm.mutation!([1.0,4.0,-8.0,16.0,2.0,5.0,-4.0,7.0],0.5,[-10,10]) == [10.0, 10.0, 10.0, -10.0, -10.0, 5.0, 10.0, 7.0]
        Random.seed!(678)
        @test GeneticAlgorithm.mutation!([1.0 0.2 33.3;1.0 2.4 3.99;12.0 12.34 13.0], 0.5, Float64) == [0.9590563422259427 0.031721402643654084 0.18258697693272852; 1.0 2.4 3.99; 12.0 0.5170823245732719 13.0]
        Random.seed!(999)
        @test GeneticAlgorithm.mutation!([1.0 0.2 33.3;1.0 2.4 3.99;12.0 12.34 13.0], 0.5, -100.0:100.0) == [1.0 -69.23463848528041 70.05946759097066; -88.17219203480582 2.4 3.99; 12.0 -95.02347136095197 59.80158378800763]
    end
end