# fmlr

* **Version:** 0.1-0
* **License:** [BSL-1.0](http://opensource.org/licenses/BSL-1.0)
* **Project home**: https://github.com/wrathematics/fmlr
* **Bug reports**: https://github.com/wrathematics/fmlr/issues
* **Documentation**: TODO


Interface to the [fml library](https://github.com/wrathematics/fml). fml is a C++ library defining a single interface for multiple dense matrix types, principally CPU, GPU, and MPI.

The fmlr interface largely tracks with the core fml interface, and the package version will match the fml release version used. We use R6 so that generally an R code can be translated to C++ by changing `$` to `.`. There are some R-specific enhancements which should be avoided if you plan to eventually convert to C++.

Differences between fmlr and other matrix interfaces (including the core R interface):

* Single interface supporting multiple fundamental types (`__half`, `float`, `double`) and backends (CPU, GPU, MPI).
* Data is always held externally to R (although CPU objects can inherit R data without a copy).
* Operations modifying data occur in-place (make your own copy if you don't want the data modified).


## Installation

You will need to install some dependencies. Make sure you have a system installation of MPI, e.g. [OpenMPI](https://www.open-mpi.org/), [MPICH](https://www.mpich.org/), or [MSMPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi). Then install:

```r
install.packages("pbdMPI")
remotes::install_github("snoweye/pbdSLAP", ref="single")
```

If you run into any issues, see the [pbdMPI package vignette](https://cran.r-project.org/web/packages/pbdMPI/vignettes/pbdMPI-guide.pdf).

The development version of fml is maintained on GitHub:

```r
remotes::install_github("wrathematics/fmlr")
```

If you have [NVIDIA® CUDA™](https://developer.nvidia.com/cuda-downloads) installed, then you can build the package with GPU support via:

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
| `linalg_add` | Adds two matrices of the same type/backend. |
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

cp$to_robj()
##      [,1] [,2]
## [1,]   14    0
## [2,]   32   77
```



## fml from C++

A copy of the core fml library is included in `inst/include/fml` of the package source, which will be in `include/fml` of the installed package. If you wish to link with fml, you can add `LinkingTo: fml` to your package DESCRIPTION file.
