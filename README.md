# fmlr

* **Version:** 0.4-0
* **License:** [BSL-1.0](http://opensource.org/licenses/BSL-1.0)
* **Project home**: https://github.com/fml-fam/fmlr
* **Bug reports**: https://github.com/fml-fam/fmlr/issues
* **Documentation**: https://fml-fam.github.io/fmlr


## Quick Intro

**What is this?**

fmlr is an R package for high-performance matrix computing. We offer CPU, GPU, and MPI matrix classes and numerous linear algebra and statistics methods.

**Who is this for?**

Primarily anyone who is creating and implementing statistical methods with a heavy linear algebra component. For example, statisticians who are interested in pursuing computing and HPC grants.

Eventually we hope to add more support for the consumer of statistical methods (e.g. data scientists).

**How does it compare to <other matrix framework>**

fmlr is "medium-level", and unique in that it not only performs well against the wallclock, but also in terms of memory consumption.

**How can I use this?**

The best place to start is looking at the [fmlr articles](https://fml-fam.github.io/fmlr).



## Details

fmlr is an R interface to the [fml library](https://github.com/fml-fam/fml). It is a "medium-level" interface for multiple dense matrix types, principally CPU, GPU, and MPI. Each supports multiple fundamental types (int, float, double), and data is held externally to R and operations that modify data generally occur in-place. The interface largely tracks with the core 'fml' interface. The interface is written such that generally an 'fmlr' R code can be easily translated to an 'fml' C++ code.

Differences between fmlr and other matrix interfaces (including the core R interface):

* Single interface supporting multiple fundamental types (`__half`, `float`, `double`) and backends (CPU, GPU, MPI).
* Data is always held externally to R (although CPU objects can inherit R data without a copy).
* Operations modifying data occur in-place (make your own copy if you don't want the data modified).

For a high-level interface on top of fmlr, see the [craze package](https://github.com/fml-fam/craze).



## Installation

In principle, installation can be as simple as:

```r
install.packages("fmlr", repos=c("https://hpcran.org", "https://cran.rstudio.com"))
```

This will build support for the CPU backend. If you want GPU or MPI support, please see the [Installation Guide](https://fml-fam.github.io/fmlr/html/articles/01-installation.html).



## Example Use

Calculating singular values on CPU:

```r
suppressMessages(library(fmlr))
x = cpumat(3, 2, type="float")
x$fill_linspace(1, 6)
x$info()
## # cpumat 3x2 type=f
x
## 1.0000 4.0000 
## 2.0000 5.0000 
## 3.0000 6.0000 

s = cpuvec(type="float")
linalg_svd(x, s)

s$info()
## # cpuvec 3 type=f
s
## 9.5080 0.7729 
```

and on GPU:

```r
c = card()
c
## GPU 0 (GeForce GTX 1070 Ti) 1139/8116 MB - CUDA 10.2

x = gpumat(c, 3, 2, type="float")
x$fill_linspace(1, 6)
x$info()
## # gpumat 3x2 type=f 

s = gpuvec(c, type="float")
linalg_svd(x, s)

s$info()
## # gpuvec 2 type=f 
s
## 9.5080 0.7729 
```

For more information and examples, see:

* [Package documentation](https://fml-fam.github.io/fmlr)
* Articles:
    - [Installation Guide](https://fml-fam.github.io/fmlr/html/articles/01-installation.html)
    - [Overview of fmlr](https://fml-fam.github.io/fmlr/html/articles/02-overview.html)
    - [Managing Backends](https://fml-fam.github.io/fmlr/html/articles/03-backends.html)
    - [Data Management](https://fml-fam.github.io/fmlr/html/articles/04-data.html)



## fml from C++

A copy of the core fml library is included in the [fmlh package](https://github.com/fml-fam/fmlh). If you wish to link with fml to create your own C++ kernels, you can add `LinkingTo: fmlh` to your R package DESCRIPTION file, as this very package does.

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
