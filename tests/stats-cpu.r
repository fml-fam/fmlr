suppressMessages(library(stats)) # for prcomp()
suppressMessages(library(fmlr))

m = 3
n = 2
x = cpumat(m, n)
x$fill_linspace(1, m*n)
xr = x$to_robj()

s = cpuvec()

source("internals/common.r")
source("internals/stats.r")
