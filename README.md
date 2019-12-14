# fmlr

* **Version:** 0.1-0
* **License:** [BSL-1.0](http://opensource.org/licenses/BSL-1.0)
* **Project home**: https://github.com/wrathematics/fmlr
* **Bug reports**: https://github.com/wrathematics/fmlr/issues
* **Author:** Drew Schmidt


Interface to the [fml library](https://github.com/wrathematics/fml).

More on what this means later.


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
