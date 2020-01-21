check_class_consistency = function(...)
{
  l = list(...)
  
  for (fun in fmlr_is_funs)
  {
    test = sapply(l, fun)
    if (any(test))
    {
      if (all(test))
        return(invisible(TRUE))
      else
        stop("inconsistent object usage")
    }
  }
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
