#' gpumat class
#' 
#' Storage and methods for GPU matrix data.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @rdname gpumat-class
#' @name gpumat-class
gpumatR6 = R6::R6Class("gpumat",
  public = list(
    #' @details
    #' Class initializer. See also \code{?gpumat}.
    #' @param card A GPU card object; the return of \code{card()}. See \code{?card}.
    #' @param nrows,ncols The dimension of the matrix.
    #' @param type Storage type for the matrix. Should be one of 'int', 'float', or 'double'.
    #' @useDynLib fmlr R_gpumat_init
    initialize = function(card, nrows=0, ncols=0, type="double")
    {
      type = match.arg(tolower(type), TYPES_STR)
      check_is_card(card)
      
      nrows = check_is_natnum(nrows)
      ncols = check_is_natnum(ncols)
      
      private$card = card
      private$type_str = type
      private$type = type_str2int(type)
      private$x_ptr = .Call(R_gpumat_init, private$type, card$data_ptr(), nrows, ncols, type)
    },
    
    
    
    #' @details
    #' Change the dimension of the matrix object.
    #' @param nrows,ncols The new dimension.
    #' @useDynLib fmlr R_gpumat_resize
    resize = function(nrows, ncols)
    {
      nrows = check_is_natnum(nrows)
      ncols = check_is_natnum(ncols)
      
      .Call(R_gpumat_resize, private$type, private$x_ptr, nrows, ncols)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print one-line information about the matrix.
    #' @useDynLib fmlr R_gpumat_info
    info = function()
    {
      .Call(R_gpumat_info, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Duplicate the matrix in a deep copy.
    #' @useDynLib fmlr R_gpumat_dupe
    dupe = function()
    {
      ret_ptr = .Call(R_gpumat_dupe, private$type, private$x_ptr)
      
      tmp = private$x_ptr
      private$x_ptr = ret_ptr
      ret = self$clone()
      private$x_ptr = tmp
      
      ret
    },
    
    
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    #' @useDynLib fmlr R_gpumat_print
    print = function(ndigits=4)
    {
      ndigits = min(as.integer(ndigits), 15L)
      
      .Call(R_gpumat_print, private$type, private$x_ptr, ndigits)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with zero.
    #' @useDynLib fmlr R_gpumat_fill_zero
    fill_zero = function()
    {
      .Call(R_gpumat_fill_zero, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    #' @useDynLib fmlr R_gpumat_fill_val
    fill_val = function(v)
    {
      v = check_is_number(v)
      
      .Call(R_gpumat_fill_val, private$type, private$x_ptr, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    #' @useDynLib fmlr R_gpumat_fill_linspace
    fill_linspace = function(start, stop)
    {
      start = check_is_number(start)
      stop = check_is_number(stop)
      
      .Call(R_gpumat_fill_linspace, private$type, private$x_ptr, start, stop)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill diagonal values to 1 and non-diagonal values to 0.
    #' @useDynLib fmlr R_gpumat_fill_eye
    fill_eye = function()
    {
      .Call(R_gpumat_fill_eye, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Set diagonal entries of the matrix to those in the vector. If the vector
    #' is smaller than the matrix diagonal, the vector will recycle until the
    #' matrix diagonal is filled.
    #' @param v A gpuvec object.
    #' @useDynLib fmlr R_gpumat_fill_diag
    fill_diag = function(v)
    {
      if (!is_gpuvec(v))
        v = as_gpuvec(v, copy=FALSE)
      
      check_type_consistency(self, v)
      
      .Call(R_gpumat_fill_diag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix with random unifmorm data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param min,max Parameters for the generator.
    #' @useDynLib fmlr R_gpumat_fill_runif
    fill_runif = function(seed, min=0, max=1)
    {
      if (missing(seed))
        seed = -1L
      
      seed = check_is_integer(seed)
      min = check_is_number(min)
      max = check_is_number(max)
      
      .Call(R_gpumat_fill_runif, private$type, private$x_ptr, seed, min, max)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix with random normal data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param mean,sd Parameters for the generator.
    #' @useDynLib fmlr R_gpumat_fill_rnorm
    fill_rnorm = function(seed, mean=0, sd=1)
    {
      if (missing(seed))
        seed = -1L
      
      seed = check_is_integer(seed)
      mean = check_is_number(mean)
      sd = check_is_number(sd)
      
      .Call(R_gpumat_fill_rnorm, private$type, private$x_ptr, seed, mean, sd)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get diagonal entries of the matrix.
    #' @param v A gpuvec object.
    #' @useDynLib fmlr R_gpumat_diag
    diag = function(v)
    {
      if (!is_gpuvec(v))
        stop("'v' must be a gpuvec object")
      
      check_type_consistency(self, v)
      
      .Call(R_gpumat_diag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Get anti-diagonal entries of the matrix.
    #' @param v A gpuvec object.
    #' @useDynLib fmlr R_gpumat_antidiag
    antidiag = function(v)
    {
      if (!is_gpuvec(v))
        stop("'v' must be a gpuvec object")
      
      check_type_consistency(self, v)
      
      .Call(R_gpumat_antidiag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    #' @useDynLib fmlr R_gpumat_scale
    scale = function(s)
    {
      s = check_is_number(s)
      
      .Call(R_gpumat_scale, private$type, private$x_ptr, s)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse rows.
    #' @useDynLib fmlr R_gpumat_rev_rows
    rev_rows = function()
    {
      .Call(R_gpumat_rev_rows, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse columns.
    #' @useDynLib fmlr R_gpumat_rev_cols
    rev_cols = function()
    {
      .Call(R_gpumat_rev_cols, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get element from the matrix.
    #' @param i,j Indices (0-based).
    #' @useDynLib fmlr R_gpumat_get
    get = function(i, j)
    {
      i = check_is_natnum(i)
      j = check_is_natnum(j)
      
      .Call(R_gpumat_get, private$type, private$x_ptr, i, j)
    },
    
    
    
    #' @details
    #' Set element of the matrix.
    #' @param i,j Indices (0-based).
    #' @param v Value.
    #' @useDynLib fmlr R_gpumat_set
    set = function(i, j, v)
    {
      i = check_is_natnum(i)
      j = check_is_natnum(j)
      v = check_is_number(v)
      
      .Call(R_gpumat_set, private$type, private$x_ptr, i, j, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get the specified row.
    #' @param i Index (0-based).
    #' @param v A gpuvec object.
    #' @useDynLib fmlr R_gpumat_get_row
    get_row = function(i, v)
    {
      if (!is_gpuvec(v))
        stop("'v' must be a gpuvec object")
      
      check_type_consistency(self, v)
      
      i = check_is_natnum(i)
      
      .Call(R_gpumat_get_row, private$type, private$x_ptr, i, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Get the specified column.
    #' @param j Index (0-based).
    #' @param v A gpuvec object.
    #' @useDynLib fmlr R_gpumat_get_col
    get_col = function(j, v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a gpuvec object")
      
      check_type_consistency(self, v)
      
      j = check_is_natnum(j)
      
      .Call(R_gpumat_get_col, private$type, private$x_ptr, j, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    #' @useDynLib fmlr R_gpumat_dim
    dim = function() .Call(R_gpumat_dim, private$type, private$x_ptr),
    
    #' @details
    #' Returns number of rows of the matrix.
    nrows = function() self$dim()[1],
    
    #' @details
    #' Returns number of columns of the matrix.
    ncols = function() self$dim()[2],
    
    
    
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
    #' Returns an R matrix containing a copy of the class data.
    #' @useDynLib fmlr R_gpumat_to_robj
    to_robj = function()
    {
      ret = .Call(R_gpumat_to_robj, private$type, private$x_ptr)
      if (private$type == TYPE_FLOAT)
        ret = float::float32(ret)
      
      ret
    },
    
    
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_gpumat}.
    #' @param robj R matrix.
    #' @useDynLib fmlr R_gpumat_from_robj
    from_robj = function(robj)
    {
      # TODO check matrix type of robj
      if (!is.double(robj))
        storage.mode(robj) = "double"

      .Call(R_gpumat_from_robj, private$x_ptr, robj)
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



#' gpumat
#' 
#' Constructor for gpumat objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param card A GPU card object; the return of \code{card()}. See \code{?card}.
#' @param nrows,ncols The dimensions of the matrix.
#' @param type Storage type for the matrix. Should be one of 'int', 'float', or 'double'.
#' @return A gpumat class object.
#' 
#' @seealso \code{\link{gpumat-class}}
#' 
#' @export
gpumat = function(card, nrows=0, ncols=0, type="double")
{
  gpumatR6$new(card=card, nrows=nrows, ncols=ncols, type=type)
}



#' as_gpumat
#' 
#' Convert an R matrix to a gpumat object.
#' 
#' @param card A GPU card object; the return of \code{card()}. See \code{?card}.
#' @param x R matrix.
#' @return A gpumat object.
#' 
#' @export
as_gpumat = function(card, x)
{
  ret = gpumat(card)
  ret$from_robj(x)
  ret
}
