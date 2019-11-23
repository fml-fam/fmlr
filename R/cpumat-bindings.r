#' @useDynLib fmlr R_cpumat_init
cpumat_init = function(m, n, type)
{
  m = as.integer(m)
  n = as.integer(n)
  .Call(R_cpumat_init, m, n)
}
