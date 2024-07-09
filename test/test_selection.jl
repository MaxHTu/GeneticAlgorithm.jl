using Random
using GeneticAlgorithm

@testset "Selection" begin
    @testset "selection" begin
        rng = Random.seed!(6)
        @test GeneticAlgorithm.default_selection([[true, true, true],[false, true, true],[false,false,false],[true,false,true],[false,true,false]], 2) == [[false,true,false],[true,true,true]]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.default_selection([[1.0,2.0],[4.0,8.0],[2.0,4.0],[-2.0,-4.0],[-1.0,8.0]], 2) == [[-1.0, 8.0], [1.0, 2.0]]
        
        rng = Random.seed!(1)
        @test GeneticAlgorithm.weighted_selection([[true, true, true],[false, true, true],[false,false,false],[true,false,true],[false,true,false]], [100,100,0,0,0], 2) == [[true,true,true],[false,true,true]]
        rng = Random.seed!(1)
        @test GeneticAlgorithm.weighted_selection([[true, true, true],[false, true, true],[false,false,false],[true,false,true],[false,true,false]], [100,100,50,50,0], 2) == [[true,true,true],[true,false,true]]
        rng = Random.seed!(25)
        @test GeneticAlgorithm.weighted_selection([[1.0,2.0],[4.0,8.0],[2.0,4.0],[-2.0,-4.0],[-1.0,8.0]], [75,60,50,10,10], 2) == [[1.0, 2.0], [2.0, 4.0]]

        rng = Random.seed!(1)
        @test GeneticAlgorithm.fitness_selection([[true,true],[false,true],[true,false],[false,false]], [1,2,3,4], 1) == [[false,true]]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.fitness_selection([[0.07,0.35,0.73],[0.91,0.19,0.78],[0.67,0.17,0.57],[0.3,0.0,0.57]], [22,12,32,4], 1) == [[0.07,0.35,0.73]]

        rng = Random.seed!(1)
        @test GeneticAlgorithm.tournament_selection([[true,true],[false,true],[true,false],[false,false]], [1,2,3,4], 3, 1) == [[true,false]]
        rng = Random.seed!(6)
        @test GeneticAlgorithm.tournament_selection([[0.07,0.35,0.73],[0.91,0.19,0.78],[0.67,0.17,0.57],[0.3,0.0,0.57]], [22,12,32,4], 3, 1) == [[0.67,0.17,0.57]]
    end
end