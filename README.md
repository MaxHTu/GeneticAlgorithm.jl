# GeneticAlgorithm
A Julia package [genetic algorithms](http://en.wikipedia.org/wiki/Genetic_algorithm).

| **Documentation** | **Build Status** |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][CI-img]][CI-url] [![][coverage-img]][coverage-url] |

> [!IMPORTANT]
> This package is build for the Julia Programming for Machine Learning course at TU Berlin and will will not be maintained afterwards.

## Installation:

The package can be installed with the Julia package manager. From the Julia REPL, type ] to enter the Pkg REPL mode and run:

```
add https://github.com/MaxHTu/GeneticAlgorithm.jl
```

For using the package in a Pluto notebook run:
```
using Pkg;
Pkg.add(url="https://github.com/MaxHTu/GeneticAlgorithm.jl")
using GeneticAlgorithm
```


## Usage example:

To show how this package can be used, we use the two classical test problem for optimization. We choose the [Rosenbrock function](https://en.wikipedia.org/wiki/Rosenbrock_function) and [Sphere function](https://www.sfu.ca/~ssurjano/spheref.html). To run the examples run the following Pluto notebook: https://github.com/MaxHTu/GeneticAlgorithm.jl/notebooks/examples.jl

## Features


[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://MaxHTu.github.io/GeneticAlgorithm.jl/stable/

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://MaxHTu.github.io/GeneticAlgorithm.jl/dev/


[CI-img]: https://github.com/MaxHTu/GeneticAlgorithm.jl/actions/workflows/CI.yml/badge.svg?branch=main
[CI-url]: https://github.com/MaxHTu/GeneticAlgorithm.jl/actions/workflows/CI.yml?query=branch%3Amain

[coverage-img]: https://codecov.io/gh/MaxHTu/GeneticAlgorithm.jl/branch/main/graph/badge.svg
[coverage-url]: https://codecov.io/gh/MaxHTu/GeneticAlgorithm.jl