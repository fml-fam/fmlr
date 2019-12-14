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
    initialize = function(nrows=0, ncols=0, type="double")
    {
      private$x_ptr = cpumat_init(nrows, ncols, type)
      private$type = type
    },
    
    #' @details
    #' Change the dimension of the matrix object.
    #' @param nrows,ncols The new dimension.
    resize = function(nrows, ncols)
    {
      cpumat_resize(private$x_ptr, nrows, ncols)
      invisible(self)
    },
    
    #' @details
    #' Set the data in the cpumat object to point to the array in 'data'. See
    #' also \code{?as_cpumat}.
    #' @param data R matrix.
    inherit = function(data)
    {
      cpumat_inherit(private$x_ptr, data)
      invisible(self)
    },
    
    #' @details
    #' Print one-line information about the matrix.
    info = function()
    {
      cpumat_info(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    print = function(ndigits=4)
    {
      cpumat_print(private$x_ptr, ndigits)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with zero.
    fill_zero = function()
    {
      cpumat_fill_zero(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    fill_val = function(v)
    {
      cpumat_fill_val(private$x_ptr, v)
      invisible(self)
    },
    
    #' @details
    #' Fill the matrix (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    fill_linspace = function(start, stop)
    {
      cpumat_fill_linspace(private$x_ptr, start, stop)
      invisible(self)
    },
    
    #' @details
    #' Fill diagonal values to 1 and non-diagonal values to 0.
    fill_eye = function()
    {
      cpumat_fill_eye(private$x_ptr)
      invisible(self)
    },
    
    # TODO diag
    #' @details
    #' Fill the matrix with random unifmorm data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param min,max Parameters for the generator.
    fill_runif = function(seed, min=0, max=1)
    {
      cpumat_fill_runif(private$x_ptr, seed, min, max)
      invisible(self)
    },
    
    #' @details
    #' Fill the matrix with random normal data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param mean,sd Parameters for the generator.
    fill_rnorm = function(seed, mean=0, sd=1)
    {
      cpumat_fill_rnorm(private$x_ptr, seed, mean, sd)
      invisible(self)
    },
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    scale = function(s)
    {
      cpumat_scale(private$x_ptr, s)
      invisible(self)
    },
    
    #' @details
    #' Reverse rows.
    rev_rows = function()
    {
      cpumat_rev_rows(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Reverse columns.
    rev_cols = function()
    {
      cpumat_rev_cols(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Returns number of rows of the matrix.
    nrows = function() cpumat_dim(private$x_ptr)[1],
    
    #' @details
    #' Returns number of columns of the matrix.
    ncols = function() cpumat_dim(private$x_ptr)[2],
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    dim = function() cpumat_dim(private$x_ptr),
    
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$x_ptr,
    
    #' @details
    #' Returns an R matrix containing a copy of the class data.
    to_robj = function() cpumat_to_robj(private$x_ptr),
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_cpumat}.
    #' @param robj R matrix.
    from_robj = function(robj)
    {
      cpumat_from_robj(private$x_ptr, robj)
      invisible(self)
    }
  ),
  
  private = list(
    x_ptr = NULL,
    type = ""
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
