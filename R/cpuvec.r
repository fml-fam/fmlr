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
    #' @param size The length of the vector.
    #' @param type Storage type for the vector. Should be one of 'int', 'float', or 'double'.
    #' @useDynLib fmlr R_cpuvec_init
    initialize = function(size=0, type="double")
    {
      type = match.arg(tolower(type), TYPES_STR)
      
      size = as.integer(size)
      
      private$type_str = type
      private$type = type_str2int(type)
      private$x_ptr = .Call(R_cpuvec_init, private$type, size)
    },
    
    
    
    #' @details
    #' Change the length of the vector object.
    #' @param size The new length.
    #' @useDynLib fmlr R_cpuvec_resize
    resize = function(size)
    {
      size = as.integer(size)
      .Call(R_cpuvec_resize, private$type, private$x_ptr, size)
      invisible(self)
    },
    
    
    
    #' @details
    #' Set the data in the cpuvec object to point to the array in 'data'. See
    #' also \code{?as_cpuvec}.
    #' @param data R vector.
    #' @useDynLib fmlr R_cpuvec_inherit
    inherit = function(data)
    {
      if (!is.vector(data) && !float::is.float(data))
        stop("'data' must be a vector")
      
      if (float::is.float(data) && private$type == TYPE_FLOAT)
      {
        type = TYPE_FLOAT
        rdata = data@Data
      }
      else if (is.integer(data) && private$type == TYPE_INT)
      {
        type = TYPE_INT
        rdata = data
      }
      else if (is.double(data) && private$type == TYPE_DOUBLE)
      {
        type = TYPE_DOUBLE
        rdata = data
      }
      else
        stop("can not mix fundamental types with inherit()")
      
      .Call(R_cpuvec_inherit, type, private$x_ptr, rdata)
      invisible(self)
    },
    
    
    
    #' @details
    #' Duplicate the vector in a deep copy.
    #' @useDynLib fmlr R_cpuvec_dupe
    dupe = function()
    {
      ret_ptr = .Call(R_cpuvec_dupe, private$type, private$x_ptr)
      
      tmp = private$x_ptr
      private$x_ptr = ret_ptr
      ret = self$clone()
      private$x_ptr = tmp
      
      ret
    },
    
    
    
    #' @details
    #' Print one-line information about the vector.
    #' @useDynLib fmlr R_cpuvec_info
    info = function()
    {
      .Call(R_cpuvec_info, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    #' @useDynLib fmlr R_cpuvec_print
    print = function(ndigits=4)
    {
      ndigits = min(as.integer(ndigits), 15L)
      
      .Call(R_cpuvec_print, private$type, private$x_ptr, ndigits)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with zero.
    #' @useDynLib fmlr R_cpuvec_fill_zero
    fill_zero = function()
    {
      .Call(R_cpuvec_fill_zero, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    #' @useDynLib fmlr R_cpuvec_fill_val
    fill_val = function(v)
    {
      v = as.double(v)
      
      .Call(R_cpuvec_fill_val, private$type, private$x_ptr, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the vector (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    #' @useDynLib fmlr R_cpuvec_fill_linspace
    fill_linspace = function(start, stop)
    {
      start = as.double(start)
      stop = as.double(stop)
      
      .Call(R_cpuvec_fill_linspace, private$type, private$x_ptr, start, stop)
      invisible(self)
    },
    
    
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    #' @useDynLib fmlr R_cpuvec_scale
    scale = function(s)
    {
      s = as.double(s)
      
      .Call(R_cpuvec_scale, private$type, private$x_ptr, s)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse rows.
    #' @useDynLib fmlr R_cpuvec_rev
    rev = function()
    {
      .Call(R_cpuvec_rev, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Sum the vector.
    #' @return Returns the sum.
    #' @useDynLib fmlr R_cpuvec_sum
    sum = function()
    {
      .Call(R_cpuvec_sum, private$type, private$x_ptr)
    },
    
    
    
    #' @details
    #' Get element from the vector.
    #' @param i Index (0-based).
    #' @useDynLib fmlr R_cpuvec_get
    get = function(i)
    {
      i = check_is_natnum(i)
      .Call(R_cpuvec_get, private$type, private$x_ptr, i)
    },
    
    
    
    #' @details
    #' Set element of the vector.
    #' @param i Index (0-based).
    #' @param v Value.
    #' @useDynLib fmlr R_cpuvec_set
    set = function(i, v)
    {
      i = check_is_natnum(i)
      v = check_is_number(v)
      .Call(R_cpuvec_set, private$type, private$x_ptr, i, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Returns length of the vector.
    #' @useDynLib fmlr R_cpuvec_size
    size = function() .Call(R_cpuvec_size, private$type, private$x_ptr),
    
    
    
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$x_ptr,
    
    #' @details
    #' Returns the integer code for the underlying storage type. For developers only.
    get_type = function() private$type,
    
    #' @details
    #' Returns the string code for the underlying storage type. For developers only.
    get_type_str = function() private$type_str,
    
    
    
    #' @details
    #' Returns an R vector containing a copy of the class data.
    #' @useDynLib fmlr R_cpuvec_to_robj
    to_robj = function()
    {
      ret = .Call(R_cpuvec_to_robj, private$type, private$x_ptr)
      if (private$type == TYPE_FLOAT)
        ret = float::float32(ret)
      
      ret
    },
    
    
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_cpuvec}.
    #' @param robj R vector.
    #' @useDynLib fmlr R_cpuvec_from_robj
    from_robj = function(robj)
    {
      if (!is.vector(robj) && !float::is.float(robj))
        stop("'robj' must be a vector")
      
      if (float::is.float(robj))
      {
        robj_type = TYPE_FLOAT
        rdata = robj@Data
      }
      else if (is.integer(robj))
      {
        robj_type = TYPE_INT
        rdata = robj
      }
      else if (is.double(robj))
      {
        robj_type = TYPE_DOUBLE
        rdata = robj
      }
      else
        stop("bad fundamental type")
      
      .Call(R_cpuvec_from_robj, private$type, private$x_ptr, robj_type, rdata)
      invisible(self)
    }
  ),
  
  
  
  private = list(
    x_ptr = NULL,
    type = -1L,
    type_str = ""
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
  x_type = type_robj2str(x)
  ret = cpuvec(type=x_type)
  
  if (isTRUE(copy))
    ret$from_robj(x)
  else
    ret$inherit(x)
  
  ret
}
