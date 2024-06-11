### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ ff3b1c41-f778-44ba-aef9-a1c4363a1c6e
begin
	# Defining the target number
	number = 42
	
	# Error function to calculate the difference between a value and the target number
	function Δ(value, number)
	    abs(number - value)
	end
	
	# Function to get the top survivors based on their closeness to the target number
	function top_survivors(values, number, top_percent=10)
	    errors_and_values = [(Δ(value, number), value) for value in values]
	    sorted_errors_and_values = sort(errors_and_values, by=x->x[1])
	    end_number = Int(length(values) * top_percent / 100)
	    sorted_errors_and_values[1:end_number]
	end
	
	# Function to mutate a value
	function mutate(value, mutations=10)
	    [value + rand() - 0.5 for i in 1:mutations]
	end
	
	# Function to mutate a list of values
	function mutate_list(list, mutations=10)
	    output = []
	    for element in list
	        output = vcat(output, mutate(element, mutations))
	    end
	    output
	end
	
	# Initial values
	initial_values = rand(500)
	global survivors = initial_values
	generations = 100
	top_survivors_sample = []
	
	# Evolution process
	for generation in 1:generations
	    global survivors
	    survivors = mutate_list(survivors)
	    errors_and_values = top_survivors(survivors, number)
	    survivors = [value for (error, value) in errors_and_values]
	    push!(top_survivors_sample, survivors[1:10])
	
	    if (generation == 1) || (generation % 10 == 0)
	        println("$generation => $(survivors[1:5])")
	    end
	end
	
	# Output the best guess
	println("Best guess: ", survivors[1])
end

# ╔═╡ Cell order:
# ╠═ff3b1c41-f778-44ba-aef9-a1c4363a1c6e
