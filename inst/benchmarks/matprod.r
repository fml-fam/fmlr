library(merkhet)
suppressMessages(library(fmlr))

m = n = 250
seed = 1234
type = "float"



# ------------------------------------------------------------------------------
header = sprintf("matprod - %dx%d (%s) type=%s", m, n, as.character(howbig(m, n, type=type)), type)
b = bench(header, flops=2*n^3)

tol = ifelse(type=="double", 1e-8, 1e-4)

x = cpumat(n, n, type)
x$fill_rnorm(seed)
xr = x$to_robj()

y = cpumat(n, n, type)
y$fill_rnorm()
yr = y$to_robj()


b$time({xr %*% yr}, name="R")

b$time(linalg_matmult(FALSE, FALSE, x=x, y=y), name="fmlr - CPU")

if (fml_gpu())
{
  c = card()
  xg = gpumat(c, type=type)
  cpu2gpu(x, xg)
  yg = gpumat(c, type=type)
  cpu2gpu(y, yg)
  
  b$time({
    linalg_matmult(FALSE, FALSE, x=xg, y=yg)
    c$synch()
  }, name="fmlr - GPU")
}



b$print()
