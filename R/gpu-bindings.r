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

#' @useDynLib fmlr R_gpuvec_set
gpuvec_set = function(x_ptr, data)
{
  if (!is.double(data))
    storage.mode(data) = "double"

  .Call(R_gpuvec_set, x_ptr, data)
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

#' @useDynLib fmlr R_gpuvec_fill_one
gpuvec_fill_one = function(x_ptr)
{
  .Call(R_gpuvec_fill_one, x_ptr)
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
