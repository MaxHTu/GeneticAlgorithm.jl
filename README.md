# GeneticAlgorithm

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://MaxHTu.github.io/GeneticAlgorithm.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://MaxHTu.github.io/GeneticAlgorithm.jl/dev/)
[![Build Status](https://github.com/MaxHTu/GeneticAlgorithm.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/MaxHTu/GeneticAlgorithm.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/MaxHTu/GeneticAlgorithm.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/MaxHTu/GeneticAlgorithm.jl)


## Usage example:

> using GeneticAlgorithm

1. > genAlgo(50, true, 2, rosenbrock, 50, 0.25, 0.1);
2. > genAlgo(20, false, 25, sphere, 25, 0.5, 0.01);
3. > genAlgo(20, true, 50, binarystring, 25, 0.5, 0.01);