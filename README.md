# GeneticAlgorithm
A Julia package for [genetic algorithms](http://en.wikipedia.org/wiki/Genetic_algorithm).

| **Documentation** | **Build Status** |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][CI-img]][CI-url] [![][coverage-img]][coverage-url] |

> [!IMPORTANT]
> This package is build for the Julia Programming for Machine Learning course at TU Berlin and will will not be maintained afterwards.

## Installation:

The package can be installed with the Julia package manager. From the Julia REPL, type ] to enter the Pkg REPL mode and run:

```
] add https://github.com/MaxHTu/GeneticAlgorithm.jl
```

For using the package in a Pluto notebook run:
```julia
using Pkg;
Pkg.add(url="https://github.com/MaxHTu/GeneticAlgorithm.jl")
using GeneticAlgorithm
```


## Usage example:

To show how this package can be used, we use the two classical test problem for optimization. We choose the [Rosenbrock function](https://en.wikipedia.org/wiki/Rosenbrock_function) and [Sphere function](https://www.sfu.ca/~ssurjano/spheref.html). To run the examples run the following Pluto notebook: https://github.com/MaxHTu/GeneticAlgorithm.jl/notebooks/examples.jl

function collection:
binarystring: 
genAlgo(binarystring) mit default vars
genAlgo(binarystring,genNum=100) mit einigen default vars + selbst gewählten variablen
genAlgo(binarystring, crossover=(x,y) -> k_point_crossover(x,y,10)) mit eigenen funktionen (bsp. die k_point_crossover function von uns aus dem package als crossover function (funktionsaufruf beachten!))

griewank:
genAlgo(griewank)
genAlgo(griewank, unitValues=-1000.0:1000.0, genNum=500, mutRate=0.25)
genAlgo(griewank, selection=(a,b,c)->GeneticAlgorithm.weighted_selection(a,b,c)) weighted_selection anstatt default_selection

rastrigin:
genAlgo(rastrigin)
genAlgo(rastrigin, mutRate=0.75, crossRate=1, genNum=1000)

rosenbrock:
solveRosenbrock(a=4,b=100,genNum=100, mutRate=0.1, unitShape=[3], popSize=11)
solveRosenbrock(a=4,b=100,genNum=250, mutRate=0.25, unitShape=[2], popSize=500, unitValues=-1000.0:1000.0)
+ mehr in der VL

own fitness function: (maximize trace of a matrix between the values 0 and 723)
genAlgo(x -> tr(x), unitValues=0:723, popSize=10, mutRate=0.5, unitShape=[2,2], crossRate=0.8)

own fitness function: (find matrix with det = 0 <=> flip fitness score so desired output has highest value; 2d geht sogar noch manchmal aber 3d (unitShape=[3,3]) ist schwer)
function f(x)
    return det(x) >= 1000 ? 0.0001 : 1000-abs(det(x))
end
genAlgo(x -> f(x), unitValues=0:723, popSize=10, mutRate=0.5, unitShape=[2,2], crossRate=0.8, genNum=1000)

sudoku (ist eig gelöst wenn fitness = 180 für sudoku ein abbruchkriterium füge ich morgen noch hinzu)
s = [0 0 0 8 2 0 0 9 0;0 5 7 6 0 9 0 1 3;0 8 4 0 3 1 0 0 0;0 7 8 0 6 0 4 5 0;0 0 9 1 0 0 0 0 6;5 6 0 3 0 0 9 8 0;8 3 0 4 0 6 0 0 0;0 0 5 0 1 8 0 0 0;1 0 6 7 5 0 2 0 0]
solveSudoku(s, genNum=250)

## Features


[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://MaxHTu.github.io/GeneticAlgorithm.jl/stable/

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://MaxHTu.github.io/GeneticAlgorithm.jl/dev/


[CI-img]: https://github.com/MaxHTu/GeneticAlgorithm.jl/actions/workflows/CI.yml/badge.svg?branch=main
[CI-url]: https://github.com/MaxHTu/GeneticAlgorithm.jl/actions/workflows/CI.yml?query=branch%3Amain

[coverage-img]: https://codecov.io/gh/MaxHTu/GeneticAlgorithm.jl/branch/main/graph/badge.svg
[coverage-url]: https://codecov.io/gh/MaxHTu/GeneticAlgorithm.jl
