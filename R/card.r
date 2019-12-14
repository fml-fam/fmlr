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
    #' @param id GPU id number.
    #' @useDynLib fmlr R_card_init
    initialize = function(id=0)
    {
      id = as.integer(id)
      private$c_ptr = .Call(R_card_init, id)
    },
    
    
    
    #' @details
    #' Set card to a different GPU.
    #' @param id GPU id number.
    #' @useDynLib fmlr R_card_set
    set = function(id)
    {
      id = as.integer(id)
      .Call(R_card_set, private$c_ptr, id)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print one-line information about the object.
    #' @useDynLib fmlr R_card_info
    info = function()
    {
      .Call(R_card_info, private$c_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print one-line information about the object.
    print = function()
    {
      card_info(private$c_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Returns GPU id number.
    #' @useDynLib fmlr R_card_get_id
    get_id = function() .Call(R_card_get_id, private$c_ptr),
    
    
    
    #' @details
    #' Returns whether or not the card object is valid.
    #' @useDynLib fmlr R_card_valid_card
    valid_card = function() .Call(R_card_valid_card, private$c_ptr),
    
    
    
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
