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
    initialize = function(card, nrows=0, ncols=0, type="double")
    {
      private$card = card
      private$x_ptr = gpumat_init(card$data_ptr(), nrows, ncols, type)
      private$type = type
    },
    
    #' @details
    #' Change the dimension of the matrix object.
    #' @param nrows,ncols The new dimension.
    resize = function(nrows, ncols)
    {
      gpumat_resize(private$x_ptr, nrows, ncols)
      invisible(self)
    },
    
    #' @details
    #' Set the data in the gpumat object to point to the array in 'data'. See
    #' also \code{?as_gpumat}.
    #' @param data R matrix.
    set = function(data)
    {
      gpumat_set(private$x_ptr, data)
      invisible(self)
    },
    
    #' @details
    #' Print one-line information about the matrix.
    info = function()
    {
      gpumat_info(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Print the data.
    #' @param ndigits Number of decimal digits to print.
    print = function(ndigits=4)
    {
      gpumat_print(private$x_ptr, ndigits)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with zero.
    fill_zero = function()
    {
      gpumat_fill_zero(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with one.
    fill_one = function()
    {
      gpumat_fill_one(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Fill all entries with supplied value.
    #' @param v Value to set all entries to.
    fill_val = function(v)
    {
      gpumat_fill_val(private$x_ptr, v)
      invisible(self)
    },
    
    #' @details
    #' Fill the matrix (column-wise) with linearly-spaced values.
    #' @param start,stop Beginning/end of the linear spacing.
    fill_linspace = function(start, stop)
    {
      gpumat_fill_linspace(private$x_ptr, start, stop)
      invisible(self)
    },
    
    #' @details
    #' Fill diagonal values to 1 and non-diagonal values to 0.
    fill_eye = function()
    {
      gpumat_fill_eye(private$x_ptr)
      invisible(self)
    },
    
    # TODO diag
    #' @details
    #' Fill the matrix with random unifmorm data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param min,max Parameters for the generator.
    fill_runif = function(seed, min=0, max=1)
    {
      gpumat_fill_runif(private$x_ptr, seed, min, max)
      invisible(self)
    },
    
    #' @details
    #' Fill the matrix with random normal data.
    #' @param seed Seed for the generator. Can be left blank.
    #' @param mean,sd Parameters for the generator.
    fill_rnorm = function(seed, mean=0, sd=1)
    {
      gpumat_fill_rnorm(private$x_ptr, seed, mean, sd)
      invisible(self)
    },
    
    #' @details
    #' Scale all entries by the supplied value.
    #' @param s Value to scale all entries by.
    scale = function(s)
    {
      gpumat_scale(private$x_ptr, s)
      invisible(self)
    },
    
    #' @details
    #' Reverse rows.
    rev_rows = function()
    {
      gpumat_rev_rows(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Reverse columns.
    rev_cols = function()
    {
      gpumat_rev_cols(private$x_ptr)
      invisible(self)
    },
    
    #' @details
    #' Returns number of rows of the matrix.
    nrows = function() gpumat_nrows(private$x_ptr),
    
    #' @details
    #' Returns number of columns of the matrix.
    ncols = function() gpumat_ncols(private$x_ptr),
    
    #' @details
    #' Returns number of rows and columns of the matrix.
    dim = function() gpumat_dim(private$x_ptr),
    
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$x_ptr,
    
    #' @details
    #' Returns an R matrix containing a copy of the class data.
    to_robj = function() gpumat_to_robj(private$x_ptr),
    
    #' @details
    #' Copies the values of the input to the class data. See also \code{?as_gpumat}.
    #' @param robj R matrix.
    from_robj = function(robj)
    {
      gpumat_from_robj(private$x_ptr, robj)
      invisible(self)
    }
  ),
  
  private = list(
    card = NULL,
    x_ptr = NULL,
    type = ""
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
#' @param x R matrix.
#' @param copy Should the R data be copied? If \code{FALSE}, be careful!
#' @return A gpumat object.
#' 
#' @export
as_gpumat = function(card, x, copy=TRUE)
{
  ret = gpumat(card)
  
  if (isTRUE(copy))
    ret$from_robj(x)
  else
    ret$set(x)
  
  ret
}
