library(merkhet)
suppressMessages(library(fmlr))

m = 100000
n = 250
seed = 1234
type = "float"



# ------------------------------------------------------------------------------
b = bench()

x_cpu = cpumat(m, n)
x_cpu$fill_runif(seed)
x_r = x_cpu$to_robj()


b$time({crossprod(x_r)}, name="R")

b$time({linalg_crossprod(x=x_cpu)}, name="fmlr - CPU")

if (fml_gpu())
{
  c = card()
  x_gpu = gpumat(c)
  x_gpu$from_robj(x_r)
  
  b$time({linalg_crossprod(x=x_gpu)}, name="fmlr - GPU")
}



b$print()
