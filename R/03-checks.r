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
