suppressMessages(library(stats)) # for prcomp()
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
  
  s = cpuvec()
  
  source("internals/common.r")
  source("internals/stats.r")
} # end if (fml_mpi())
