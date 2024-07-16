using Random
using GeneticAlgorithm

@testset "sudoku" begin
    s = [0 4 8 2 0 0 0 0 1;1 0 0 3 8 4 7 2 6;3 0 0 7 0 1 9 4 8;0 7 2 6 4 5 1 8 0;8 0 0 0 0 2 4 0 0;0 0 0 0 0 0 0 0 7;0 8 4 0 0 0 3 0 0;6 0 0 4 1 0 0 0 2;0 0 3 0 0 0 0 7 4]
    Random.seed!(4)
    t = GeneticAlgorithm.initialState(s) 
    @test t == [9 4 8 2 7 6 5 3 1; 1 5 9 3 8 4 7 2 6; 3 6 5 7 2 1 9 4 8; 4 7 2 6 4 5 1 8 9; 8 1 7 5 9 2 4 6 3; 2 3 1 9 6 8 1 5 7; 7 8 4 1 5 9 3 1 4; 6 9 6 4 1 7 8 4 2; 5 2 3 8 5 3 6 7 4]

    Random.seed!(45)
    p = GeneticAlgorithm.generatePopulation(2, s)
    @test p == [[5 4 8 2 3 9 6 9 1; 1 9 5 3 8 4 7 2 6; 3 5 6 7 2 1 9 4 8; 9 7 2 6 4 5 1 8 3; 8 6 9 1 5 2 4 3 5; 4 3 1 9 6 8 2 5 7; 7 8 4 5 9 6 3 1 6; 6 6 7 4 1 3 8 3 2; 2 1 3 8 7 8 5 7 4], [9 4 8 2 5 6 9 3 1; 1 9 5 3 8 4 7 2 6; 3 2 6 7 8 1 9 4 8; 6 7 2 6 4 5 1 8 9; 8 5 7 9 6 2 4 1 3; 2 1 9 5 3 8 6 6 7; 7 8 4 1 9 9 3 5 5; 6 3 6 4 1 7 5 9 2; 5 6 3 8 2 8 6 7 4]]

    Random.seed!(53)
    @test GeneticAlgorithm.fitness(t,s) == 34
    @test GeneticAlgorithm.fitness(p[1],s) == 30
    @test GeneticAlgorithm.fitness(p[2],s) == 16

    Random.seed!(34)
    p1, p2 = GeneticAlgorithm.crossoverSudoku(p[1],p[2])
    @test p1 == [5 4 8 2 3 9 6 9 1; 1 9 5 3 8 4 7 2 6; 3 5 6 7 2 1 9 4 8; 9 7 2 6 4 5 1 8 3; 8 6 9 1 5 2 4 3 5; 2 1 9 5 3 8 6 6 7; 7 8 4 1 9 9 3 5 5; 6 3 6 4 1 7 5 9 2; 5 6 3 8 2 8 6 7 4]
    @test p2 == [9 4 8 2 5 6 9 3 1; 1 9 5 3 8 4 7 2 6; 3 2 6 7 8 1 9 4 8; 6 7 2 6 4 5 1 8 9; 8 5 7 9 6 2 4 1 3; 4 3 1 9 6 8 2 5 7; 7 8 4 5 9 6 3 1 6; 6 6 7 4 1 3 8 3 2; 2 1 3 8 7 8 5 7 4]

    @test GeneticAlgorithm.fitness(p1,s) == 0
    @test GeneticAlgorithm.fitness(p2,s) == 0

    Random.seed!(34)
    p3, p4 = GeneticAlgorithm.uniformCrossover(p[1],p[2])
    @test p3 == [9 4 8 2 5 6 9 3 1; 1 9 5 3 8 4 7 2 6; 3 2 6 7 8 1 9 4 8; 6 7 2 6 4 5 1 8 9; 8 5 7 9 6 2 4 1 3; 4 3 1 9 6 8 2 5 7; 7 8 4 5 9 6 3 1 6; 6 3 6 4 1 7 5 9 2; 2 1 3 8 7 8 5 7 4]
    @test p4 == [5 4 8 2 3 9 6 9 1; 1 9 5 3 8 4 7 2 6; 3 5 6 7 2 1 9 4 8; 9 7 2 6 4 5 1 8 3; 8 6 9 1 5 2 4 3 5; 2 1 9 5 3 8 6 6 7; 7 8 4 1 9 9 3 5 5; 6 6 7 4 1 3 8 3 2; 5 6 3 8 2 8 6 7 4]

    @test GeneticAlgorithm.fitness(p3,s) == 0
    @test GeneticAlgorithm.fitness(p4,s) == 0

    Random.seed!(84)
    p5 = GeneticAlgorithm.sudokuMutation(p3,s,0.5)
    @test p5 == [9 4 8 2 5 6 9 3 1; 1 9 5 3 8 4 7 2 6; 3 2 6 7 8 1 9 4 8; 6 7 2 6 4 5 1 8 9; 8 1 7 9 6 2 4 5 3; 4 3 9 1 6 8 2 5 7; 7 8 4 5 1 6 3 9 6; 6 3 6 4 1 7 5 9 2; 2 1 3 8 7 8 5 7 4]

    Random.seed!(10)
    p6 = solveSudoku(s,popSize=5,genNum=5)
    @test length(p6) == 5
    @test p6 == [[7 4 8 2 6 3 5 9 1; 1 5 9 3 8 4 7 2 6; 3 2 6 7 5 1 9 4 8; 9 7 2 6 4 5 1 8 3; 8 3 7 5 9 2 4 6 7; 5 1 1 8 3 6 2 5 7; 2 8 4 9 7 7 3 1 5; 6 9 5 4 1 8 1 3 2; 7 6 3 1 2 9 8 7 4], [7 4 8 2 6 9 5 3 1; 1 9 5 3 8 4 7 2 6; 3 2 6 7 5 1 9 4 8; 9 7 2 6 4 5 1 8 3; 8 3 7 5 9 2 4 6 7; 5 1 1 8 3 6 2 5 7; 2 8 4 9 7 7 3 1 5; 6 9 5 4 1 8 1 3 2; 7 6 3 1 2 9 8 7 4], [7 4 8 2 6 3 5 9 1; 1 5 9 3 8 4 7 2 6; 3 2 6 7 5 1 9 4 8; 3 7 2 6 4 5 1 8 9; 8 3 7 5 9 2 4 6 7; 5 1 1 8 3 6 2 5 7; 1 8 4 9 7 7 3 2 5; 6 9 5 4 1 8 1 3 2; 7 6 3 1 2 9 8 7 4], [7 4 8 2 9 3 5 6 1; 1 5 9 3 8 4 7 2 6; 3 2 6 7 5 1 9 4 8; 3 7 2 6 4 5 1 8 9; 8 5 7 3 9 2 4 6 7; 5 1 1 8 3 6 2 5 7; 2 8 4 9 7 7 3 1 5; 6 9 5 4 1 8 1 3 2; 7 6 3 1 2 9 8 7 4], [7 4 8 2 6 3 9 5 1; 1 5 9 3 8 4 7 2 6; 3 2 5 7 6 1 9 4 8; 9 7 2 6 4 5 1 8 3; 8 3 7 5 9 2 4 6 7; 5 1 5 8 3 6 2 1 7; 2 8 4 9 7 1 3 7 5; 6 9 5 4 1 8 1 3 2; 7 6 3 1 2 9 8 7 4]]
    @test p6[1] == [7 4 8 2 6 3 5 9 1; 1 5 9 3 8 4 7 2 6; 3 2 6 7 5 1 9 4 8; 9 7 2 6 4 5 1 8 3; 8 3 7 5 9 2 4 6 7; 5 1 1 8 3 6 2 5 7; 2 8 4 9 7 7 3 1 5; 6 9 5 4 1 8 1 3 2; 7 6 3 1 2 9 8 7 4]
end