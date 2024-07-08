using Random
using GeneticAlgorithm

@testset "Initiation" begin
    @testset "binary_initial_state" begin
        Random.seed!(1)
        @test binary_initial_state(4,4) == Vector{Bool}[[0, 1, 1, 0], [1, 1, 1, 1], [1, 1, 1, 0], [1, 0, 0, 0]]
        Random.seed!(6)
        @test binary_initial_state(10,2) == Vector{Bool}[[0, 0, 1, 1, 0, 0, 0, 1, 1, 0], [0, 1, 0, 1, 0, 1, 1, 1, 0, 0]]
        Random.seed!(3)
        @test binary_initial_state(2,10) == Vector{Bool}[[0, 1], [1, 1], [0, 0], [1, 0], [0, 0], [1, 1], [0, 0], [0, 1], [1, 1], [0, 0]]
    end

    @testset "float_initial_state" begin
        Random.seed!(1)
        @test float_initial_state(4,Float64[1.0],UnitRange{Float64}(-100:100)) == [[-85.0],[-29.0],[41.0],[27.0]]
        Random.seed!(6)
        @test float_initial_state(2,Float64[1.0,1.0,1.0],UnitRange{Float64}(-10:10)) == [[8.0, -8.0, 2.0],[-9.0, -7.0, -6.0]]
        Random.seed!(3)
        @test float_initial_state(5,Float64[1.0,1.0],UnitRange{Float64}(-100:0)) == [[-65.0, -3.0],[0.0, -90.0],[-29.0, -49.0],[-3.0, -19.0],[-19.0, -49.0]]
    end
end