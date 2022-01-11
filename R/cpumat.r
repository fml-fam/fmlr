#' cpumat class
#' 
#' Storage and methods for CPU matrix data.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @rdname cpumat-class
#' @name cpumat-class
cpumatR6 = R6::R6Class("cpumat",
  public = list(
    #' @details
    #' Class initializer. See also \code{?cpumat}.
    #' @param nrows,ncols The dimension of the matrix.
    #' @param type Storage type for the matrix. Should be one of 'int', 'float', or 'double'.
    #' @useDynLib fmlr R_cpumat_init
    initialize = function(nrows=0, ncols=0, type="double")
    {
      type = match.arg(tolower(type), TYPES_STR)
      
      nrows = check_is_natnum(nrows)
      ncols = check_is_natnum(ncols)
      
      private$type_str = type
      private$type = type_str2int(type)
      private$x_ptr = .Call(R_cpumat_init, private$type, nrows, ncols)
    },
    
    
    
    #' @details
    #' Change the dimension of the matrix object.
    #' @param nrows,ncols The new dimension.
    #' @useDynLib fmlr R_cpumat_resize
    resize = function(nrows, ncols)
    {
      nrows = check_is_natnum(nrows)
      ncols = check_is_natnum(ncols)
      
      .Call(R_cpumat_resize, private$type, private$x_ptr, nrows, ncols)
      invisible(self)
    },
    
    
    
    #' @details
    #' Set the data in the cpumat object to point to the array in 'data'. See
    #' also \code{?as_cpumat}.
    #' @param data R matrix.
    #' @useDynLib fmlr R_cpumat_inherit
    inherit = function(data)
    {
      if (!is.matrix(data) && !float::is.float(data))
        stop("'data' must be a matrix")
      
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
      
      .Call(R_cpumat_inherit, type, private$x_ptr, rdata)
      invisible(self)
    },
    
    
    
    #' @details
    #' Duplicate the matrix in a deep copy.
    #' @useDynLib fmlr R_cpumat_dupe
    dupe = function()
    {
      ret_ptr = .Call(R_cpumat_dupe, private$type, private$x_ptr)
      
      tmp = private$x_ptr
      private$x_ptr = ret_ptr
      ret = self$clone()
      private$x_ptr = tmp
      
      ret
    },
    
    
    
    #' @details
    #' Print one-line information about the matrix.
    #' @useDynLib fmlr R_cpumat_info
    info = function()
    {
      .Call(R_cpumat_info, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    #' @useDynLib fmlr R_cpumat_print
    print = function(ndigits=4)
    {
      ndigits = min(as.integer(ndigits), 15L)
      
      .Call(R_cpumat_print, private$type, private$x_ptr, ndigits)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with zero.
    #' @useDynLib fmlr R_cpumat_fill_zero
    fill_zero = function()
    {
      .Call(R_cpumat_fill_zero, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    #' @useDynLib fmlr R_cpumat_fill_val
    fill_val = function(v)
    {
      v = check_is_number(v)
      
      .Call(R_cpumat_fill_val, private$type, private$x_ptr, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    #' @useDynLib fmlr R_cpumat_fill_linspace
    fill_linspace = function(start, stop)
    {
      if ((missing(start) && !missing(stop)) || (!missing(start) && missing(stop)))
        stop("must supply both 'start' and 'stop', or neither")
      
      if (!missing(start))
        start = check_is_number(start)
      else
        start = NULL
      if (!missing(stop))
        stop = check_is_number(stop)
      else
        stop = NULL
      
      .Call(R_cpumat_fill_linspace, private$type, private$x_ptr, start, stop)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill diagonal values to 1 and non-diagonal values to 0.
    #' @useDynLib fmlr R_cpumat_fill_eye
    fill_eye = function()
    {
      .Call(R_cpumat_fill_eye, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Set diagonal entries of the matrix to those in the vector. If the vector
    #' is smaller than the matrix diagonal, the vector will recycle until the
    #' matrix diagonal is filled.
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_cpumat_fill_diag
    fill_diag = function(v)
    {
      if (!is_cpuvec(v))
        v = as_cpuvec(v, copy=FALSE)
      
      check_type_consistency(self, v)
      
      .Call(R_cpumat_fill_diag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix with random unifmorm data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param min,max Parameters for the generator.
    #' @useDynLib fmlr R_cpumat_fill_runif
    fill_runif = function(seed, min=0, max=1)
    {
      if (missing(seed))
        seed = -1L
      
      seed = check_is_integer(seed)
      min = check_is_number(min)
      max = check_is_number(max)
      
      .Call(R_cpumat_fill_runif, private$type, private$x_ptr, seed, min, max)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix with random normal data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param mean,sd Parameters for the generator.
    #' @useDynLib fmlr R_cpumat_fill_rnorm
    fill_rnorm = function(seed, mean=0, sd=1)
    {
      if (missing(seed))
        seed = -1L
      
      seed = check_is_integer(seed)
      mean = check_is_number(mean)
      sd = check_is_number(sd)
      
      .Call(R_cpumat_fill_rnorm, private$type, private$x_ptr, seed, mean, sd)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get diagonal entries of the matrix.
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_cpumat_diag
    diag = function(v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a cpuvec object")
      
      check_type_consistency(self, v)
      
      .Call(R_cpumat_diag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Get anti-diagonal entries of the matrix.
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_cpumat_antidiag
    antidiag = function(v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a cpuvec object")
      
      check_type_consistency(self, v)
      
      .Call(R_cpumat_antidiag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    #' @useDynLib fmlr R_cpumat_scale
    scale = function(s)
    {
      s = check_is_number(s)
      
      .Call(R_cpumat_scale, private$type, private$x_ptr, s)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse rows.
    #' @useDynLib fmlr R_cpumat_rev_rows
    rev_rows = function()
    {
      .Call(R_cpumat_rev_rows, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse columns.
    #' @useDynLib fmlr R_cpumat_rev_cols
    rev_cols = function()
    {
      .Call(R_cpumat_rev_cols, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get element from the matrix.
    #' @param i,j Indices (0-based).
    #' @useDynLib fmlr R_cpumat_get
    get = function(i, j)
    {
      i = check_is_natnum(i)
      j = check_is_natnum(j)
      
      .Call(R_cpumat_get, private$type, private$x_ptr, i, j)
    },
    
    
    
    #' @details
    #' Set element of the matrix.
    #' @param i,j Indices (0-based).
    #' @param v Value.
    #' @useDynLib fmlr R_cpumat_set
    set = function(i, j, v)
    {
      i = check_is_natnum(i)
      j = check_is_natnum(j)
      v = check_is_number(v)
      
      .Call(R_cpumat_set, private$type, private$x_ptr, i, j, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get the specified row.
    #' @param i Index (0-based).
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_cpumat_get_row
    get_row = function(i, v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a cpuvec object")
      
      check_type_consistency(self, v)
      
      i = check_is_natnum(i)
      
      .Call(R_cpumat_get_row, private$type, private$x_ptr, i, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Get the specified column.
    #' @param j Index (0-based).
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_cpumat_get_col
    get_col = function(j, v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a cpuvec object")
      
      check_type_consistency(self, v)
      
      j = check_is_natnum(j)
      
      .Call(R_cpumat_get_col, private$type, private$x_ptr, j, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    #' @useDynLib fmlr R_cpumat_dim
    dim = function() .Call(R_cpumat_dim, private$type, private$x_ptr),
    
    #' @details
    #' Returns number of rows of the matrix.
    nrows = function() self$dim()[1],
    
    #' @details
    #' Returns number of columns of the matrix.
    ncols = function() self$dim()[2],
    
    
    
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
    #' Returns the integer code the class type, in this case CLASS_MAT.
    get_class = function() CLASS_MAT,
    
    
    
    #' @details
    #' Returns an R matrix containing a copy of the class data.
    #' @useDynLib fmlr R_cpumat_to_robj
    to_robj = function()
    {
      ret = .Call(R_cpumat_to_robj, private$type, private$x_ptr)
      if (private$type == TYPE_FLOAT)
        ret = float::float32(ret)
      
      ret
    },
    
    
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_cpumat}.
    #' @param robj R matrix.
    #' @useDynLib fmlr R_cpumat_from_robj
    from_robj = function(robj)
    {
      if (!is.matrix(robj) && !float::is.float(robj))
        stop("'robj' must be a matrix")
      
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
      
      .Call(R_cpumat_from_robj, private$type, private$x_ptr, robj_type, rdata)
      invisible(self)
    }
  ),
  
  
  
  private = list(
    x_ptr = NULL,
    type = -1L,
    type_str = ""
  )
)



#' cpumat
#' 
#' Constructor for cpumat objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param nrows,ncols The dimensions of the matrix.
#' @param type Storage type for the matrix. Should be one of 'int', 'float', or 'double'.
#' @return A cpumat class object.
#' 
#' @seealso \code{\link{cpumat-class}}
#' 
#' @export
cpumat = function(nrows=0, ncols=0, type="double")
{
  cpumatR6$new(nrows=nrows, ncols=ncols, type=type)
}



#' as_cpumat
#' 
#' Convert an R matrix to a cpumat object.
#' 
#' @param x R matrix.
#' @param copy Should the R data be copied? If \code{FALSE}, be careful!
#' @return A cpumat object.
#' 
#' @export
as_cpumat = function(x, copy=TRUE)
{
  ret = cpumat()
  
  if (isTRUE(copy))
    ret$from_robj(x)
  else
    ret$inherit(x)
  
  ret
}
