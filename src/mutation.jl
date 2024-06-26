"""
mutation!

Mutates an individual by changing its genes depending on a mutation rate [mutRate].
TODO: This function should be problem-specific and should be provided by the user.
"""
function mutation!(ind::Individual, mutRate::Float64)
    for i in 1:length(ind.genes)
        if rand() < mutRate
            ind.genes[i] = !ind.genes[i]
        end
    end
end

export mutation