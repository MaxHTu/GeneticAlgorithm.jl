using GeneticAlgorithm
using Test


@testset "Evaluation Functions" begin
    @testset "sphere" begin
        @test sphere([0.0, 0.0]) == 0.0
        @test sphere([1.0, 2.0]) == 5.0
        @test sphere([-1.0, -2.0]) == 5.0
        @test sphere([3.0, 4.0, 5.0]) == 50.0
    end

    @testset "rosenbrock" begin
        @test rosenbrock([1.0, 1.0]) == 0.0
        @test rosenbrock([0.0, 0.0]) == 1.0
        @test rosenbrock([1.0, 2.0]) > 0.0
    end

    @testset "quartic" begin
        @test abs(quartic([0.0, 0.0]) - 0.0) < 1.0
        @test quartic([1.0, 1.0]) > 1.0
        @test quartic([-1.0, -1.0]) > 1.0
    end

    @testset "schwefel" begin
        @test schwefel([420.9687, 420.9687]) ≈ 0.0 atol=1e-4
        @test schwefel([0.0, 0.0]) ≈ 837.9658 atol=1e-4
        @test schwefel([-420.9687, -420.9687]) ≈ 1675.9316 atol=1e-4
    end

    @testset "rastrigin" begin
        @test rastrigin([0.0, 0.0]) == 0.0
        @test rastrigin([1.0, 1.0]) > 0.0
        @test rastrigin([-1.0, -1.0]) > 0.0
    end

    @testset "griewank" begin
        @test griewank([0, 0, 0, 0]) == 0
        @test isapprox(griewank([1, 1, 1, 1]), 0.6989, atol=1e-4)
        @test isapprox(griewank([5, -5, 5, -5]), 1.228, atol=1e-4)
    end
end