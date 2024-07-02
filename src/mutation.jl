"""
    mutation!(unit::Vector, unitReal::Bool, mutRate::Float64)

Mutate an unit by changing its genes depending on its type and a mutation rate.

# Arguments
- `unit`: Unit to be mutated.
- `unitReal`: Type of unit, Real or Binary.
- `mutRate`: Mutation rate.

# Returns
- A mutated unit.
"""
function mutation(unit::Vector, unitReal::Bool, mutRate::Float64)
    for i in eachindex(unit)
        if rand() < mutRate
            unit[i] = unitReal ? rand(Float64) : !unit[i]
        end
    end

    return unit
end

export mutation!