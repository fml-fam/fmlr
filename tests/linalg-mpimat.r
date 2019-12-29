suppressMessages(library(fmlr))

if (fml_mpi()){
  m = 3
  n = 2
  g = grid()
  x = mpimat(g, m, n)
  x$fill_linspace(1, m*n)
  r = x$to_robj()
  
  source("internals/common.r")
  source("internals/linalg.r")
} # end if (fml_mpi())
