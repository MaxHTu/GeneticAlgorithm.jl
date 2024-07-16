# Tutorial
To show how this package can be used, we use some of the predefined fitness functions and use the API. First it is important to use the package to get access to the function API.

```julia
using GeneticAlgorithm
```

## Examples
Simple examples of using the genAlgo function.

- Find maximum of binarystring function:

```julia
# with default values
genAlgo(binarystring)
# with set named optional variables
genAlgo(binarystring, genNum=100)
# with own provided optional crossover function
genAlgo(binarystring, crossover=(x,y) -> k_point_crossover(x,y,10))
```

- Find maximum of griewank function:

```julia
# with default values
genAlgo(griewank)
# with set named optional variables
genAlgo(griewank, unitValues=-1000.0:1000.0, genNum=500, mutRate=0.25)
# with own provided optional selection function
genAlgo(griewank, selection=(a,b,c)->GeneticAlgorithm.weighted_selection(a,b,c))
```

- Find maximum of rastrigin function:

```julia
# with default values
genAlgo(rastrigin)
# with set named optional variables
genAlgo(rastrigin, mutRate=0.75, crossRate=1, genNum=1000)
```

- Find maximum of rosenbrock function:

```julia
# with set named optional variables
solveRosenbrock(a=4,b=100,genNum=100, mutRate=0.1, unitShape=[3], popSize=11)
# with set named optional variables
solveRosenbrock(a=4,b=100,genNum=250, mutRate=0.25, unitShape=[2], popSize=500, unitValues=-1000.0:1000.0)
```

- Solve Sudoku:

```julia
s = [0 0 0 8 2 0 0 9 0;0 5 7 6 0 9 0 1 3;0 8 4 0 3 1 0 0 0;0 7 8 0 6 0 4 5 0;0 0 9 1 0 0 0 0 6;5 6 0 3 0 0 9 8 0;8 3 0 4 0 6 0 0 0;0 0 5 0 1 8 0 0 0;1 0 6 7 5 0 2 0 0]
solveSudoku(s, genNum=250)
```

One can also use own fitness functions:

- Maximize trace of a matrix between the values 0 and 723:

```julia
genAlgo(x -> tr(x), unitValues=0:723, popSize=10, mutRate=0.5, unitShape=[2,2], crossRate=0.8)
```

- Find matrix with det = 0 <=> flip fitness score so desired output has highest value:

```julia
function f(x)
    return det(x) >= 1000 ? 0.0001 : 1000-abs(det(x))
end

genAlgo(x -> f(x), unitValues=0:723, popSize=10, mutRate=0.5, unitShape=[2,2], crossRate=0.8, genNum=1000)
```