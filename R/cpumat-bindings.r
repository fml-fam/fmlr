#' @useDynLib fmlr R_cpumat_init
cpumat_init = function(m, n, type)
{
  m = as.integer(m)
  n = as.integer(n)
  .Call(R_cpumat_init, m, n)
}



#' @useDynLib fmlr R_cpumat_print
cpumat_print = function(x_ptr, ndigits)
{
  ndigits = min(as.integer(ndigits), 15L)
  
  .Call(R_cpumat_print, x_ptr, ndigits)
}

#' @useDynLib fmlr R_cpumat_info
cpumat_info = function(x_ptr)
{
  .Call(R_cpumat_info, x_ptr)
}
