#' @useDynLib fmlr R_cpuvec_init
cpuvec_init = function(size, type)
{
  size = as.integer(size)
  .Call(R_cpuvec_init, size)
}



#' @useDynLib fmlr R_cpuvec_size
cpuvec_size = function(x_ptr)
{
  .Call(R_cpuvec_size, x_ptr)
}



#' @useDynLib fmlr R_cpuvec_to_robj
cpuvec_to_robj = function(x_ptr)
{
  .Call(R_cpuvec_to_robj, x_ptr)
}

#' @useDynLib fmlr R_cpuvec_from_robj
cpuvec_from_robj = function(x_ptr, robj)
{
  # TODO check matrix type of robj
  if (!is.double(robj))
    storage.mode(robj) = "double"
  
  .Call(R_cpuvec_from_robj, x_ptr, robj)
}



#' @useDynLib fmlr R_cpuvec_set
cpuvec_set = function(x_ptr, data)
{
  if (!is.double(data))
    storage.mode(data) = "double"
  
  .Call(R_cpuvec_set, x_ptr, data)
}

#' @useDynLib fmlr R_cpuvec_resize
cpuvec_resize = function(x_ptr, size)
{
  m = as.integer(m)
  n = as.integer(n)
  .Call(R_cpuvec_resize, x_ptr, size)
}



#' @useDynLib fmlr R_cpuvec_print
cpuvec_print = function(x_ptr, ndigits)
{
  ndigits = min(as.integer(ndigits), 15L)
  
  .Call(R_cpuvec_print, x_ptr, ndigits)
}

#' @useDynLib fmlr R_cpuvec_info
cpuvec_info = function(x_ptr)
{
  .Call(R_cpuvec_info, x_ptr)
}



#' @useDynLib fmlr R_cpuvec_fill_zero
cpuvec_fill_zero = function(x_ptr)
{
  .Call(R_cpuvec_fill_zero, x_ptr)
}

#' @useDynLib fmlr R_cpuvec_fill_one
cpuvec_fill_one = function(x_ptr)
{
  .Call(R_cpuvec_fill_one, x_ptr)
}

#' @useDynLib fmlr R_cpuvec_fill_val
cpuvec_fill_val = function(x_ptr, v)
{
  v = as.double(v)
  
  .Call(R_cpuvec_fill_val, x_ptr, v)
}

#' @useDynLib fmlr R_cpuvec_fill_linspace
cpuvec_fill_linspace = function(x_ptr, start, stop)
{
  start = as.double(start)
  stop = as.double(stop)
  
  .Call(R_cpuvec_fill_linspace, x_ptr, start, stop)
}



#' @useDynLib fmlr R_cpuvec_scale
cpuvec_scale = function(x_ptr, s)
{
  s = as.double(s)
  
  .Call(R_cpuvec_scale, x_ptr, s)
}

#' @useDynLib fmlr R_cpuvec_rev
cpuvec_rev = function(x_ptr)
{
  .Call(R_cpuvec_rev, x_ptr)
}
