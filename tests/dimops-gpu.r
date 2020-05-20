suppressMessages(library(fmlr))

if (fml_gpu()){
  m = 3
  n = 2
  c = card()
  x = gpumat(c, m, n)
  x$fill_linspace(1, m*n)
  xr = x$to_robj()
  
  source("internals/common.r")
  source("internals/dimops.r")
} # end if (fml_gpu())
