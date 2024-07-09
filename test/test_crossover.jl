using Random
using GeneticAlgorithm

@testset "Crossover" begin
    @testset "crossover" begin
        rng = Random.seed!(3)
        child1, child2 = GeneticAlgorithm.single_point_crossover([false,false,false,false],[true,true,true,true])
        @test (child1, child2) == ([false,false,true,true],[true,true,false,false])

        rng = Random.seed!(9)
        child1, child2 = GeneticAlgorithm.single_point_crossover([1.0,4.0,-8.0,16.0],[3.0,-9.0,18.0,6.0])
        @test (child1, child2) == ([1.0,-9.0,18.0,6.0],[3.0,4.0,-8.0,16.0])

        rng = Random.seed!(3)
        child1, child2 = GeneticAlgorithm.k_point_crossover([false,false,false,false,false,false,false,false],[true,true,true,true,true,true,true,true], 3)
        @test (child1, child2) == ([false,false,true,false,false,false,false,false],[true,true,false,true,true,true,true,true])

        rng = Random.seed!(3)
        child1, child2 = GeneticAlgorithm.k_point_crossover([false,false,false,false,false,false,false,false],[true,true,true,true,true,true,true,true], 5)
        @test (child1, child2) == ([false,false,true,false,true,true,true,false],[true,true,false,true,false,false,false,true])

        rng = Random.seed!(25)
        child1, child2 = GeneticAlgorithm.k_point_crossover([1.0,4.0,-8.0,16.0,2.0,5.0,-4.0,7.0],[3.0,-9.0,18.0,6.0,1.0,9.0,-1.0,-4.0],3)
        @test (child1, child2) == ([1.0, 4.0, 18.0, 6.0, 2.0, 5.0, -4.0, 7.0], [3.0, -9.0, -8.0, 16.0, 1.0, 9.0, -1.0, -4.0])

        rng = Random.seed!(32)
        child1, child2 = GeneticAlgorithm.k_point_crossover([1.0,4.0,-8.0,16.0,2.0,5.0,-4.0,7.0],[3.0,-9.0,18.0,6.0,1.0,9.0,-1.0,-4.0],5)
        @test (child1, child2) == ([1.0, -9.0, -8.0, 6.0, 1.0, 9.0, -4.0, 7.0], [3.0, 4.0, 18.0, 16.0, 2.0, 5.0, -1.0, -4.0])

        rng = Random.seed!(100)
        c1, c2 = GeneticAlgorithm.single_point_crossover([false,false,false,false],[true,true,true,true])
        rng = Random.seed!(100)
        child1, child2 = GeneticAlgorithm.k_point_crossover([false,false,false,false],[true,true,true,true], 2)
        @test (c1, c2) == (child1, child2)

        rng = Random.seed!(99)
        child1, child2 = GeneticAlgorithm.uniform_crossover([false,false,false,false],[true,true,true,true])
        @test (child1, child2) == ([false,false,false,true],[true,true,true,false])

        rng = Random.seed!(7)
        child1, child2 = GeneticAlgorithm.uniform_crossover([false,false,false,false,false,false,false,false],[true,true,true,true,true,true,true,true])
        @test (child1, child2) == ([false,true,true,false,true,false,true,true],[true,false,false,true,false,true,false,false])
        end
end