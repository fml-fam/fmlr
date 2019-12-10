# ------------------------------------------------------------------------------
# card class methods
# ------------------------------------------------------------------------------

#' @useDynLib fmlr R_card_init
card_init = function(id=0)
{
  id = as.integer(id)
  .Call(R_card_init, id)
}

#' @useDynLib fmlr R_card_set
card_set = function(c_ptr, id)
{
  id = as.integer(id)
  .Call(R_card_set, c_ptr, id)
  invisible()
}

#' @useDynLib fmlr R_card_info
card_info = function(c_ptr)
{
  .Call(R_card_info, c_ptr)
  invisible()
}

#' @useDynLib fmlr R_card_get_id
card_get_id = function(c_ptr)
{
  .Call(R_card_get_id, c_ptr)
}

#' @useDynLib fmlr R_card_valid_card
card_valid_card = function(c_ptr)
{
  .Call(R_card_valid_card, c_ptr)
}



# ------------------------------------------------------------------------------
# gpuvec class methods
# ------------------------------------------------------------------------------

#' @useDynLib fmlr R_gpuvec_init
gpuvec_init = function(card, size, type)
{
  size = as.integer(size)
  .Call(R_gpuvec_init, card, size)
}

#' @useDynLib fmlr R_gpuvec_size
gpuvec_size = function(x_ptr)
{
  .Call(R_gpuvec_size, x_ptr)
}

#' @useDynLib fmlr R_gpuvec_inherit
gpuvec_inherit = function(x_ptr, data)
{
  if (!is.double(data))
    storage.mode(data) = "double"

  .Call(R_gpuvec_inherit, x_ptr, data)
}

#' @useDynLib fmlr R_gpuvec_resize
gpuvec_resize = function(x_ptr, size)
{
  size = as.integer(size)
  .Call(R_gpuvec_resize, x_ptr, size)
}

#' @useDynLib fmlr R_gpuvec_print
gpuvec_print = function(x_ptr, ndigits)
{
  ndigits = min(as.integer(ndigits), 15L)

  .Call(R_gpuvec_print, x_ptr, ndigits)
}

#' @useDynLib fmlr R_gpuvec_info
gpuvec_info = function(x_ptr)
{
  .Call(R_gpuvec_info, x_ptr)
}

#' @useDynLib fmlr R_gpuvec_fill_zero
gpuvec_fill_zero = function(x_ptr)
{
  .Call(R_gpuvec_fill_zero, x_ptr)
}

#' @useDynLib fmlr R_gpuvec_fill_val
gpuvec_fill_val = function(x_ptr, v)
{
  v = as.double(v)

  .Call(R_gpuvec_fill_val, x_ptr, v)
}

#' @useDynLib fmlr R_gpuvec_fill_linspace
gpuvec_fill_linspace = function(x_ptr, start, stop)
{
  start = as.double(start)
  stop = as.double(stop)

  .Call(R_gpuvec_fill_linspace, x_ptr, start, stop)
}

#' @useDynLib fmlr R_gpuvec_scale
gpuvec_scale = function(x_ptr, s)
{
  s = as.double(s)

  .Call(R_gpuvec_scale, x_ptr, s)
}

#' @useDynLib fmlr R_gpuvec_rev
gpuvec_rev = function(x_ptr)
{
  .Call(R_gpuvec_rev, x_ptr)
}

#' @useDynLib fmlr R_gpuvec_to_robj
gpuvec_to_robj = function(x_ptr)
{
  .Call(R_gpuvec_to_robj, x_ptr)
}

#' @useDynLib fmlr R_gpuvec_from_robj
gpuvec_from_robj = function(x_ptr, robj)
{
  # TODO check matrix type of robj
  if (!is.double(robj))
    storage.mode(robj) = "double"

  .Call(R_gpuvec_from_robj, x_ptr, robj)
}



# ------------------------------------------------------------------------------
# gpumat class methods
# ------------------------------------------------------------------------------

#' @useDynLib fmlr R_gpumat_init
gpumat_init = function(card, m, n, type)
{
  m = as.integer(m)
  n = as.integer(n)
  .Call(R_gpumat_init, card, m, n)
}

gpumat_nrows = function(x_ptr)
{
  gpumat_dim(x_ptr)[1]
}

gpumat_ncols = function(x_ptr)
{
  gpumat_dim(x_ptr)[2]
}

#' @useDynLib fmlr R_gpumat_dim
gpumat_dim = function(x_ptr)
{
  .Call(R_gpumat_dim, x_ptr)
}

#' @useDynLib fmlr R_gpumat_inherit
gpumat_inherit = function(x_ptr, data)
{
  if (!is.double(data))
    storage.mode(data) = "double"
  
  .Call(R_gpumat_inherit, x_ptr, data)
}

#' @useDynLib fmlr R_gpumat_resize
gpumat_resize = function(x_ptr, m, n)
{
  m = as.integer(m)
  n = as.integer(n)
  .Call(R_gpumat_resize, x_ptr, m, n)
}

#' @useDynLib fmlr R_gpumat_print
gpumat_print = function(x_ptr, ndigits)
{
  ndigits = min(as.integer(ndigits), 15L)
  
  .Call(R_gpumat_print, x_ptr, ndigits)
}

#' @useDynLib fmlr R_gpumat_info
gpumat_info = function(x_ptr)
{
  .Call(R_gpumat_info, x_ptr)
}

#' @useDynLib fmlr R_gpumat_fill_zero
gpumat_fill_zero = function(x_ptr)
{
  .Call(R_gpumat_fill_zero, x_ptr)
}

#' @useDynLib fmlr R_gpumat_fill_val
gpumat_fill_val = function(x_ptr, v)
{
  v = as.double(v)
  
  .Call(R_gpumat_fill_val, x_ptr, v)
}

#' @useDynLib fmlr R_gpumat_fill_linspace
gpumat_fill_linspace = function(x_ptr, start, stop)
{
  start = as.double(start)
  stop = as.double(stop)
  
  .Call(R_gpumat_fill_linspace, x_ptr, start, stop)
}

#' @useDynLib fmlr R_gpumat_fill_eye
gpumat_fill_eye = function(x_ptr)
{
  .Call(R_gpumat_fill_eye, x_ptr)
}

# TODO diag

#' @useDynLib fmlr R_gpumat_fill_runif
gpumat_fill_runif = function(x_ptr, seed, min, max)
{
  if (missing(seed))
    seed = -1L
  else
    seed = as.integer(seed)
  
  min = as.double(min)
  max = as.double(max)
  
  .Call(R_gpumat_fill_runif, x_ptr, seed, min, max)
}

#' @useDynLib fmlr R_gpumat_fill_rnorm
gpumat_fill_rnorm = function(x_ptr, seed, min, max)
{
  if (missing(seed))
    seed = -1L
  else
    seed = as.integer(seed)
  
  min = as.double(min)
  max = as.double(max)
  
  .Call(R_gpumat_fill_rnorm, x_ptr, seed, min, max)
}

#' @useDynLib fmlr R_gpumat_scale
gpumat_scale = function(x_ptr, s)
{
  s = as.double(s)
  
  .Call(R_gpumat_scale, x_ptr, s)
}

# #' @useDynLib fmlr R_gpumat_rev_rows
# gpumat_rev_rows = function(x_ptr)
# {
#   .Call(R_gpumat_rev_rows, x_ptr)
# }
# 
# #' @useDynLib fmlr R_gpumat_rev_cols
# gpumat_rev_cols = function(x_ptr)
# {
#   .Call(R_gpumat_rev_cols, x_ptr)
# }

#' @useDynLib fmlr R_gpumat_to_robj
gpumat_to_robj = function(x_ptr)
{
  .Call(R_gpumat_to_robj, x_ptr)
}

#' @useDynLib fmlr R_gpumat_from_robj
gpumat_from_robj = function(x_ptr, robj)
{
  # TODO check matrix type of robj
  if (!is.double(robj))
    storage.mode(robj) = "double"

  .Call(R_gpumat_from_robj, x_ptr, robj)
}



# ------------------------------------------------------------------------------
# linalg namespace
# ------------------------------------------------------------------------------

#' @useDynLib fmlr R_gpumat_linalg_crossprod
gpumat_linalg_crossprod = function(xpose, alpha, x_ptr, ret_ptr)
{
  xpose = as.logical(xpose)
  alpha = as.double(alpha)
  .Call(R_gpumat_linalg_crossprod, xpose, alpha, x_ptr, ret_ptr)
}
