#' @useDynLib fmlr R_card_init
card_init = function(id=0)
{
  id = as.integer(id)
  .Call(R_card_init, id)
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
