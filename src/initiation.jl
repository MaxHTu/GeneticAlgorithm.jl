"""
    'popSize' Determines how many genomes in one population, e.g. 10
    'unitShape' Determines the dimension of the genome, e.g. [1] = Skalar, [3] = xyz-Vektor, [3,3] = 3x3 Matrix
    'values' Determines the Range of possible genome states, e.g. [0,1]
    'offset' Variable to set an arbitrary offset for the rand genome state generation
"""

function initPop(popSize::Int, unitShape::Vector{Int}, values::Union{Vector{Bool},Vector{Int},Vector{Float64},Vector{UnitRange{Int64}}})
    #function router for different range types
    #Wir supporten Int, Float, Binary // alles andere kann man versuchen zu casten oder wird gemappt auf irgendwas
    #Bedingung: Alle Zahlen in der Range müssen denselben type habe
    if(length(values) <= 0)
        return error("The values vector shouldn't be empty. Atm, the 'values' parameter accepts vectors of type: Bool, Int, Float64.") end
    if(values isa Vector{UnitRange{Int64}})
        print("This is a Range.")
    end
    # SKALAR and VECTOR shape
    if(length(unitShape)==1)
        print("This is a Vector.")
        return [rand(values,unitShape[1]) for _ in 1:popSize] end
    # MATRIX shape
    return [[rand(values,unitShape[1]) for _ in 1:unitShape[2]] for _ in 1:popSize]
end