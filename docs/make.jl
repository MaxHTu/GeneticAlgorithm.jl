using GeneticAlgorithm
using Documenter

DocMeta.setdocmeta!(GeneticAlgorithm, :DocTestSetup, :(using GeneticAlgorithm); recursive=true)

makedocs(;
    modules=[GeneticAlgorithm],
    authors="Max Hiort <m.hiort@campus.tu-berlin.de>, Konstantin Prieb <k.prieb@campus.tu-berlin.de>, Fenja Schulz <f.schulz@campus.tu-berlin.de>, Kirill Simonov <k.simonov@campus.tu-berlin.de>",
    sitename="GeneticAlgorithm.jl",
    format=Documenter.HTML(;
        canonical="https://MaxHTu.github.io/GeneticAlgorithm.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MaxHTu/GeneticAlgorithm.jl",
    devbranch="main",
)
