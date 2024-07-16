using Random
using GeneticAlgorithm

@testset "Selection" begin
    Random.seed!(6)
    @test GeneticAlgorithm.default_selection([[true, true, true],[false, true, true],[false,false,false],[true,false,true],[false,true,false]], 2) == [[false,true,false],[true,true,true]]
    Random.seed!(6)
    @test GeneticAlgorithm.default_selection([[1.0,2.0],[4.0,8.0],[2.0,4.0],[-2.0,-4.0],[-1.0,8.0]], 2) == [[-1.0, 8.0], [1.0, 2.0]]
    Random.seed!(23)
    t = [[-86 26 54; -30 83 56; 40 -62 34], [-67 -40 23; 14 -100 -61; -9 13 -98], [-38 25 -1; -77 -46 80; 9 69 -26], [-61 100 66; -12 31 -21; -98 -15 -13]]
    @test GeneticAlgorithm.default_selection(t, 2) == [[-38 25 -1; -77 -46 80; 9 69 -26], [-61 100 66; -12 31 -21; -98 -15 -13]]

    Random.seed!(1)
    @test GeneticAlgorithm.weighted_selection([[true, true, true],[false, true, true],[false,false,false],[true,false,true],[false,true,false]], [100,100,0,0,0], 2) == [[true,true,true],[false,true,true]]
    Random.seed!(1)
    @test GeneticAlgorithm.weighted_selection([[true, true, true],[false, true, true],[false,false,false],[true,false,true],[false,true,false]], [100,100,50,50,0], 2) == [[true,true,true],[true,false,true]]
    Random.seed!(25)
    @test GeneticAlgorithm.weighted_selection([[1.0,2.0],[4.0,8.0],[2.0,4.0],[-2.0,-4.0],[-1.0,8.0]], [75,60,50,10,10], 2) == [[1.0, 2.0], [2.0, 4.0]]
    Random.seed!(25)

    #Random.seed!(1)
    #@test tournament_selection([[true,true],[false,true],[true,false],[false,false]], [1,2,3,4], 3) == [[true,false]]
    #Random.seed!(6)
    #@test tournament_selection([[0.07,0.35,0.73],[0.91,0.19,0.78],[0.67,0.17,0.57],[0.3,0.0,0.57]], [22,12,32,4], 3) == [[0.67,0.17,0.57]]
end