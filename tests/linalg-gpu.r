suppressMessages(library(fmlr))

if (fml_gpu()){
  m = 3
  n = 2
  c = card()
  x = gpumat(c, m, n)
  x$fill_linspace(1, m*n)
  xr = x$to_robj()
  
  y = gpumat(c, m, n)
  y$fill_eye()
  yr = y$to_robj()
  
  v = gpumat(c, n)
  v$fill_linspace(1, n)
  vr = v$to_robj()
  
  source("internals/common.r")
  source("internals/linalg.r")
} # end if (fml_gpu())
