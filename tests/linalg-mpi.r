suppressMessages(library(fmlr))

if (fml_mpi()){
  m = 3
  n = 2
  bfr = 1
  bfc = 1
  g = grid()
  
  x = mpimat(g, m, n, bfr, bfc)
  x$fill_linspace(1, m*n)
  xr = x$to_robj()
  
  y = mpimat(g, m, n, bfr, bfc)
  y$fill_eye()
  yr = y$to_robj()
  
  v = cpumat(n)
  v$fill_linspace(1, n)
  vr = v$to_robj()
  
  source("internals/common.r")
  source("internals/linalg.r")
} # end if (fml_mpi())
