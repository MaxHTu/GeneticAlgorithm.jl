"""
    transform_Range(values, oldMax, oldMin, newMax, newMin)

Transforms the range of values from the old range [oldMin, oldMax] to the new range [newMin, newMax].

# Arguments
- `values`: The values to be transformed. Can be a scalar, vector, or matrix.
- `oldMax`: The maximum value of the old range.
- `oldMin`: The minimum value of the old range.
- `newMax`: The maximum value of the new range.
- `newMin`: The minimum value of the new range.

# Returns
The transformed values with the same shape as the input values.

"""

function transform_Range(values::Union{Real,Vector,Matrix}, oldMax::Real, oldMin::Real, newMax::Real, newMin::Real)
    if oldMax == oldMin
        return values
    end
    return (((values .- oldMin) .* (newMax - newMin)) ./ (oldMax - oldMin)) .+ newMin
end