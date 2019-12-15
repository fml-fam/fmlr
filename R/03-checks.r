check_is_card = function(x)
{
  if (!is_card(x) || !isTRUE(x$valid_card()))
    stop("invalid card object")
}
