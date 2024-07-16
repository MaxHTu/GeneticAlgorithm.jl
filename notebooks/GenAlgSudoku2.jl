### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ a97f817d-514a-4cb7-bdec-8de5d0a17730
begin
	using Optimisers
	using StatsBase
end

# ╔═╡ 7b522fb4-6cb9-4691-8dc0-ee14646e52ec
begin
	r1 = [0,4,8,2,0,0,0,0,1]
	r2 = [1,0,0,3,8,4,7,2,6]
	r3 = [3,0,0,7,0,1,9,4,8]
	r4 = [0,7,2,6,4,5,1,8,0]
	r5 = [8,0,0,0,0,2,4,0,0]
	r6 = [0,0,0,0,0,0,0,0,7]
	r7 = [0,8,4,0,0,0,3,0,0]
	r8 = [6,0,0,4,1,0,0,0,2]
	r9 = [0,0,3,0,0,0,0,7,4]
	#r1 = [0,3,0,0,7,0,0,5,0]
	#r2 = [5,0,0,1,0,6,0,0,9]
	#r3 = [0,0,1,0,0,0,4,0,0]
	#r4 = [0,9,0,0,5,0,0,6,0]
	#r5 = [6,0,0,4,0,2,0,0,7]
	#r6 = [0,4,0,0,1,0,0,3,0]
	#r7 = [0,0,2,0,0,0,8,0,0]
	#r8 = [9,0,0,3,0,5,0,0,2]
	#r9 = [0,1,0,0,2,0,0,7,0]
	s = stack((r1,r2,r3,r4,r5,r6,r7,r8,r9))'
	display(s)
end

# ╔═╡ 8fd50ab5-7a8f-4ec5-9f60-7605042a1a6b
begin
	n = 9*9
	exp = [1,2,3,4,5,6,7,8,9]
	k = 0
	for x in range(1,size(s)[1])
		for y in range(1,size(s)[2])
			if s[x,y] == 0
				k = k + 1
			end
		end
	end
	j = n - k
end

# ╔═╡ 97895b93-f3ae-4838-8526-a05dcb0a974f
function checkChangeNum(s, x, y)
	if sort(s[x,:]) == exp
		return false
	end
	if sort(s[:,y]) == exp
		return false
	end
	if sort(vec(s[x-(x-1)%3:x-(x-1)%3+2,y-(y-1)%3:y-(y-1)%3+2])) == exp
		return false
	end
	return true
end

# ╔═╡ 7a5a4fc1-67f1-4785-83d5-5927511b68ef
# initial state based on rows so each row is already completed
function initialState()
	g = copy(s)
	for x in range(1,9)
		for y in range(1,9)
			if s[x,y] == 0
				t = exp[exp .∉ Ref(g[x,:])]
				t2 = t[t .∉ Ref(g[:,y])]
				if t2 != []
					g[x,y] = rand(t2)
				else
					g[x,y] = rand(t)
				end
			end
		end
	end
	return g
end

# ╔═╡ a79d88ed-e030-479c-a2df-1c02291eae75
function fitness(genome)
	sudoku = copy(s)
	f = 0
	for x in range(1,9)
		for y in range(1,9)
			if genome[x,y] != 0 && sudoku[x,y] == 0
				if !(genome[x,y] in sudoku[x,:]) && !(genome[x,y] in sudoku[:,y]) && !(genome[x,y] in sudoku[x-(x-1)%3:x-(x-1)%3+2,y-(y-1)%3:y-(y-1)%3+2])
					f = f + 2
				end
			end
		end
	end
	# check all rows and columns, for each completed row/col +10
	for i in range(1,9)
		if sort(genome[i,:]) == exp
			f = f + 10
		end
		if sort(genome[:,i]) == exp
			f = f + 10
		end
	end
	# check all cubes, for each completed cube +10
	for i in range(1,3)
		for j in range(1,3)
			if sort(vec(genome[i+(i-1)*2:i+(i-1)*2+2,j+(j-1)*2:j+(j-1)*2+2])) == exp
				f = f + 10
			end
		end
	end
	return f
end

# ╔═╡ 4f2766f3-e85c-4fa6-8143-af805338aedd
s[1,:]

# ╔═╡ 9a00a34c-a595-487b-89b7-0f2ad6041117
s

# ╔═╡ c6f88044-4f86-48c4-8867-af19bde3cbc7
function crossover_sudoku(s_1, s_2)
	s1 = copy(s_1)
	s2 = copy(s_2)
	# swap rows
	r = rand(1:9)
	#println(r)
	#display([s1[1:r,:]; s2[r+1:end,:]])
	#display([s2[1:r,:]; s1[r+1:end,:]])
	return [s1[1:r,:]; s2[r+1:end,:]], [s2[1:r,:]; s1[r+1:end,:]]
end

# ╔═╡ 05773f11-1834-4698-81eb-de49f0c9133f
begin
	a = initialState()
	b = initialState()
	display(a)
	display(b)
	crossover_sudoku(a,b)
end

# ╔═╡ 830ab889-7558-4297-b661-0b3778c53134
rand(0:1)

# ╔═╡ c95e8097-ebaa-4b64-9bc4-5a9e69ccfe4f
function uniform_crossover(s_1,s_2)
	s1 = copy(s_1)
	s2 = copy(s_2)
	for i in range(1,9)
		if rand(0:1) == 1
			s1[i,:] = s_2[i,:]
			s2[i,:] = s_1[i,:]
		end
	end
	return s1,s2
end

# ╔═╡ aae3ae65-03bd-4b74-b744-a368b1fe16a4
begin
	pot = []
	for i in range(1,9)
		if s[1,i] == 0
			push!(pot,i)
		end
	end
	i1 = rand(eachindex(pot))
	c1 = pot[i1]
	deleteat!(pot, i1)
	i2 = rand(eachindex(pot))
	c2 = pot[i2]
end

# ╔═╡ 202a0cd6-84b6-491e-8521-ad35e69b2d60
function mutation(o, probability=0.2)
	sudoku = copy(s)
	# pick random row
	r = rand(1:9)
	while sort(sudoku[r,:])[2] != 0
		r = rand(1:9)
	end
	p = rand()
	# if p < probability swap 2 numbers from selected row ()
	if p < probability
		pot = []
		for i in range(1,9)
			if sudoku[r,i] == 0
				push!(pot,i)
			end
		end
		i1 = rand(eachindex(pot))
		c1 = pot[i1]
		deleteat!(pot, i1)
		i2 = rand(eachindex(pot))
		c2 = pot[i2]

		v1 = o[r,c1]
		o[r,c1] = o[r,c2]
		o[r,c2] = v1
	end
	return o
end

# ╔═╡ b194b8bf-27b4-4b2d-a5d5-b095e70f6739
function select_pair(population, fitness_func)
	return sample(population, 2, replace=false)
	#return sample(population, Weights([fitness_func(g) for g in population]), 2)
end

# ╔═╡ 14488ff5-5d7f-471b-8b2f-c6fa56d52076
function generate_population(n::Int)
	return [initialState() for i in range(1, n)]
end

# ╔═╡ 8602187d-572e-468c-93d5-35eaeebff8b9
function run()
	size = 200
	population = generate_population(size)
	fittest = 0
	generation = 1
	for i in range(1,1000)
		if fittest == (2*k + 10*9*3)
			println("found solution")
			break
		end
			
		population = sort(population, by=fitness, rev=true)

		println(i)
		println([fitness(g) for g in population][1])

		if fittest != [fitness(g) for g in population][1]
			fittest = [fitness(g) for g in population][1]
			generation = i
		end

		next_generation = population[1:2]

		for j in range(1,trunc(Int, size/2)-1)
			parents = select_pair(population, fitness)
			a, b = uniform_crossover(parents[1], parents[2])
			a = mutation(a, 0.7+(i-generation)*0.05)
			b = mutation(b, 0.7+(i-generation)*0.05)
			push!(next_generation, a)
			push!(next_generation, b)
		end

		population = next_generation
	end
	display(population[1])
end

# ╔═╡ 408ea093-ebfa-469c-86f5-4206f6ab2d86
run()

# ╔═╡ 45ca464f-b4ae-4366-9f92-4b2910a6673a


# ╔═╡ e0cf0b80-12b7-472c-ac22-ede830ab5726
2*k + 10*9*1

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
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

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
# ╠═97895b93-f3ae-4838-8526-a05dcb0a974f
# ╠═7b522fb4-6cb9-4691-8dc0-ee14646e52ec
# ╠═8fd50ab5-7a8f-4ec5-9f60-7605042a1a6b
# ╠═7a5a4fc1-67f1-4785-83d5-5927511b68ef
# ╠═a79d88ed-e030-479c-a2df-1c02291eae75
# ╠═4f2766f3-e85c-4fa6-8143-af805338aedd
# ╠═9a00a34c-a595-487b-89b7-0f2ad6041117
# ╠═05773f11-1834-4698-81eb-de49f0c9133f
# ╠═c6f88044-4f86-48c4-8867-af19bde3cbc7
# ╠═830ab889-7558-4297-b661-0b3778c53134
# ╠═c95e8097-ebaa-4b64-9bc4-5a9e69ccfe4f
# ╠═aae3ae65-03bd-4b74-b744-a368b1fe16a4
# ╠═202a0cd6-84b6-491e-8521-ad35e69b2d60
# ╠═b194b8bf-27b4-4b2d-a5d5-b095e70f6739
# ╠═14488ff5-5d7f-471b-8b2f-c6fa56d52076
# ╠═8602187d-572e-468c-93d5-35eaeebff8b9
# ╠═408ea093-ebfa-469c-86f5-4206f6ab2d86
# ╠═45ca464f-b4ae-4366-9f92-4b2910a6673a
# ╠═e0cf0b80-12b7-472c-ac22-ede830ab5726
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
