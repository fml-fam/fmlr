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
      type = match.arg(tolower(type), TYPES_STR)
      check_is_card(card)
      
      size = as.integer(size)
      
      private$card = card
      private$type_str = type
      private$type = type_str2int(type)
      private$x_ptr = .Call(R_gpuvec_init, private$type, card$data_ptr(), size, type)
    },
    
    
    
    #' @details
    #' Change the length of the vector object.
    #' @param size The new length.
    #' @useDynLib fmlr R_gpuvec_resize
    resize = function(size)
    {
      size = as.integer(size)
      .Call(R_gpuvec_resize, private$type, private$x_ptr, size)
      invisible(self)
    },
    
    
    
    #' @details
    #' Duplicate the vector in a deep copy.
    #' @useDynLib fmlr R_gpuvec_dupe
    dupe = function()
    {
      ret_ptr = .Call(R_gpuvec_dupe, private$type, private$x_ptr)
      
      tmp = private$x_ptr
      private$x_ptr = ret_ptr
      ret = self$clone()
      private$x_ptr = tmp
      
      ret
    },
    
    
    
    #' @details
    #' Print one-line information about the vector.
    #' @useDynLib fmlr R_gpuvec_info
    info = function()
    {
      .Call(R_gpuvec_info, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    #' @useDynLib fmlr R_gpuvec_print
    print = function(ndigits=4)
    {
      ndigits = min(as.integer(ndigits), 15L)

      .Call(R_gpuvec_print, private$type, private$x_ptr, ndigits)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with zero.
    #' @useDynLib fmlr R_gpuvec_fill_zero
    fill_zero = function()
    {
      .Call(R_gpuvec_fill_zero, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    #' @useDynLib fmlr R_gpuvec_fill_val
    fill_val = function(v)
    {
      v = as.double(v)
      
      .Call(R_gpuvec_fill_val, private$type, private$x_ptr, v)
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

      .Call(R_gpuvec_fill_linspace, private$type, private$x_ptr, start, stop)
      invisible(self)
    },
    
    
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    #' @useDynLib fmlr R_gpuvec_scale
    scale = function(s)
    {
      s = as.double(s)

      .Call(R_gpuvec_scale, private$type, private$x_ptr, s)
      invisible(self)
    },
    
    
    
    #' @details
    #' Exponentiate all entries by the supplied value.
    #' @param p Value to raise all entries to.
    #' @useDynLib fmlr R_gpuvec_pow
    pow = function(s)
    {
      s = as.double(s)
      
      .Call(R_gpuvec_pow, private$type, private$x_ptr, s)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse rows.
    #' @useDynLib fmlr R_gpuvec_rev
    rev = function()
    {
      .Call(R_gpuvec_rev, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Sum the vector.
    #' @return Returns the sum.
    #' @useDynLib fmlr R_gpuvec_sum
    sum = function()
    {
      .Call(R_gpuvec_sum, private$type, private$x_ptr)
    },
    
    
    
    #' @details
    #' Finds the minimum value of the vector.
    #' @return Returns the min.
    #' @useDynLib fmlr R_gpuvec_min
    min = function()
    {
      .Call(R_gpuvec_min, private$type, private$x_ptr)
    },
    
    
    
    #' @details
    #' Finds the maximum value of the vector.
    #' @return Returns the max.
    #' @useDynLib fmlr R_gpuvec_max
    max = function()
    {
      .Call(R_gpuvec_max, private$type, private$x_ptr)
    },
    
    
    
    #' @details
    #' Get element from the vector.
    #' @param i Index (0-based).
    #' @useDynLib fmlr R_gpuvec_get
    get = function(i)
    {
      i = check_is_natnum(i)
      .Call(R_gpuvec_get, private$type, private$x_ptr, i)
    },
    
    
    
    #' @details
    #' Set element of the vector.
    #' @param i Index (0-based).
    #' @param v Value.
    #' @useDynLib fmlr R_gpuvec_set
    set = function(i, v)
    {
      i = check_is_natnum(i)
      v = check_is_number(v)
      .Call(R_gpuvec_set, private$type, private$x_ptr, i, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Returns length of the vector.
    #' @useDynLib fmlr R_gpuvec_size
    size = function() .Call(R_gpuvec_size, private$type, private$x_ptr),
    
    
    
    #' @details
    #' Returns the internal card object.
    get_card = function() private$card,
    
    
    
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
    #' Returns the integer code the class type, in this case CLASS_VEC.
    get_class = function() CLASS_VEC,
    
    
    
    #' @details
    #' Returns an R vector containing a copy of the class data.
    #' @useDynLib fmlr R_gpuvec_to_robj
    to_robj = function()
    {
      ret = .Call(R_gpuvec_to_robj, private$type, private$x_ptr)
      if (private$type == TYPE_FLOAT)
        ret = float::float32(ret)
      
      ret
    },
    
    
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_gpuvec}.
    #' @param robj R vector.
    #' @useDynLib fmlr R_gpuvec_from_robj
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
      
      .Call(R_gpuvec_from_robj, private$type, private$x_ptr, robj_type, rdata)
      invisible(self)
    }
  ),
  
  
  
  private = list(
    card = NULL,
    x_ptr = NULL,
    type = -1L,
    type_str = ""
  )
)



#' gpuvec
#' 
#' Constructor for gpuvec objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param card A GPU card object; the return of \code{card()}. See \code{?card}.
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



#' as_gpuvec
#' 
#' Convert an R vector to a gpuvec object.
#' 
#' @param card A GPU card object; the return of \code{card()}. See \code{?card}.
#' @param x R vector.
#' @return A gpuvec object.
#' 
#' @export
as_gpuvec = function(card, x)
{
  ret = gpuvec(card)
  ret$from_robj(x)
  ret
}
