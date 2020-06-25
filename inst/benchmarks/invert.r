library(merkhet)
suppressMessages(library(float))
suppressMessages(library(fmlr))

m = n = 8000
seed = 1234
type = "float"



# ------------------------------------------------------------------------------
b = bench(sprintf("invert - %dx%d (%s) type=%s", m, n, as.character(howbig(m, n, type=type)), type))

tol = ifelse(type=="double", 1e-8, 1e-4)

x = cpumat(n, n, type)
x$fill_rnorm(seed)
xr = x$to_robj()


b$time({solve(xr)}, name="R")

b$time({linalg_invert(x)}, name="fmlr - CPU")

if (fml_gpu())
{
  c = card()
  xg = gpumat(c, type=type)
  cpu2gpu(x, xg)
  
  b$time({
    linalg_invert(xg)
    c$synch()
  }, name="fmlr - GPU")
}



b$print()
