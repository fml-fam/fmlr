library(merkhet)
suppressMessages(library(float))
suppressMessages(library(fmlr))

m = 100000
n = 250
seed = 1234
type = "float"



# ------------------------------------------------------------------------------
b = bench(sprintf("svd - %dx%d (%s) type=%s", m, n, as.character(howbig(m, n, type=type)), type))

tol = ifelse(type=="double", 1e-8, 1e-4)

x = cpumat(m, n, type)
x$fill_rnorm(seed)
x_r = x$to_robj()

b$time(La.svd(x_r), name="R")

b$time({
  s = cpuvec(type=type)
  u = cpumat(type=type)
  vt = cpumat(type=type)
  
  ret_cpu = linalg_svd(x=x, s, u, vt)
}, name="fmlr - CPU")

if (fml_gpu())
{
  c = card()
  x_g = gpumat(c, type=type)
  cpu2gpu(x, x_g)
  
  b$time({
    s_g = gpuvec(c, type=type)
    u_g = gpumat(c, type=type)
    vt_g = gpumat(c, type=type)
    
    ret_gpu = linalg_svd(x=x_g, s_g, u_g, vt_g)
    c$synch()
  }, name="fmlr - GPU")
}



b$print()
