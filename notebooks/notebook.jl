### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ 9e79441e-2722-11ef-1080-07b4c33cda54
begin
	using Pkg
	Pkg.add("Evolutionary")
	using Evolutionary
end

# ╔═╡ 644bfe7f-cda6-46ae-a43d-40a3928d4004
function rosenbrock(x)
    return sum(100 * (x[2:end] .- x[1:end-1].^2).^2 .+ (1 .- x[1:end-1]).^2)
end

# ╔═╡ 47c93466-c4ae-4d65-9884-15cfac3005aa
result = Evolutionary.optimize(
             rosenbrock, ones(3),
             GA(populationSize = 1000, selection = susinv,
                crossover = DC, mutation = PLM()))

# ╔═╡ b00c0b7e-ed51-474b-a58f-633b9aab4c37
println(result)

# ╔═╡ Cell order:
# ╠═9e79441e-2722-11ef-1080-07b4c33cda54
# ╠═644bfe7f-cda6-46ae-a43d-40a3928d4004
# ╠═47c93466-c4ae-4d65-9884-15cfac3005aa
# ╠═b00c0b7e-ed51-474b-a58f-633b9aab4c37
