"""
	single_point_crossover(gene1::Union{AbstractVector, AbstractMatrix}, gene2::Union{AbstractVector, AbstractMatrix})

Recombinate two units by exchanging their genes from a random index onward.

# Arguments
- `gene1`: Parent unit 1.
- `gene2`: Parent unit 2.

# Returns
- Two recombined child units.

"""
function single_point_crossover(gene1::Union{AbstractVector, AbstractMatrix}, gene2::Union{AbstractVector, AbstractMatrix})
    ga = copy(gene1)
    gb = copy(gene2)
    r = rand(1:length(ga) - 1)

    #MATRIX shape
	if(gene1 isa Matrix)
        #r has to be adjusted to matrix shape
		r = rand(1:size(ga, 2) - 1)
		return [ga[:, 1:r] gb[:, r + 1:end]], [gb[:, 1:r] ga[:, r + 1:end]]
	end

    #VECTOR shape
    return [ga[1:r]; gb[r + 1:end]], [gb[1:r]; ga[r + 1:end]]
end

"""
	k_point_crossover(gene1::Union{AbstractVector, AbstractMatrix}, gene2::Union{AbstractVector, AbstractMatrix}, k::Integer)

Recombinate two units by exchanging their genes at k random points

# Arguments
- `gene1`: Parent unit 1.
- `gene2`: Parent unit 2.
- `k`: # of crossover points.

# Returns
- Two recombined child units.

"""
function k_point_crossover(gene1::Union{AbstractVector, AbstractMatrix}, gene2::Union{AbstractVector, AbstractMatrix}, k::Integer)
    ga = copy(gene1)
    gb = copy(gene2)
    p = (gene1 isa Matrix) ? sort(sample(1:size(gene1, 2) - 1, k, replace=false)) : sort(sample(1:length(gene1) - 1, k, replace=false))
	
	for i in range(1,length(p))
		if i%2 == 0
			if(gene1 isa Matrix)
				ga[:, p[i-1] + 1:p[i]] = gene2[:, p[i-1] + 1:p[i]]
				gb[:, p[i-1] + 1:p[i]] = gene1[:, p[i-1] + 1:p[i]]
			else
				ga[p[i-1] + 1:p[i]] = gene2[p[i-1] + 1:p[i]]
				gb[p[i-1] + 1:p[i]] = gene1[p[i-1] + 1:p[i]]
			end
        elseif i == length(p)
			if(gene1 isa Matrix)
				ga[:, p[i] + 1:end] = gene2[:, p[i] + 1:end]
	            gb[:, p[i] + 1:end] = gene1[:, p[i] + 1:end]
			else
	            ga[p[i] + 1:end] = gene2[p[i] + 1:end]
	            gb[p[i] + 1:end] = gene1[p[i] + 1:end]
			end
        end
	end
    return [ga, gb]
end

"""
	uniform_crossover(gene1::Union{AbstractVector, AbstractMatrix}, gene2::Union{AbstractVector, AbstractMatrix})

Recombinate two units by iterating a gene and swapping the values with a 50% chance

# Arguments
- `gene1`: Parent unit 1.
- `gene2`: Parent unit 2.

# Returns
- Two recombined child units.

"""
function uniform_crossover(gene1::Union{AbstractVector, AbstractMatrix}, gene2::Union{AbstractVector, AbstractMatrix})
    ga = copy(gene1)
    gb = copy(gene2)
	r = (gene1 isa Matrix) ? size(gene1,2) : length(ga)

    for i in range(1, r)
		r = rand(0:1)
        if r != 0
			if(gene1 isa Matrix)
				gb[:, i] = gene1[:, i]
				ga[:, i] = gene2[:, i]
			else
            gb[i] = gene1[i]
            ga[i] = gene2[i]
			end
		end
	end
    return [ga, gb]
end