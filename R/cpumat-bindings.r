#' @useDynLib fmlr R_cpumat_init
cpumat_init = function(m, n, type)
{
  m = as.integer(m)
  n = as.integer(n)
  .Call(R_cpumat_init, m, n)
}



cpumat_nrows = function(x_ptr)
{
  cpumat_dim(x_ptr)[1]
}

cpumat_ncols = function(x_ptr)
{
  cpumat_dim(x_ptr)[2]
}

#' @useDynLib fmlr R_cpumat_dim
cpumat_dim = function(x_ptr)
{
  .Call(R_cpumat_dim, x_ptr)
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



#' @useDynLib fmlr R_cpumat_fill_zero
cpumat_fill_zero = function(x_ptr)
{
  .Call(R_cpumat_fill_zero, x_ptr)
}

#' @useDynLib fmlr R_cpumat_fill_one
cpumat_fill_one = function(x_ptr)
{
  .Call(R_cpumat_fill_one, x_ptr)
}

#' @useDynLib fmlr R_cpumat_fill_val
cpumat_fill_val = function(x_ptr, v)
{
  v = as.double(v)
  
  .Call(R_cpumat_fill_val, x_ptr, v)
}

#' @useDynLib fmlr R_cpumat_fill_linspace
cpumat_fill_linspace = function(x_ptr, start, stop)
{
  start = as.double(start)
  stop = as.double(stop)
  
  .Call(R_cpumat_fill_linspace, x_ptr, start, stop)
}

#' @useDynLib fmlr R_cpumat_fill_eye
cpumat_fill_eye = function(x_ptr)
{
  .Call(R_cpumat_fill_eye, x_ptr)
}

# TODO diag

#' @useDynLib fmlr R_cpumat_fill_runif
cpumat_fill_runif = function(x_ptr, seed, min, max)
{
  if (missing(seed))
    seed = -1L
  else
    seed = as.integer(seed)
  
  min = as.double(min)
  max = as.double(max)
  
  .Call(R_cpumat_fill_runif, x_ptr, seed, min, max)
}

#' @useDynLib fmlr R_cpumat_fill_rnorm
cpumat_fill_rnorm = function(x_ptr, seed, min, max)
{
  if (missing(seed))
    seed = -1L
  else
    seed = as.integer(seed)
  
  min = as.double(min)
  max = as.double(max)
  
  .Call(R_cpumat_fill_rnorm, x_ptr, seed, min, max)
}
