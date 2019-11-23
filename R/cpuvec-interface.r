#' cpuvec class
#' 
#' Storage and methods for CPU vector data.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @rdname cpuvec-class
#' @name cpuvec-class
cpuvecR6 = R6::R6Class("cpuvec",
  public = list(
    #' @details
    #' Class initializer. See also \code{?cpuvec}.
    #' 
    #' @param size The length of the vector.
    #' @param type Storage type for the vector. Should be one of 'int', 'float', or 'double'.
    initialize = function(size=0, type="double")
    {
      private$x_ptr = cpuvec_init(size, type)
      private$type = type
    },
    
    #' @details
    #' Change the length of the vector object.
    #' 
    #' @param size The new length.
    resize = function(size)
    {
      cpuvec_resize(private$x_ptr, size)
      invisible(self)
    },
    #' @details
    #' Set the data in the cpuvec object to point to the array in 'data'. See
    #' also \code{?as_cpuvec}.
    #' 
    #' @param data R vector.
    set = function(data)
    {
      cpuvec_set(private$x_ptr, data)
      invisible(self)
    },
    
    #' @details
    #' Print one-line information about the vector.
    info = function()
    {
      cpuvec_info(private$x_ptr)
      invisible(self)
    },
    #' @details
    #' Print the data.
    #' 
    #' @param ndigits Number of decimal digits to print.
    print = function(ndigits=4)
    {
      cpuvec_print(private$x_ptr, ndigits)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with zero.
    fill_zero = function()
    {
      cpuvec_fill_zero(private$x_ptr)
      invisible(self)
    },
    #' @details
    #' Fill all entries with one.
    fill_one = function()
    {
      cpuvec_fill_one(private$x_ptr)
      invisible(self)
    },
    #' @details
    #' Fill all entries with supplied value.
    #' 
    #' @param v Value to set all entries to.
    fill_val = function(v)
    {
      cpuvec_fill_val(private$x_ptr, v)
      invisible(self)
    },
    #' @details
    #' Fill the vector (column-wise) with linearly-spaced values.
    #' 
    #' @param start,stop Beginning/end of the linear spacing.
    fill_linspace = function(start, stop)
    {
      cpuvec_fill_linspace(private$x_ptr, start, stop)
      invisible(self)
    },
    
    #' @details
    #' Scale all entries by the supplied value.
    #' 
    #' @param s Value to scale all entries by.
    scale = function(s)
    {
      cpuvec_scale(private$x_ptr, s)
      invisible(self)
    },
    #' @details
    #' Reverse rows.
    rev = function()
    {
      cpuvec_rev(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Returns length of the vector.
    size = function() cpuvec_size(private$x_ptr),
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$x_ptr,
    
    #' @details
    #' Returns an R vector containing a copy of the class data.
    to_robj = function() cpuvec_to_robj(private$x_ptr),
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_cpuvec}.
    #' 
    #' @param robj R vector.
    from_robj = function(robj)
    {
      cpuvec_from_robj(private$x_ptr, robj)
      invisible(self)
    }
  ),
  
  private = list(
    x_ptr = NULL,
    type = ""
  )
)



#' cpuvec
#' 
#' Constructor for cpuvec objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param size Length of the vector.
#' @param type Storage type for the vector. Should be one of 'int', 'float', or 'double'.
#' @return A cpuvec class object.
#' 
#' @seealso \code{\link{cpuvec-class}}
#' 
#' @export
cpuvec = function(size=0, type="double")
{
  cpuvecR6$new(size=size, type=type)
}



#' as_cpuvec
#' 
#' Convert an R vector to a cpumat object.
#' 
#' @param x R vector.
#' @param copy Should the R data be copied? If \code{FALSE}, be careful!
#' @return A cpuvec object.
#' 
#' @export
as_cpuvec = function(x, copy=TRUE)
{
  ret = cpuvec()
  
  if (isTRUE(copy))
    ret$from_robj(x)
  else
    ret$set(x)
  
  ret
}
