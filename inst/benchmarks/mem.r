library(memuse)
suppressMessages(library(fmlr))
set.seed(1234)

m = 1e7
n = 5

cat("pre:\n")
Sys.procmem()

r = matrix(runif(m*n))
cat("\npost alloc:\n")
Sys.procmem()

x = as_cpumat(r, copy=FALSE)
cat("\npost convert:\n")
Sys.procmem()

cp = linalg_crossprod(x)
cat("\npost crossprod:\n")
Sys.procmem()
