### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ 610bc0bc-3bc1-11ef-362c-21b88a4ea279
begin
	using Pkg;
	Pkg.add(url="https://github.com/MaxHTu/GeneticAlgorithm.jl")
	using GeneticAlgorithm
end

# ╔═╡ 15735d06-3ac6-4a6c-b8a8-9007b4f64108
genAlgo(50, true, 2, rosenbrock, 50, 0.25, 0.1)

# ╔═╡ 28080877-94de-447d-88b9-84a06be16c6e
genAlgo(20, false, 25, sphere, 25, 0.5, 0.01);

# ╔═╡ 19d4bb36-672c-439d-9a76-5ceb8bf25373
genAlgo(20, true, 50, binarystring, 25, 0.5, 0.01);

# ╔═╡ Cell order:
# ╠═610bc0bc-3bc1-11ef-362c-21b88a4ea279
# ╠═15735d06-3ac6-4a6c-b8a8-9007b4f64108
# ╠═28080877-94de-447d-88b9-84a06be16c6e
# ╠═19d4bb36-672c-439d-9a76-5ceb8bf25373
