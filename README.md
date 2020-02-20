# fmlr

* **Version:** 0.1-0
* **License:** [BSL-1.0](http://opensource.org/licenses/BSL-1.0)
* **Project home**: https://github.com/fml-fam/fmlr
* **Bug reports**: https://github.com/fml-fam/fmlr/issues
* **Documentation**: https://fml-fam.github.io/fmlr


Interface to the [fml library](https://github.com/fml-fam/fml). fml is a C++ library defining a single interface for multiple dense matrix types, principally CPU, GPU, and MPI.

fmlr is a "medium-level" interface to computational linear algebra. It is higher-level than directly working with, for example, the BLAS. But it is lower-level than a high-level interface like R or Armadillo.

Differences between fmlr and other matrix interfaces (including the core R interface):

* Single interface supporting multiple fundamental types (`__half`, `float`, `double`) and backends (CPU, GPU, MPI).
* Data is always held externally to R (although CPU objects can inherit R data without a copy).
* Operations modifying data occur in-place (make your own copy if you don't want the data modified).

The fmlr interface largely tracks with the core fml interface, and the package version will match the fml release version used. We use R6 so that generally an R code can be translated to C++ by changing `$` to `.` (and a `_` to `::` for `linalg` functions). There are some R-specific enhancements which should be avoided if you plan to eventually convert to C++.


## Installation

You will need to install some dependencies. Make sure you have a system installation of MPI, e.g. [OpenMPI](https://www.open-mpi.org/), [MPICH](https://www.mpich.org/), or [MSMPI](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi).

```r
# if you don't have a system installation of scalapack
remotes::install_github("snoweye/pbdSLAP@single")
# and if you do (change the link flags as necessary)
install.packages("pbdSLAP", configure.vars="EXT_LDFLAGS='-lscalapack-openmpi'")
```

Stable releases are published on the [hpcran](https://hpcran.org). You can install them via

```r
# If you don't have CUDA
install.packages("fmlr", repos=c("https://hpcran.org", "https://cran.rstudio.com"))
# and if you do
install.packages("fmlr", configure.args="--enable-gpu", repos=c("https://hpcran.org", "https://cran.rstudio.com"))
```

The development version of fmlr is maintained on GitHub. However, because we use git submodules, you can not (to my knowledge) use any of the `install_github()` functions. You can install the package from the command line via:

```bash
git clone --recurse-submodules https://github.com/fml-fam/fmlr.git
R CMD INSTALL fmlr/
```

If you have [NVIDIA® CUDA™](https://developer.nvidia.com/cuda-downloads) installed, then you can build the package with GPU support via:

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
| `linalg_solve` | Solve a system of equations. |

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



## Using R Data with fmlr

You can use matrix data from R with fmlr with relative ease. Here's a basic example:

```r
library(fmlr)

set.seed(1234)
x = matrix(rnorm(6), 3, 2)
x
##             [,1]       [,2]
## [1,] -0.03265408 -1.3353305
## [2,]  0.18148978  0.1630308
## [3,] -1.49135409 -0.0402416

x_cpu = as_cpumat(x, copy=FALSE)
x_cpu$info()
## # cpumat 3x2 type=d

c = card()
x_gpu = gpumat(c)
x_gpu = gpumat(c, type="float")
cpu2gpu(x_cpu, x_gpu)
x_gpu$info()
## # gpumat 3x2 type=f 
x_gpu
## -0.0327 -1.3353 
## 0.1815 0.1630 
## -1.4914 -0.0402 
```

This is fairly straightforward, but it is worth unpacking it in detail. First, we create an fmlr-compatible version of the input data with `as_cpumat()`. However, using it with `copy=FALSE` does not produce a copy the data. The class object merely inherits the same pointer that R is using. Be careful doing this because it can produce surprising results if you are not careful:

```r
x_cpu$fill_zero()
x
##      [,1] [,2]
## [1,]    0    0
## [2,]    0    0
## [3,]    0    0
```

Also, **do not allow a realloc to trigger on the inherited pointer**.

Next we initialize a skeleton for a GPU matrix by first initializing the card and then calling the constructor `gpumat()`. This only initializes the object and does not yet allocate any data on the GPU. The object is automatically resized in `cpu2gpu()`.

Note that the objects are actually of different fundamental type. The data we inherit from R is `double`, while the data on the GPU is `float`.

We can then perform some operations on the GPU data with the fmlr interface. For a real problem, you would probably want one of the linalg functions, but for simplicity we'll just call a simple filler and convert back to CPU:

```r
x_gpu$fill_eye()

gpu2cpu(x_gpu, x_cpu)
x
##      [,1] [,2]
## [1,]    1    0
## [2,]    0    1
## [3,]    0    0
```

If `x` and `x_cpu` had used different memory, we could have copied back via:

```r
x = x_cpu$to_robj()
```



## fml from C++

A copy of the core fml library is included in `inst/include/fml` of the package source, which will be in `include/fml` of the installed package. If you wish to link with fml, you can add `LinkingTo: fml` to your package DESCRIPTION file.

Before you write your own C++ code using fml, you should check the [fml API stability](https://github.com/fml-fam/fml#api-stability) progress, as some things may be subject to change.



## Similar Projects

Some similar R projects worth mentioning:

* Martin Maechler's (et al.) [Matrix package](https://cran.r-project.org/web/packages/Matrix/index.html)
* Charles Determan's [gpuR](https://github.com/cdeterman/gpuR) and [gpuR-related packages](https://github.com/gpuRcore)
* Norm Matloff's [Rth](https://github.com/Rth-org/Rth)

Some related R packages I have worked on:

* [float](https://github.com/wrathematics/float)
* [kazaam](https://github.com/RBigData/kazaam)
* [pbdDMAT](https://github.com/RBigData/pbdDMAT)

For C/C++ projects, see [the fml README](https://github.com/fml-fam/fml#philosophy-and-similar-projects).
