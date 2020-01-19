# fmlr

* **Version:** 0.1-0
* **License:** [BSL-1.0](http://opensource.org/licenses/BSL-1.0)
* **Project home**: https://github.com/wrathematics/fmlr
* **Bug reports**: https://github.com/wrathematics/fmlr/issues


Interface to the [fml library](https://github.com/wrathematics/fml). fml is a C++ library defining a single interface for multiple dense matrix types, principally CPU, GPU, and MPI.

Differences between fmlr and other matrix interfaces (including the core R interface):

* Single interface supporting multiple fundamental types (`__half`, `float`, `double`) and backends (CPU, GPU, MPI).
* Data is always held externally to R.


## Installation

The development version is maintained on GitHub:

```r
remotes::install_github("wrathematics/fmlr")
```

If you have CUDA installed, then you can build the package with GPU support via:

```r
remotes::install_github("wrathematics/fmlr", configure.args="--enable-gpu")
```

or something like this:

```bash
R CMD INSTALL fmlr/ --configure-args="--enable-gpu"
```

If you build the package without GPU support, then the various GPU functions won't work (obviously). You can test for GPU support in the installed package via `fmlr::fml_gpu()`. There are `fml_cpu()` and `fml_mpi()` functions which always return `TRUE`. You can not build the package without MPI support.



## API

The API does not try to integrate into the existing R matrix API

CPU types

| Function | Use |
|----------|-----|
| `cpumat` | CPU matrix constructor. |
| `cpumatR6` | The R6 class. Contains the method documentation via `?cpumatR6`. |
| `cpuvec` | CPU vector constructor. |
| `cpuvecR6` | The R6 class. Contains the method documentation via `?cpuvecR6`. |

GPU types

| Function | Use |
|----------|-----|
| `card` | GPU card constructor. Needed for GPU vector/matrix objects. |
| `gpumat` | GPU matrix constructor. |
| `gpumatR6` | The R6 class. Contains the method documentation via `?gpumatR6`. |
| `gpuvec` | GPU vector constructor. |
| `gpuvecR6` | The R6 class. Contains the method documentation via `?gpuvecR6`. |

MPI types

| Function | Use |
|----------|-----|
| `grid` | MPI grid constructor. Needed for MPI matrix objects. |
| `mpimat` | MPI matrix constructor. |
| `mpimatR6` | The R6 class. Contains the method documentation via `?mpimatR6`. |

Linear algebra API

| Function | Use |
|----------|-----|
| `linalg_crossprod` | Computes `t(x) %*% x` |
| `linalg_tcrossprod` | Computes `x %*% t(x)` |



## Example

```r
suppressMessages(library(fmlr))

x = cpumat(3, 2)
x$info()
## # cpumat 3x2 type=d

x$fill_linspace(1, 6)
x
## 1.0000 4.0000 
## 2.0000 5.0000 
## 3.0000 6.0000 

cp = linalg_crossprod(x)
cp$info()
## # cpumat 2x2 type=d

cp
## 14.0000 0.0000 
## 32.0000 77.0000 
```



## fml from C++

A copy of the core fml library is included in `inst/include/fml` of the package source, which will be in `include/fml` of the installed package. If you wish to link with fml, you can add `LinkingTo: fml` to your package DESCRIPTION file.
