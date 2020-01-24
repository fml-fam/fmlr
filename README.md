# fmlr

* **Version:** 0.1-0
* **License:** [BSL-1.0](http://opensource.org/licenses/BSL-1.0)
* **Project home**: https://github.com/wrathematics/fmlr
* **Bug reports**: https://github.com/wrathematics/fmlr/issues
* **Documentation**: TODO


Interface to the [fml library](https://github.com/wrathematics/fml). fml is a C++ library defining a single interface for multiple dense matrix types, principally CPU, GPU, and MPI.

fmlr is a "medium-level" interface to computational linear algebra. It is higher-level than directly working with, for example, the BLAS. But it is lower-level than a high-level interface like R or Armadillo.

Differences between fmlr and other matrix interfaces (including the core R interface):

* Single interface supporting multiple fundamental types (`__half`, `float`, `double`) and backends (CPU, GPU, MPI).
* Data is always held externally to R (although CPU objects can inherit R data without a copy).
* Operations modifying data occur in-place (make your own copy if you don't want the data modified).

The fmlr interface largely tracks with the core fml interface, and the package version will match the fml release version used. We use R6 so that generally an R code can be translated to C++ by changing `$` to `.` (and a `_` to `::` for `linalg` functions). There are some R-specific enhancements which should be avoided if you plan to eventually convert to C++.


## Installation

You will need to install some dependencies. Make sure you have a system installation of MPI, e.g. [OpenMPI](https://www.open-mpi.org/), [MPICH](https://www.mpich.org/), or [MSMPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi). Then install:

```r
install.packages("pbdMPI")
remotes::install_github("wrathematics/pbdSLAP")
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

CPU types and constructors

| Function | Use |
|----------|-----|
| `cpumat` | CPU matrix constructor. |
| `cpumatR6` | The R6 class. Contains the method documentation via `?cpumatR6`. |
| `cpuvec` | CPU vector constructor. |
| `cpuvecR6` | The R6 class. Contains the method documentation via `?cpuvecR6`. |

GPU types and constructors

| Function | Use |
|----------|-----|
| `card` | GPU card constructor. Needed for GPU vector/matrix objects. |
| `gpumat` | GPU matrix constructor. |
| `gpumatR6` | The R6 class. Contains the method documentation via `?gpumatR6`. |
| `gpuvec` | GPU vector constructor. |
| `gpuvecR6` | The R6 class. Contains the method documentation via `?gpuvecR6`. |

MPI types and constructors

| Function | Use |
|----------|-----|
| `grid` | MPI grid constructor. Needed for MPI matrix objects. |
| `mpimat` | MPI matrix constructor. |
| `mpimatR6` | The R6 class. Contains the method documentation via `?mpimatR6`. |

Linear algebra API

| Function | Use |
|----------|-----|
| `linalg_add` | Adds two matrices of the same type/backend. |
| `linalg_matmult` | Multiplies two matrices of the same type/backend. |
| `linalg_crossprod` | Computes `t(x) %*% x`. |
| `linalg_tcrossprod` | Computes `x %*% t(x)`. |
| `linalg_xpose` | Computes the matrix transpose. |
| `linalg_lu` | Computes the LU factorization. |
| `linalg_trace` | Computes the sum of the diagonal. |
| `linalg_svd` | Computes the SVD. |
| `linalg_eigen_sym` | Computes the eigenvalues/eigenvectors. |
| `linalg_invert` | Computes the matrix inverse. |

Helper/converter functions

Function | Use |
|----------|-----|
| `cpu2cpu` | Copy a CPU vector/matrix to another. Fundamental types can differ. |
| `gpu2cpu` | Copy a GPU vector/matrix to CPU one. Fundamental types can differ. |
| `cpu2gpu` | Copy a CPU vector/matrix to GPU one. Fundamental types can differ. |
| `gpu2gpu` | Copy a GPU vector/matrix to another. Fundamental types can differ. |
| `mpi2cpu` | Copy a GPU vector/matrix to another. Fundamental types can differ. |
| `mpi2mpi` | Copy a GPU vector/matrix to another. Fundamental types can differ. |



## Example and Basic Usage

Most operations occur via side effects. Some of the linear algebra functions can return objects as a matter of convenience, but generally you will need to initialize an object and apply functions/methods to it. This can have performance advantages (primarily in avoiding copies), but is very different from how things normally work in R.

Here's how we might compute the singular values of a matrix, for example:

```r
suppressMessages(library(fmlr))

x = cpumat(3, 2)
x$fill_linspace(1, 6)
x$info()
## # cpumat 3x2 type=d
x
## 1.0000 4.0000 
## 2.0000 5.0000 
## 3.0000 6.0000 

s = cpuvec()
linalg_svd(x, s)

s$info()
## # cpuvec 2 type=d

s
## 9.5080 0.7729 

s$to_robj()
## [1] 9.5080320 0.7728696
```

Notice that we had to initialize the return before passing it to the svd function. Also the data in the input `x` is overwritten. If you want to preserve it, you would need to manually copy it before calling `linalg_svd()`.

Assignment via `<-` or `=` (or `->` for the weirdos) will only produce a "shallow copy". It will not duplicate the data in memory:

```r
x = cpumat(2, 3)
x$fill_linspace(1, 2)
x
## 1.0000 1.4000 1.8000 
## 1.2000 1.6000 2.0000 

y = x
y$fill_val(pi)
y
## 3.1416 3.1416 3.1416 
## 3.1416 3.1416 3.1416 

x
## 3.1416 3.1416 3.1416 
## 3.1416 3.1416 3.1416 
```

Instead, if we need a duplicate then we need to create a "deep copy":

```r
z = x$dupe()
x$fill_zero()

x
## 0.0000 0.0000 0.0000 
## 0.0000 0.0000 0.0000 

y
## 0.0000 0.0000 0.0000 
## 0.0000 0.0000 0.0000 

z
## 3.1416 3.1416 3.1416 
## 3.1416 3.1416 3.1416 
```


## Managing Backends

Generally, codes should be easy to port between different backends (CPU, GPU, MPI). The difficulty/differences generally come in object creation. To better understand this process, let's take a very simple example. We'll create a 3x3 diagonal matrix with diagonal elements 1, 2, 3, and we'll create it by using a vector and the `fill_diag()` method.

We'll start with the CPU backend because these are the simplest to work with.

```r
library(fmlr)

v = cpuvec(3)
v$set(0, 1)$set(1, 2)$set(2, 3)
v
## 1.0000 2.0000 3.0000 

x = cpumat(3, 3)
x$fill_diag(v)
x
## 1.0000 0.0000 0.0000 
## 0.0000 2.0000 0.0000 
## 0.0000 0.0000 3.0000 
```

For GPU objects, we need to first have a `card` object. This manages some internal GPU data. It is tied to a specific GPU (by ordinal ID), and you only need one object per GPU (not per GPU matrix/vector). You will need to pass this object to the `gpuvec()` and `gpumat()` constructors.

```r
library(fmlr)

c = card()
c
## GPU 0 (GeForce GTX 1070 Ti) 821/8116 MB - CUDA 10.1

v = gpuvec(c, 3)
v$set(0, 1)$set(1, 2)$set(2, 3)
v
## 1.0000 2.0000 3.0000 

x = gpumat(c, 3, 3)
x$fill_diag(v)
x
## 1.0000 0.0000 0.0000 
## 0.0000 2.0000 0.0000 
## 0.0000 0.0000 3.0000 
```

Using MPI objects is a little different from the others. We can't use them interactively and get parallelism at the same time. If you want to better understand this programming model, called SPMD, then I recommend reading [this tutorial](https://github.com/RBigData/tutorials/blob/master/content/pbdR/mpi.md).

Like with GPU objects, we have something extra to carry around. Here, it's a special MPI grid. You can have different grids, but this is pretty advanced, so we won't cover that here. We'll just use one grid with the default arguments. We also have to specify a blocking factor. Choosing good values for this is beyond the scope of this example. We use a 1x1 blocking to make sure that all processes own some of the data.

```r
suppressMessages(library(fmlr))

g = grid()
g

v = cpuvec(3)
v$set(0, 1)$set(1, 2)$set(2, 3)
if (g$rank0()) v

x = mpimat(g, 3, 3, 1, 1)
x$fill_diag(v)
x
```

Note two other differences from the previous objects. First, there is no `mpivec()` object. There's usually no point in distributing a vector. Consider that if you have a 100,000x100,000 matrix (of doubles), then that matrix would take up ~75 GiB of memory. Whereas a 100,000 length vector would use less than 1 MiB. The other difference is in how we print a non-distributed object. We only want to print it on one rank, and typically rank 0 is chosen.

We'll take our script and save it as `mpi.r`, and launch it via:

```bash
mpirun -np 2 Rscript mpi.r
```

And this is the output we see:

```
## Grid 0 2x1

1.0000 2.0000 3.0000 

1.0000 0.0000 0.0000 
0.0000 2.0000 0.0000 
0.0000 0.0000 3.0000 
```

We should see the same output if we run the script with one rank via `Rscript mpi.r` (no parallelism) or with say 4 ranks via `mpirun -np 4 Rscript mpi.r`.



## fml from C++

A copy of the core fml library is included in `inst/include/fml` of the package source, which will be in `include/fml` of the installed package. If you wish to link with fml, you can add `LinkingTo: fml` to your package DESCRIPTION file.
