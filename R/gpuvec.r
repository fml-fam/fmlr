#' gpuvec class
#' 
#' Storage and methods for GPU vector data.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @rdname gpuvec-class
#' @name gpuvec-class
gpuvecR6 = R6::R6Class("gpuvec",
  public = list(
    #' @details
    #' Class initializer. See also \code{?gpuvec}.
    #' @param card A GPU card object; the return of \code{card()}. See \code{?card}.
    #' @param size The length of the vector.
    #' @param type Storage type for the vector. Should be one of 'int', 'float', or 'double'.
    #' @useDynLib fmlr R_gpuvec_init
    initialize = function(card, size=0, type="double")
    {
      check_is_card(card)
      
      size = as.integer(size)
      
      private$card = card
      private$x_ptr = .Call(R_gpuvec_init, card$data_ptr(), size, type)
      private$type = type
    },
    
    
    
    #' @details
    #' Change the length of the vector object.
    #' @param size The new length.
    #' @useDynLib fmlr R_gpuvec_resize
    resize = function(size)
    {
      size = as.integer(size)
      .Call(R_gpuvec_resize, private$x_ptr, size)
      invisible(self)
    },
    
    
    
    #' @details
    #' Set the data in the gpuvec object to point to the array in 'data'. See
    #' also \code{?as_gpuvec}.
    #' @param data R vector.
    #' @useDynLib fmlr R_gpuvec_inherit
    inherit = function(data)
    {
      if (!is.double(data))
        storage.mode(data) = "double"

      .Call(R_gpuvec_inherit, private$x_ptr, data)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print one-line information about the vector.
    #' @useDynLib fmlr R_gpuvec_info
    info = function()
    {
      .Call(R_gpuvec_info, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    #' @useDynLib fmlr R_gpuvec_print
    print = function(ndigits=4)
    {
      ndigits = min(as.integer(ndigits), 15L)

      .Call(R_gpuvec_print, private$x_ptr, ndigits)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with zero.
    #' @useDynLib fmlr R_gpuvec_fill_zero
    fill_zero = function()
    {
      .Call(R_gpuvec_fill_zero, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    #' @useDynLib fmlr R_gpuvec_fill_val
    fill_val = function(v)
    {
      v = as.double(v)
      
      .Call(R_gpuvec_fill_val, private$x_ptr, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the vector (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    #' @useDynLib fmlr R_gpuvec_fill_linspace
    fill_linspace = function(start, stop)
    {
      start = as.double(start)
      stop = as.double(stop)

      .Call(R_gpuvec_fill_linspace, private$x_ptr, start, stop)
      invisible(self)
    },
    
    
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    #' @useDynLib fmlr R_gpuvec_scale
    scale = function(s)
    {
      s = as.double(s)

      .Call(R_gpuvec_scale, private$x_ptr, s)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse rows.
    #' @useDynLib fmlr R_gpuvec_rev
    rev = function()
    {
      .Call(R_gpuvec_rev, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Returns length of the vector.
    #' @useDynLib fmlr R_gpuvec_size
    size = function() .Call(R_gpuvec_size, private$x_ptr),
    
    
    
    #' @details
    #' Returns the internal card object.
    get_card = function() private$card,
    
    
    
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$x_ptr,
    
    
    
    #' @details
    #' Returns an R vector containing a copy of the class data.
    #' @useDynLib fmlr R_gpuvec_to_robj
    to_robj = function() .Call(R_gpuvec_to_robj, private$x_ptr),
    
    
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_gpuvec}.
    #' @param robj R vector.
    #' @useDynLib fmlr R_gpuvec_from_robj
    from_robj = function(robj)
    {
      # TODO check matrix type of robj
      if (!is.double(robj))
        storage.mode(robj) = "double"

      .Call(R_gpuvec_from_robj, private$x_ptr, robj)
      invisible(self)
    }
  ),
  
  
  
  private = list(
    card = NULL,
    x_ptr = NULL,
    type = ""
  )
)



#' gpuvec
#' 
#' Constructor for gpuvec objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param size Length of the vector.
#' @param type Storage type for the vector. Should be one of 'int', 'float', or 'double'.
#' @return A gpuvec class object.
#' 
#' @seealso \code{\link{gpuvec-class}}
#' 
#' @export
gpuvec = function(card, size=0, type="double")
{
  gpuvecR6$new(card=card, size=size, type=type)
}



# #' as_gpuvec
# #' 
# #' Convert an R vector to a cpumat object.
# #' 
# #' @param x R vector.
# #' @param copy Should the R data be copied? If \code{FALSE}, be careful!
# #' @return A gpuvec object.
# #' 
# #' @export
# as_gpuvec = function(x, copy=TRUE)
# {
#   ret = gpuvec()
# 
#   if (isTRUE(copy))
#     ret$from_robj(x)
#   else
#     ret$inherit(x)
# 
#   ret
# }
