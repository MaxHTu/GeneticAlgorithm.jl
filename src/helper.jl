"""
transformRange(
    values::Union{Vector,Matrix},
    oldMax::Real,
    oldMin::Real,
    newMax::Real,
    newMin::Real
)

Transforms values in a vector or matrix to a new range.

# Arguments
'values' Values to be transformed
'oldMax' The maximum value of the old range
'oldMin' The minimum value of the old range
'newMax' The maximum value of the new range
'newMin' The minimum value of the new range

"""
function transformRange(values::Union{Vector,Matrix}, oldMax::Real, oldMin::Real, newMax::Real, newMin::Real)
    if oldMax == oldMin
        return values
    end
    return (((values .- oldMin) .* (newMax - newMin)) ./ (oldMax - oldMin)) .+ newMin
end