# Mutation
The Mutation function makes random changes to the genes of individuals, mimicking the process of genetic mutation in nature. This is essential to maintain diversity in the population and introduce new genes to the population.

## Mutation Functions

```julia
    mutation!(gene, mutation_prob, unitValues)

Mutates the given `gene` based on the `mutation_prob` and `unitValues`.

# Arguments
- `gene`: A matrix or vector containing real numbers or boolean values.
- `mutation_prob`: The probability of mutation for each element in the `gene`.
- `unitValues`: A type or vector representing the range of values for mutation.

# Details
- For each element in the `gene`, if a random number is less than `mutation_prob`, the element is mutated.
- If `unitValues` is an abstract range of floating-point numbers, the mutated element is transformed to fit within the range.
- If `unitValues` is a vector of boolean values, the mutated element is negated.
- Otherwise, the mutated element is replaced with a random value from `unitValues`.

# Returns
The mutated `gene`.

``

```@docs
```
