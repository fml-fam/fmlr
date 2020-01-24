check_class_consistency = function(...)
{
  l = list(...)
  if (length(l) < 2)
    return(invisible(TRUE))
  
  for (fun in fmlr_is_funs)
  {
    test = sapply(l, fun)
    if (any(test))
    {
      if (all(test))
        return(invisible(TRUE))
      else
        stop("inconsistent object usage: can not mix backends")
    }
  }
}



check_type_consistency = function(...)
{
  l = list(...)
  if (length(l) < 2)
    return(invisible(TRUE))
  
  gt = function(x) x$get_type()
  test = sapply(l, gt)
  
  if (sum(diff(test)) == 0)
    return(invisible(TRUE))
  else
    stop("inconsistent type usage: can not mix fundamental types")
}



check_is_card = function(x)
{
  if (!is_card(x) || !isTRUE(x$valid_card()))
    stop("invalid card object")
}



check_is_grid = function(x)
{
  if (!is_grid(x) || !isTRUE(x$valid_grid()))
    stop("invalid grid object")
}



check_index = function(i, len)
{
  if (length(i) != 1 || is.na(i))
    stop("bad indices - should be a single integer")
  
  if (i < 0 || i >= len)
    stop("index out of bounds")
  
  invisible(TRUE)
}

check_indices = function(i, j, m, n)
{
  check_index(i, m)
  check_index(j, n)
}
