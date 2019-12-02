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
    initialize = function(card, size=0, type="double")
    {
      private$card = card
      private$x_ptr = gpuvec_init(card$data_ptr(), size, type)
      private$type = type
    },
    
    #' @details
    #' Change the length of the vector object.
    #' @param size The new length.
    resize = function(size)
    {
      gpuvec_resize(private$x_ptr, size)
      invisible(self)
    },
    
    #' @details
    #' Set the data in the gpuvec object to point to the array in 'data'. See
    #' also \code{?as_gpuvec}.
    #' @param data R vector.
    set = function(data)
    {
      gpuvec_set(private$x_ptr, data)
      invisible(self)
    },
    
    #' @details
    #' Print one-line information about the vector.
    info = function()
    {
      gpuvec_info(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    print = function(ndigits=4)
    {
      gpuvec_print(private$x_ptr, ndigits)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with zero.
    fill_zero = function()
    {
      gpuvec_fill_zero(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with one.
    fill_one = function()
    {
      gpuvec_fill_one(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    fill_val = function(v)
    {
      gpuvec_fill_val(private$x_ptr, v)
      invisible(self)
    },
    
    #' @details
    #' Fill the vector (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    fill_linspace = function(start, stop)
    {
      gpuvec_fill_linspace(private$x_ptr, start, stop)
      invisible(self)
    },
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    scale = function(s)
    {
      gpuvec_scale(private$x_ptr, s)
      invisible(self)
    },
    
    #' @details
    #' Reverse rows.
    rev = function()
    {
      gpuvec_rev(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Returns length of the vector.
    size = function() gpuvec_size(private$x_ptr),
    
    #' @details
    #' Returns the internal card object.
    get_card = function() private$card,
    
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$x_ptr,
    
    #' @details
    #' Returns an R vector containing a copy of the class data.
    to_robj = function() gpuvec_to_robj(private$x_ptr),
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_gpuvec}.
    #' @param robj R vector.
    from_robj = function(robj)
    {
      gpuvec_from_robj(private$x_ptr, robj)
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
#     ret$set(x)
# 
#   ret
# }
