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
    initialize = function(grid, nrows=0, ncols=0, bf_rows=16, bf_cols=16, type="double")
    {
      private$grid = grid
      private$x_ptr = mpimat_init(grid$data_ptr(), nrows, ncols, bf_rows, bf_cols, type)
      private$type = type
    },
    
    #' @details
    #' Change the dimension of the matrix object.
    #' @param nrows,ncols The new dimension.
    resize = function(nrows, ncols)
    {
      mpimat_resize(private$x_ptr, nrows, ncols)
      invisible(self)
    },
    
    #' @details
    #' Set the data in the mpimat object to point to the array in 'data'. See
    #' also \code{?as_mpimat}.
    #' @param data R matrix.
    inherit = function(data)
    {
      mpimat_inherit(private$x_ptr, data)
      invisible(self)
    },
    
    #' @details
    #' Print one-line information about the matrix.
    info = function()
    {
      mpimat_info(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    print = function(ndigits=4)
    {
      mpimat_print(private$x_ptr, ndigits)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with zero.
    fill_zero = function()
    {
      mpimat_fill_zero(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    fill_val = function(v)
    {
      mpimat_fill_val(private$x_ptr, v)
      invisible(self)
    },
    
    #' @details
    #' Fill the matrix (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    fill_linspace = function(start, stop)
    {
      mpimat_fill_linspace(private$x_ptr, start, stop)
      invisible(self)
    },
    
    #' @details
    #' Fill diagonal values to 1 and non-diagonal values to 0.
    fill_eye = function()
    {
      mpimat_fill_eye(private$x_ptr)
      invisible(self)
    },
    
    # TODO diag
    #' @details
    #' Fill the matrix with random unifmorm data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param min,max Parameters for the generator.
    fill_runif = function(seed, min=0, max=1)
    {
      mpimat_fill_runif(private$x_ptr, seed, min, max)
      invisible(self)
    },
    
    #' @details
    #' Fill the matrix with random normal data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param mean,sd Parameters for the generator.
    fill_rnorm = function(seed, mean=0, sd=1)
    {
      mpimat_fill_rnorm(private$x_ptr, seed, mean, sd)
      invisible(self)
    },
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    scale = function(s)
    {
      mpimat_scale(private$x_ptr, s)
      invisible(self)
    },
    
    #' @details
    #' Reverse rows.
    rev_rows = function()
    {
      mpimat_rev_rows(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Reverse columns.
    rev_cols = function()
    {
      mpimat_rev_cols(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Returns number of rows of the matrix.
    nrows = function() mpimat_dim(private$x_ptr)[1],
    
    #' @details
    #' Returns number of columns of the matrix.
    ncols = function() mpimat_dim(private$x_ptr)[2],
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    dim = function() mpimat_dim(private$x_ptr),
    
    #' @details
    #' Returns number of columns of the matrix.
    nrows_local = function() mpimat_ldim(private$x_ptr)[1],
    
    #' @details
    #' Returns number of columns of the matrix.
    ncols_local = function() mpimat_ldim(private$x_ptr)[2],
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    ldim = function() mpimat_ldim(private$x_ptr),
    
    #' @details
    #' Returns number of columns of the matrix.
    bf_rows = function() mpimat_bfdim(private$x_ptr)[2],
    
    #' @details
    #' Returns number of columns of the matrix.
    bf_cols = function() mpimat_bfdim(private$x_ptr)[2],
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    bfdim = function() mpimat_bfdim(private$x_ptr),
    
    #' @details
    #' Returns the internal grid object.
    get_grid = function() private$grid,
    
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$x_ptr,
    
    #' @details
    #' Returns an R matrix containing a copy of the class data.
    to_robj = function() mpimat_to_robj(private$x_ptr),
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_mpimat}.
    #' @param robj R matrix.
    from_robj = function(robj)
    {
      mpimat_from_robj(private$x_ptr, robj)
      invisible(self)
    }
  ),
  
  private = list(
    grid = NULL,
    x_ptr = NULL,
    type = ""
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
#' Convert an R matrix to a mpimat object.
#' 
#' @param x R matrix.
#' @param copy Should the R data be copied? If \code{FALSE}, be careful!
#' @return A mpimat object.
#' 
#' @export
as_mpimat = function(grid, x, copy=TRUE)
{
  ret = mpimat(grid)
  
  if (isTRUE(copy))
    ret$from_robj(x)
  else
    ret$inherit(x)
  
  ret
}
