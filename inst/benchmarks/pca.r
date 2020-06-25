library(merkhet)
suppressMessages(library(stats))
suppressMessages(library(float))
suppressMessages(library(fmlr))

m = 100000
n = 250
seed = 1234
type = "float"



# ------------------------------------------------------------------------------
b = bench(sprintf("pca - %dx%d (%s) type=%s", m, n, as.character(howbig(m, n, type=type)), type))

x_cpu = cpumat(m, n, type=type)
x_cpu$fill_runif(seed)
x_r = dbl(x_cpu$to_robj())

b$time(prcomp(x_r, retx=FALSE), name="R")

b$time({
  sdev_cpu = cpuvec(type=type)
  rot_cpu = cpumat(type=type)
  
  pca_cpu = stats_pca(TRUE, FALSE, x_cpu, sdev_cpu, rot_cpu)
}, name="fmlr - CPU")

if (fml_gpu())
{
  c = card()
  x_gpu = gpumat(c, type=type)
  x_gpu$from_robj(x_r)
  
  b$time({
    sdev_gpu = gpuvec(c, type=type)
    rot_gpu = gpumat(c, type=type)
    
    pca_gpu = stats_pca(TRUE, FALSE, x_gpu, sdev_gpu, rot_gpu)
    c$synch()
  }, name="fmlr - GPU")
}



b$print()
