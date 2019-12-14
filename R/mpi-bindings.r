# ------------------------------------------------------------------------------
# grid class methods
# ------------------------------------------------------------------------------

#' @useDynLib fmlr R_grid_init
grid_init = function(gridtype)
{
  gridtype = as.integer(gridtype)
  .Call(R_grid_init, gridtype)
}

#' @useDynLib fmlr R_grid_set
grid_set = function(g_ptr, blacs_context)
{
  blacs_context = as.integer(blacs_context)
  .Call(R_grid_set, g_ptr, blacs_context)
  invisible()
}

#' @useDynLib fmlr R_grid_exit
grid_exit = function(g_ptr)
{
  .Call(R_grid_exit, g_ptr)
  invisible()
}

#' @useDynLib fmlr R_grid_finalize
grid_finalize = function(g_ptr, mpi_continue)
{
  mpi_continue = as.logical(mpi_continue)
  .Call(R_grid_finalize, g_ptr, mpi_continue)
  invisible()
}

#' @useDynLib fmlr R_grid_rank0
grid_rank0 = function(g_ptr)
{
  .Call(R_grid_rank0, g_ptr)
  invisible()
}

#' @useDynLib fmlr R_grid_ingrid
grid_ingrid = function(g_ptr)
{
  .Call(R_grid_ingrid, g_ptr)
  invisible()
}

#' @useDynLib fmlr R_grid_barrier
grid_barrier = function(g_ptr, scope)
{
  .Call(R_grid_barrier, g_ptr, scope)
  invisible()
}

#' @useDynLib fmlr R_grid_info
grid_info = function(g_ptr)
{
  .Call(R_grid_info, g_ptr)
  invisible()
}

#' @useDynLib fmlr R_grid_ictxt
grid_ictxt = function(g_ptr)
{
  .Call(R_grid_ictxt, g_ptr)
}

#' @useDynLib fmlr R_grid_nprocs
grid_nprocs = function(g_ptr)
{
  .Call(R_grid_nprocs, g_ptr)
}

#' @useDynLib fmlr R_grid_nprow
grid_nprow = function(g_ptr)
{
  .Call(R_grid_nprow, g_ptr)
}

#' @useDynLib fmlr R_grid_npcol
grid_npcol = function(g_ptr)
{
  .Call(R_grid_npcol, g_ptr)
}

#' @useDynLib fmlr R_grid_myrow
grid_myrow = function(g_ptr)
{
  .Call(R_grid_myrow, g_ptr)
}

#' @useDynLib fmlr R_grid_mycol
grid_mycol = function(g_ptr)
{
  .Call(R_grid_mycol, g_ptr)
}

#' @useDynLib fmlr R_grid_valid_grid
grid_valid_grid = function(g_ptr)
{
  .Call(R_grid_valid_grid, g_ptr)
}



# ------------------------------------------------------------------------------
# mpimat class methods
# ------------------------------------------------------------------------------

#' @useDynLib fmlr R_mpimat_init
mpimat_init = function(grid, m, n, mb, nb, type)
{
  m = as.integer(m)
  n = as.integer(n)
  
  mb = as.integer(mb)
  nb = as.integer(nb)
  
  .Call(R_mpimat_init, grid, m, n, mb, nb)
}

#' @useDynLib fmlr R_mpimat_dim
mpimat_dim = function(x_ptr)
{
  .Call(R_mpimat_dim, x_ptr)
}

#' @useDynLib fmlr R_mpimat_ldim
mpimat_ldim = function(x_ptr)
{
  .Call(R_mpimat_ldim, x_ptr)
}

#' @useDynLib fmlr R_mpimat_bfdim
mpimat_bfdim = function(x_ptr)
{
  .Call(R_mpimat_bfdim, x_ptr)
}

#' @useDynLib fmlr R_mpimat_inherit
mpimat_inherit = function(x_ptr, data)
{
  if (!is.double(data))
    storage.mode(data) = "double"
  
  .Call(R_mpimat_inherit, x_ptr, data)
}

#' @useDynLib fmlr R_mpimat_resize
mpimat_resize = function(x_ptr, m, n)
{
  m = as.integer(m)
  n = as.integer(n)
  .Call(R_mpimat_resize, x_ptr, m, n)
}

#' @useDynLib fmlr R_mpimat_print
mpimat_print = function(x_ptr, ndigits)
{
  ndigits = min(as.integer(ndigits), 15L)
  
  .Call(R_mpimat_print, x_ptr, ndigits)
}

#' @useDynLib fmlr R_mpimat_info
mpimat_info = function(x_ptr)
{
  .Call(R_mpimat_info, x_ptr)
}

#' @useDynLib fmlr R_mpimat_fill_zero
mpimat_fill_zero = function(x_ptr)
{
  .Call(R_mpimat_fill_zero, x_ptr)
}

#' @useDynLib fmlr R_mpimat_fill_val
mpimat_fill_val = function(x_ptr, v)
{
  v = as.double(v)
  
  .Call(R_mpimat_fill_val, x_ptr, v)
}

#' @useDynLib fmlr R_mpimat_fill_linspace
mpimat_fill_linspace = function(x_ptr, start, stop)
{
  start = as.double(start)
  stop = as.double(stop)
  
  .Call(R_mpimat_fill_linspace, x_ptr, start, stop)
}

#' @useDynLib fmlr R_mpimat_fill_eye
mpimat_fill_eye = function(x_ptr)
{
  .Call(R_mpimat_fill_eye, x_ptr)
}

# TODO diag

#' @useDynLib fmlr R_mpimat_fill_runif
mpimat_fill_runif = function(x_ptr, seed, min, max)
{
  if (missing(seed))
    seed = -1L
  else
    seed = as.integer(seed)
  
  min = as.double(min)
  max = as.double(max)
  
  .Call(R_mpimat_fill_runif, x_ptr, seed, min, max)
}

#' @useDynLib fmlr R_mpimat_fill_rnorm
mpimat_fill_rnorm = function(x_ptr, seed, min, max)
{
  if (missing(seed))
    seed = -1L
  else
    seed = as.integer(seed)
  
  min = as.double(min)
  max = as.double(max)
  
  .Call(R_mpimat_fill_rnorm, x_ptr, seed, min, max)
}

#' @useDynLib fmlr R_mpimat_scale
mpimat_scale = function(x_ptr, s)
{
  s = as.double(s)
  
  .Call(R_mpimat_scale, x_ptr, s)
}

# #' @useDynLib fmlr R_mpimat_rev_rows
# mpimat_rev_rows = function(x_ptr)
# {
#   .Call(R_mpimat_rev_rows, x_ptr)
# }
# 
# #' @useDynLib fmlr R_mpimat_rev_cols
# mpimat_rev_cols = function(x_ptr)
# {
#   .Call(R_mpimat_rev_cols, x_ptr)
# }

#' @useDynLib fmlr R_mpimat_to_robj
mpimat_to_robj = function(x_ptr)
{
  .Call(R_mpimat_to_robj, x_ptr)
}

#' @useDynLib fmlr R_mpimat_from_robj
mpimat_from_robj = function(x_ptr, robj)
{
  # TODO check matrix type of robj
  if (!is.double(robj))
    storage.mode(robj) = "double"

  .Call(R_mpimat_from_robj, x_ptr, robj)
}



# ------------------------------------------------------------------------------
# linalg namespace
# ------------------------------------------------------------------------------

#' @useDynLib fmlr R_mpimat_linalg_crossprod
mpimat_linalg_crossprod = function(xpose, alpha, x_ptr, ret_ptr)
{
  xpose = as.logical(xpose)
  alpha = as.double(alpha)
  .Call(R_mpimat_linalg_crossprod, xpose, alpha, x_ptr, ret_ptr)
}
