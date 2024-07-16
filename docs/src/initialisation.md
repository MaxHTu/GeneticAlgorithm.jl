# Initialisation
This is the starting point of a Genetic Algorithm. The Initialisation generates the initial population of individuals, which is usually generated randomly.

## Initialisation Functions

```julia
    initPop(popSize::Integer, unitShape::AbstractVector{<:Integer}, unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}})

This function initializes a population of individuals for a genetic algorithm.

**Arguments**
- `popSize::Integer`: The number of individuals in the population.
- `unitShape::AbstractVector{<:Integer}`: The shape of each individual in the population.
- `unitValues::Union{Type,Vector{Bool},AbstractVector{<:Real},AbstractRange{<:Real}}`: The range of values for each element in the individual.

**Returns**
- `pop::Vector{<:AbstractArray}`: The initialized population.

**Details**
- If `unitShape` is a scalar or a vector, the function generates random individuals with values from `unitValues`.
- If `unitShape` is a matrix, the function generates random individuals with values from `unitValues`.
```

```@docs
```
