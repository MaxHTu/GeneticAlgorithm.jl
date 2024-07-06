# GeneticAlgorithm
A Julia package for genetic algorithms.

| **Documentation** | **Build Status** |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][CI-img]][CI-url] [![][coverage-img]][coverage-url] |



## Installation

## Usage example:

using GeneticAlgorithm

1. genAlgo(50, true, 2, rosenbrock, 50, 0.25, 0.1);
2. genAlgo(20, false, 25, sphere, 25, 0.5, 0.01);
3. genAlgo(20, true, 50, binarystring, 25, 0.5, 0.01);


[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://MaxHTu.github.io/GeneticAlgorithm.jl/stable/

[docs-dev-url]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-img]: https://MaxHTu.github.io/GeneticAlgorithm.jl/dev/

[CI-img]: https://github.com/MaxHTu/GeneticAlgorithm.jl/actions/workflows/CI.yml/badge.svg?branch=main
[CI-url]: https://github.com/MaxHTu/GeneticAlgorithm.jl/actions/workflows/CI.yml?query=branch%3Amain

[coverage-img]: https://codecov.io/gh/MaxHTu/GeneticAlgorithm.jl/branch/main/graph/badge.svg
[coverage-url]: https://codecov.io/gh/MaxHTu/GeneticAlgorithm.jl