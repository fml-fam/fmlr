suppressMessages(library(fmlr))
set.seed(1234)

m = 10000
n = 250
r = matrix(rnorm(m*n), m, n)

x = cpumat()
x$from_robj(r)
x$info()

system.time({
  crossprod(r)
})

system.time({
  linalg_crossprod(x)
})
