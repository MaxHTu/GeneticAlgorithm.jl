### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ a97f817d-514a-4cb7-bdec-8de5d0a17730
begin
	using Optimisers
	using StatsBase
end

# ╔═╡ 62db0ad4-de6b-4e06-b4d5-4842b9646de0
begin
	struct GA
	    populationSize::Int
	    crossoverRate::Float64
	    mutationRate::Float64
	    ɛ::Real
	    selection
	    crossover
	    mutation
	end
	
end

# ╔═╡ b03f8f3b-08be-475a-8bb4-ec1aa5b12ee0
mutable struct GAState{T,IT}
    N::Int
    eliteSize::Int
    fitness::T
    fitpop::Vector{T}
    fittest::IT
end

# ╔═╡ 502bb931-694e-4ceb-a91d-aa450edd2018
begin
# test data for the knapsack problem
# (name, value, weight)
# problem: maximize value while keeping weight under weight_limit
	weight_limit=2000
	things = [
		("Laptop", 500, 2200),
	    ("Headphones", 150, 160),
	    ("Coffee Mug", 60, 350),
	    ("Notepad", 40, 333),
	    ("Water Bottle", 30, 192),
		("Mints", 50, 25),
		("Socks", 100, 38),
	    ("Tissues", 150, 80),
	    ("Phone", 500, 200),
	    ("Baseball Cap", 100, 70),
		("Shirt", 150, 75),
		("A", 1000, 50),
	    ("B", 105, 80),
	    ("C", 200, 400),
	    ("D", 130, 70)
	]
end

# ╔═╡ b2345923-4b3b-43d1-8029-5f745002978d


# ╔═╡ 6bae0288-5c11-4e80-b7ac-abb9e60c5208
begin
s = 0
for i in things
s = s+i[2]
end
	s
end

# ╔═╡ 11adf95a-5dcb-4b88-9f75-01e89be0f1a2
# genreates a array of size size with values either 1 or 0
# array should be of size of test_data
# 1 (=> item is in backpack)
# 0 (=> item not in backpack)
function generate_genome(size::Int)  rand([0,1],size) end

# ╔═╡ 75fcd718-e667-4c49-bcfb-53f0899c9322
# generates the population: n genomes of size size
function generate_population(size::Int, n::Int)  
	return [generate_genome(size) for i in range(1, n)]
end

# ╔═╡ ea1a9db9-bda5-4568-8b44-dcd5002dd897
# computes the fitness of a genome
# check all elements in genome, return sum of values of all elements in genome (if genome[x] != 0), if it exceedes the weight limit return 0
function fitness(genome)
	weight = 0
	value = 0
	for (i, thing) in enumerate(things)
		if genome[i] != 0
			weight += thing[3]
			value += thing[2]

			if weight > weight_limit
				return 0
			end
		end
	end
	return value
end

# ╔═╡ b194b8bf-27b4-4b2d-a5d5-b095e70f6739
# select 2 genomes for the new generation from the current population, weighted by the fitness of the genomes
function select_pair(population, fitness_func)
	return sample(population, Weights([fitness_func(g) for g in population]), 2)
end

# ╔═╡ 14fa43cc-9c93-4b80-897d-fc35baffb7e7
# crossover 2 genomes, by splitting them at a random index and then recombining them
function crossover(ga, gb)
	r = rand(1:length(ga))
	return [ga[1:r]; gb[r+1:length(ga)]], [gb[1:r]; ga[r+1:length(ga)]]
end

# ╔═╡ 91c05490-ff44-46be-b019-05e00229f580
# mutate a genome: switch 0 or 1 with a certain probability
function mutation(genome, probability, num=1)
	# num: # of elements to be switched
	for _ in range(1,num)
        index = rand(1:length(genome))
		r = rand()
		if r < probability 
			genome[index] = abs(genome[index] - 1)
		end
	end
	return genome
end

# ╔═╡ 8602187d-572e-468c-93d5-35eaeebff8b9
# run the evolutionary algorithm
function run()
	# generate initial state
	population = generate_population(15, 20)
	for i in range(1,50)
		# sort population by fitness score
		population = sort(population, by=fitness, rev=true)

		println(i)
		println([fitness(g) for g in sort(population, by=fitness, rev=true)])
		println(population)

		# take 2 best fitted elements for the next generation
		next_generation = population[1:2]

		for j in range(1,trunc(Int, 20/2)-1)
			# generate the rest of the next_generation
			# using pair selection, crossover and mutation
			parents = select_pair(population, fitness)
			a, b = crossover(parents[1], parents[2])
			a = mutation(a, 0.01)
			b = mutation(b, 0.01)
			push!(next_generation, a)
			push!(next_generation, b)
		end

		population = next_generation
	end
end

# ╔═╡ fd14e605-e73e-4abd-b014-4ef4b1f499ae
run()

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Optimisers = "3bd65402-5787-11e9-1adc-39752487f4e2"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
Optimisers = "~0.3.3"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "6e77459905f0d35ea7ac085a1c3a62763a19c3aa"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "71acdbf594aab5bbb2cec89b208c41b4c411e49f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.24.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Functors]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "8a66c07630d6428eaab3506a0eabfcf4a9edea05"
uuid = "d9f16b24-f501-4c13-a1f2-28368ffc5196"
version = "0.4.11"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "18144f3e9cbe9b15b070288eef858f71b291ce37"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.27"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Optimisers]]
deps = ["ChainRulesCore", "Functors", "LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "6572fe0c5b74431aaeb0b18a4aa5ef03c84678be"
uuid = "3bd65402-5787-11e9-1adc-39752487f4e2"
version = "0.3.3"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5cf7606d6cef84b543b483848d4ae08ad9832b21"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.3"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╠═a97f817d-514a-4cb7-bdec-8de5d0a17730
# ╠═62db0ad4-de6b-4e06-b4d5-4842b9646de0
# ╠═b03f8f3b-08be-475a-8bb4-ec1aa5b12ee0
# ╠═502bb931-694e-4ceb-a91d-aa450edd2018
# ╠═b2345923-4b3b-43d1-8029-5f745002978d
# ╠═6bae0288-5c11-4e80-b7ac-abb9e60c5208
# ╠═11adf95a-5dcb-4b88-9f75-01e89be0f1a2
# ╠═75fcd718-e667-4c49-bcfb-53f0899c9322
# ╠═ea1a9db9-bda5-4568-8b44-dcd5002dd897
# ╠═b194b8bf-27b4-4b2d-a5d5-b095e70f6739
# ╠═14fa43cc-9c93-4b80-897d-fc35baffb7e7
# ╠═91c05490-ff44-46be-b019-05e00229f580
# ╠═8602187d-572e-468c-93d5-35eaeebff8b9
# ╠═fd14e605-e73e-4abd-b014-4ef4b1f499ae
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
