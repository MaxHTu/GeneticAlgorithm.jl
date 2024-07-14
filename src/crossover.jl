using StatsBase

"""
    single_point_crossover(gene1::Vector, gene2::Vector)

Recombinate two units by exchanging their genes from a random index onward.

# Arguments
- `gene1`: Parent unit 1.
- `gene2`: Parent unit 2.

# Returns
- Two recombined child units.

"""
function single_point_crossover(gene1::Vector, gene2::Vector)
    ga = copy(gene1)
    gb = copy(gene2)
    r = rand(1:length(ga)-1)
    return [ga[1:r]; gb[r+1:end]], [gb[1:r]; ga[r+1:end]]
end

"""
    k_point_crossover(gene1::Vector, gene2::Vector, k::Integer)

Recombinate two units by exchanging their genes at k random points

# Arguments
- `gene1`: Parent unit 1.
- `gene2`: Parent unit 2.
- `k`: # of crossover points.

# Returns
- Two recombined child units.

"""
function k_point_crossover(gene1::Vector, gene2::Vector, k::Integer)
    ga = copy(gene1)
    gb = copy(gene2)
    p = sort(sample(1:length(gene1)-1, k, replace=false))
	for i in range(1,length(p))
		if i%2 == 0
			ga[p[i-1]+1:p[i]] = gene2[p[i-1]+1:p[i]]
			gb[p[i-1]+1:p[i]] = gene1[p[i-1]+1:p[i]]
        elseif i == length(p)
            ga[p[i]+1:end] = gene2[p[i]+1:end]
            gb[p[i]+1:end] = gene1[p[i]+1:end]
        end
	end
    return [ga, gb]
end

println(k_point_crossover([0,0,0,0,0,0,0,0,0,0], [1,1,1,1,1,1,1,1,1,1], 3))

"""
    uniform_crossover(gene1::Vector, gene2::Vector)

Recombinate two units by iterating a gene and swapping the values with a 50% chance

# Arguments
- `gene1`: Parent unit 1.
- `gene2`: Parent unit 2.

# Returns
- Two recombined child units.

"""
function uniform_crossover(gene1::Vector, gene2::Vector)
    ga = copy(gene1)
    gb = copy(gene2)
    for i in range(1,length(ga))
		r = rand(0:1)
        if r != 0
            gb[i] = gene1[i]
            ga[i] = gene2[i]
		end
	end
    return [ga, gb]
end
