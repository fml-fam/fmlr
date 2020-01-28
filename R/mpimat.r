#' mpimat class
#' 
#' Storage and methods for MPI matrix data.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @rdname mpimat-class
#' @name mpimat-class
mpimatR6 = R6::R6Class("mpimat",
  public = list(
    #' @details
    #' Class initializer. See also \code{?mpimat}.
    #' @param grid An MPI grid object; the return of \code{grid()}. See \code{?grid}.
    #' @param nrows,ncols The dimension of the matrix.
    #' @param bf_rows,bf_cols The blocking factor.
    #' @param type Storage type for the matrix. Should be one of 'int', 'float', or 'double'.
    #' @useDynLib fmlr R_mpimat_init
    initialize = function(grid, nrows=0, ncols=0, bf_rows=16, bf_cols=16, type="double")
    {
      type = match.arg(tolower(type), TYPES_STR)
      check_is_grid(grid)
      
      nrows = check_is_natnum(nrows)
      ncols = check_is_natnum(ncols)
      
      bf_rows = as.integer(bf_rows)
      bf_cols = as.integer(bf_cols)
      
      private$grid = grid
      private$type_str = type
      private$type = type_str2int(type)
      private$x_ptr = .Call(R_mpimat_init, private$type, grid$data_ptr(), nrows, ncols, bf_rows, bf_cols, type)
    },
    
    
    
    #' @details
    #' Change the dimension of the matrix object.
    #' @param nrows,ncols The new dimension.
    #' @useDynLib fmlr R_mpimat_resize
    resize = function(nrows, ncols)
    {
      nrows = check_is_natnum(nrows)
      ncols = check_is_natnum(ncols)
      
      .Call(R_mpimat_resize, private$type, private$x_ptr, nrows, ncols)
      invisible(self)
    },
    
    
    
    #' @details
    #' Duplicate the matrix in a deep copy.
    #' @useDynLib fmlr R_mpimat_dupe
    dupe = function()
    {
      ret_ptr = .Call(R_mpimat_dupe, private$type, private$x_ptr)
      
      tmp = private$x_ptr
      private$x_ptr = ret_ptr
      ret = self$clone()
      private$x_ptr = tmp
      
      ret
    },
    
    
    
    #' @details
    #' Print one-line information about the matrix.
    #' @useDynLib fmlr R_mpimat_info
    info = function()
    {
      .Call(R_mpimat_info, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    #' @useDynLib fmlr R_mpimat_print
    print = function(ndigits=4)
    {
      ndigits = min(as.integer(ndigits), 15L)
      
      .Call(R_mpimat_print, private$type, private$x_ptr, ndigits)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with zero.
    #' @useDynLib fmlr R_mpimat_fill_zero
    fill_zero = function()
    {
      .Call(R_mpimat_fill_zero, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    #' @useDynLib fmlr R_mpimat_fill_val
    fill_val = function(v)
    {
      v = check_is_number(v)
      
      .Call(R_mpimat_fill_val, private$type, private$x_ptr, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    #' @useDynLib fmlr R_mpimat_fill_linspace
    fill_linspace = function(start, stop)
    {
      start = check_is_number(start)
      stop = check_is_number(stop)
      
      .Call(R_mpimat_fill_linspace, private$type, private$x_ptr, start, stop)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill diagonal values to 1 and non-diagonal values to 0.
    #' @useDynLib fmlr R_mpimat_fill_eye
    fill_eye = function()
    {
      .Call(R_mpimat_fill_eye, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Set diagonal entries of the matrix to those in the vector. If the vector
    #' is smaller than the matrix diagonal, the vector will recycle until the
    #' matrix diagonal is filled.
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_mpimat_fill_diag
    fill_diag = function(v)
    {
      if (!is_cpuvec(v))
        v = as_cpuvec(v, copy=FALSE)
      
      check_type_consistency(self, v)
      
      .Call(R_mpimat_fill_diag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix with random unifmorm data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param min,max Parameters for the generator.
    #' @useDynLib fmlr R_mpimat_fill_runif
    fill_runif = function(seed, min=0, max=1)
    {
      if (missing(seed))
        seed = -1L
      
      seed = check_is_integer(seed)
      min = check_is_number(min)
      max = check_is_number(max)
      
      .Call(R_mpimat_fill_runif, private$type, private$x_ptr, seed, min, max)
      invisible(self)
    },
    
    
    
    #' @details
    #' Fill the matrix with random normal data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param mean,sd Parameters for the generator.
    #' @useDynLib fmlr R_mpimat_fill_rnorm
    fill_rnorm = function(seed, mean=0, sd=1)
    {
      if (missing(seed))
        seed = -1L
      
      seed = check_is_integer(seed)
      mean = check_is_number(mean)
      sd = check_is_number(sd)
      
      .Call(R_mpimat_fill_rnorm, private$type, private$x_ptr, seed, mean, sd)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get diagonal entries of the matrix.
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_mpimat_diag
    diag = function(v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a cpuvec object")
      
      check_type_consistency(self, v)
      
      .Call(R_mpimat_diag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Get anti-diagonal entries of the matrix.
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_mpimat_antidiag
    antidiag = function(v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a cpuvec object")
      
      check_type_consistency(self, v)
      
      .Call(R_mpimat_antidiag, private$type, private$x_ptr, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    #' @useDynLib fmlr R_mpimat_scale
    scale = function(s)
    {
      s = check_is_number(s)
      
      .Call(R_mpimat_scale, private$type, private$x_ptr, s)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse rows.
    #' @useDynLib fmlr R_mpimat_rev_rows
    rev_rows = function()
    {
      .Call(R_mpimat_rev_rows, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Reverse columns.
    #' @useDynLib fmlr R_mpimat_rev_cols
    rev_cols = function()
    {
      .Call(R_mpimat_rev_cols, private$type, private$x_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get element from the matrix.
    #' @param i,j Indices (0-based).
    #' @useDynLib fmlr R_mpimat_get
    get = function(i, j)
    {
      i = check_is_natnum(i)
      j = check_is_natnum(j)
      
      .Call(R_mpimat_get, private$type, private$x_ptr, i, j)
    },
    
    
    
    #' @details
    #' Set element of the matrix.
    #' @param i,j Indices (0-based).
    #' @param v Value.
    #' @useDynLib fmlr R_mpimat_set
    set = function(i, j, v)
    {
      i = check_is_natnum(i)
      j = check_is_natnum(j)
      v = check_is_number(v)
      
      .Call(R_mpimat_set, private$type, private$x_ptr, i, j, v)
      invisible(self)
    },
    
    
    
    #' @details
    #' Get the specified row.
    #' @param i Index (0-based).
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_mpimat_get_row
    get_row = function(i, v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a cpuvec object")
      
      check_type_consistency(self, v)
      
      i = check_is_natnum(i)
      
      .Call(R_mpimat_get_row, private$type, private$x_ptr, i, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Get the specified column.
    #' @param j Index (0-based).
    #' @param v A cpuvec object.
    #' @useDynLib fmlr R_mpimat_get_col
    get_col = function(j, v)
    {
      if (!is_cpuvec(v))
        stop("'v' must be a cpuvec object")
      
      check_type_consistency(self, v)
      
      j = check_is_natnum(j)
      
      .Call(R_mpimat_get_col, private$type, private$x_ptr, j, v$data_ptr())
      invisible(self)
    },
    
    
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    #' @useDynLib fmlr R_mpimat_dim
    dim = function() .Call(R_mpimat_dim, private$type, private$x_ptr),
    
    #' @details
    #' Returns number of rows of the matrix.
    nrows = function() self$dim()[1],
    
    #' @details
    #' Returns number of columns of the matrix.
    ncols = function() self$dim()[2],
    
    
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    #' @useDynLib fmlr R_mpimat_ldim
    ldim = function() .Call(R_mpimat_ldim, private$type, private$x_ptr),
    
    #' @details
    #' Returns number of columns of the matrix.
    nrows_local = function() self$ldim()[1],
    
    #' @details
    #' Returns number of columns of the matrix.
    ncols_local = function() self$ldim()[2],
    
    
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    #' @useDynLib fmlr R_mpimat_bfdim
    bfdim = function() .Call(R_mpimat_bfdim, private$type, private$x_ptr),
    
    #' @details
    #' Returns number of columns of the matrix.
    bf_rows = function() self$bfdim()[1],
    
    #' @details
    #' Returns number of columns of the matrix.
    bf_cols = function() self$bfdim()[2],
    
    
    
    #' @details
    #' Returns the internal grid object.
    get_grid = function() private$grid,
    
    
    
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
    #' @useDynLib fmlr R_mpimat_to_robj
    to_robj = function()
    {
      ret = .Call(R_mpimat_to_robj, private$type, private$x_ptr)
      if (private$type == TYPE_FLOAT)
        ret = float::float32(ret)
      
      ret
    },
    
    
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_mpimat}.
    #' @param robj R matrix.
    #' @useDynLib fmlr R_mpimat_from_robj
    from_robj = function(robj)
    {
      # TODO check matrix type of robj
      if (!is.double(robj))
        storage.mode(robj) = "double"

      .Call(R_mpimat_from_robj, private$x_ptr, robj)
      invisible(self)
    }
  ),
  
  
  
  private = list(
    grid = NULL,
    x_ptr = NULL,
    type = -1L,
    type_str = ""
  )
)



#' mpimat
#' 
#' Constructor for mpimat objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param grid An MPI grid object; the return of \code{grid()}. See \code{?grid}.
#' @param nrows,ncols The dimensions of the matrix.
#' @param bf_rows,bf_cols The blocking factor.
#' @param type Storage type for the matrix. Should be one of 'int', 'float', or 'double'.
#' @return A mpimat class object.
#' 
#' @seealso \code{\link{mpimat-class}}
#' 
#' @export
mpimat = function(grid, nrows=0, ncols=0, bf_rows=16, bf_cols=16, type="double")
{
  mpimatR6$new(grid=grid, nrows=nrows, ncols=ncols, bf_rows=bf_rows, bf_cols=bf_cols, type=type)
}



#' as_mpimat
#' 
#' Convert an R matrix to an mpimat object.
#' 
#' @param grid An MPI grid object; the return of \code{grid()}. See \code{?grid}.
#' @param x R matrix.
#' @param bf_rows,bf_cols The blocking factor.
#' @return An mpimat object.
#' 
#' @export
as_mpimat = function(grid, x, bf_rows=16, bf_cols=16)
{
  ret = mpimat(grid, bf_rows=bf_rows, bf_cols=bf_cols)
  ret$from_robj(x)
  ret
}
