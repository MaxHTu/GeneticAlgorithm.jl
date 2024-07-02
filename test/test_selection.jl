using Random
using GeneticAlgorithm

@testset "Selection" begin
    @testset "selection" begin
        rng = Random.seed!(1)
        @test GeneticAlgorithm.selection([[true,true],[false,true],[true,false],[false,false]], [1,2,3,4]) == [false,true]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.selection([[0.07,0.35,0.73],[0.91,0.19,0.78],[0.67,0.17,0.57],[0.3,0.0,0.57]], [22,12,32,4]) == [0.07,0.35,0.73]

        rng = Random.seed!(1)
        @test GeneticAlgorithm.tournamentSelection([[true,true],[false,true],[true,false],[false,false]], [1,2,3,4], 3) == [true,false]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.tournamentSelection([[0.07,0.35,0.73],[0.91,0.19,0.78],[0.67,0.17,0.57],[0.3,0.0,0.57]], [22,12,32,4], 3) == [0.67,0.17,0.57]
    end
end