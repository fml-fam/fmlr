#' card class
#' 
#' Storage and methods for GPU card data.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @rdname gpu-card-class
#' @name gpu-card-class
cardR6 = R6::R6Class("card",
  public = list(
    #' @details
    #' Class initializer.
    #' 
    #' @param id GPU id number.
    initialize = function(id=0)
    {
      private$c_ptr = card_init(id)
    },
    
    #' @details
    #' Set card to a different GPU.
    #' @param id GPU id number.
    set = function(id)
    {
      card_set(private$c_ptr, id)
      invisible(self)
    },
    
    #' @details
    #' Print one-line information about the matrix.
    info = function()
    {
      card_info(private$c_ptr)
      invisible(self)
    },
    #' @details
    #' Print the data.
    #' 
    #' @param ndigits Number of decimal digits to print.
    print = function(ndigits=4)
    {
      card_info(private$c_ptr)
      invisible(self)
    },
    
    #' @details
    #' Returns GPU id number.
    get_id = function() card_get_id(private$c_ptr),
    #' @details
    #' Returns whether or not the card object is valid.
    valid_card = function() card_valid_card(private$c_ptr),
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$c_ptr
  ),
  
  private = list(
    c_ptr = NULL
  )
)



#' card
#' 
#' Constructor for GPU card objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param id GPU id number.
#' @return A card class object.
#' 
#' @export
card = function(id=0)
{
  cardR6$new(id=id)
}
