using JuMLProjectGroupI
using Documenter

DocMeta.setdocmeta!(JuMLProjectGroupI, :DocTestSetup, :(using JuMLProjectGroupI); recursive=true)

makedocs(;
    modules=[JuMLProjectGroupI],
    authors="Max Hiort <m.hiort@campus.tu-berlin.de>, Konstantin Prieb <k.prieb@campus.tu-berlin.de>, Fenja Schulz <f.schulz@campus.tu-berlin.de>, Kirill Simonov <k.simonov@campus.tu-berlin.de>",
    sitename="JuMLProjectGroupI.jl",
    format=Documenter.HTML(;
        canonical="https://MaxHTu.github.io/JuMLProjectGroupI.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MaxHTu/JuMLProjectGroupI.jl",
    devbranch="main",
)
