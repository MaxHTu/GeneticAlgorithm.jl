#ToDO
# https://en.wikipedia.org/wiki/Crossover_(genetic_algorithm)
using StatsBase

function single_point_crossover(gene1, gene2)
    ga = copy(gene1)
    gb = copy(gene2)
    r = rand(1:length(ga))
    return [ga[1:r]; gb[r+1:length(ga)]], [gb[1:r]; ga[r+1:length(ga)]]
end

function k_point_crossover(gene1, gene2, k::Int64)
    ga = copy(gene1)
    gb = copy(gene2)
    p = sort(sample(1:length(gene1), k, replace=false))
    println(p)
	for i in range(1,length(p))
		if i%2 == 0
			ga[p[i-1]+1:p[i]] = gene2[p[i-1]+1:p[i]]
			gb[p[i-1]+1:p[i]] = gene1[p[i-1]+1:p[i]]
		end
	end
    return [ga, gb]
end

function uniform_crossover(gene1, gene2)
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
