using Random
using GeneticAlgorithm

@testset "GenAlgo" begin
    Random.seed!(3)
    r1 = GeneticAlgorithm.solveRosenbrock(a=1,b=100,genNum=200,unitValues=-100.0:100.0)
    @test r1[1] == [1.5376917505007555, 2.062367277045624]

    Random.seed!(3)
    r2 = genAlgo(binarystring)
    @test r2[1] == [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

    Random.seed!(11)
    r3 = genAlgo(griewank)
    @test r3[1] == [0.13095245954411894, 9.420408873070983]
    @test r3[8] == [-260.12374785739667, 9.420408873070983]

    Random.seed!(45)
    r4 = genAlgo(rastrigin)
    @test r4[1] == [-0.0274096732204967, 0.0060188884745704385]

    Random.seed!(99)
    r5 = genAlgo(schwefel)
    @test r5[1] == [421.5722552056418, 431.27494178754614, 416.5897607120462]

    Random.seed!(999)
    r6 = genAlgo(quartic)
    @test r6[1] == [0.6767128071165464, 0.06574586648552172]

    Random.seed!(999)
    r7 = genAlgo(sphere)
    @test r7[1] == [-0.5614801372540272, -0.2859617289197871]


end