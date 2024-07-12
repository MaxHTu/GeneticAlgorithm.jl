"""
    mutation!(unit::Vector{AbstractFloat}, mutRate::Real)
    mutation!(unit::Vector{Bool}, mutRate::Real)

Mutate an unit by changing its genes depending on its type and a mutation rate.

# Arguments
- `unit`: Unit to be mutated, with T either Bool or AbstractFloat.
- `mutRate`: Mutation rate.

# Returns
- A mutated unit.
"""
function mutation!(unit::AbstractVector{<:AbstractFloat}, mutRate::Real)
    for i in eachindex(unit)
        if rand() < mutRate
            unit[i] = rand(Float64)
        end
    end

    return unit
end

function mutation!(unit::AbstractVector{Bool}, mutRate::Real)
    for i in eachindex(unit)
        if rand() < mutRate
            unit[i] = !unit[i]
        end
    end

    return unit
end
