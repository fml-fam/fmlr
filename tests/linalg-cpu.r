suppressMessages(library(fmlr))

m = 3
n = 2
x = cpumat(m, n)
x$fill_linspace(1, m*n)
xr = x$to_robj()

y = cpumat(m, n)
y$fill_eye()
yr = y$to_robj()


source("internals/common.r")
source("internals/linalg.r")
