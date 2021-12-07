library(merkhet)
library(stats)
suppressMessages(library(fmlr))
set.seed(1234)

m = 7500
n = 500
type = "double"
set.seed(1234)

b = bench(sprintf("cov - %dx%d (%s) type=%s", m, n, as.character(howbig(m, n, type=type)), type))

x = matrix(rnorm(m*n), m, n)
x_cpumat = as_cpumat(x, copy=FALSE)

b$time(name="R", reps=5, {
  ret1 = cov(x)
})

b$time(name="fmlr", reps=5, {
  dimops_scale(x=x_cpumat)
  alpha = 1 / max(1, nrow(x)-1)
  ret2 = linalg_crossprod(alpha, x_cpumat)
})

ret2 = ret2$to_robj()
all.equal(ret1[lower.tri(ret1)], ret2[lower.tri(ret2)])

b$print()
