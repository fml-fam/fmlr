cpumatR6 = R6::R6Class("cpumat",
  public = list(
    initialize = function(nrows=0, ncols=0, type="double")
    {
      private$x_ptr = cpumat_init(nrows, ncols, type)
      private$type = type
    },
    
    resize = function(nrows, ncols)
    {
      cpumat_resize(private$x_ptr, nrows, ncols)
      invisible(self)
    },
    set = function(data)
    {
      cpumat_set(private$x_ptr, data)
      invisible(self)
    },
    
    info = function()
    {
      cpumat_info(private$x_ptr)
      invisible(self)
    },
    print = function(ndigits=4)
    {
      cpumat_print(private$x_ptr, ndigits)
      invisible(self)
    },
    
    fill_zero = function()
    {
      cpumat_fill_zero(private$x_ptr)
      invisible(self)
    },
    fill_one = function()
    {
      cpumat_fill_one(private$x_ptr)
      invisible(self)
    },
    fill_val = function(v)
    {
      cpumat_fill_val(private$x_ptr, v)
      invisible(self)
    },
    fill_linspace = function(start, stop)
    {
      cpumat_fill_linspace(private$x_ptr, start, stop)
      invisible(self)
    },
    fill_eye = function()
    {
      cpumat_fill_eye(private$x_ptr)
      invisible(self)
    },
    # TODO diag
    fill_runif = function(seed, min=0, max=1)
    {
      cpumat_fill_runif(private$x_ptr, seed, min, max)
      invisible(self)
    },
    fill_rnorm = function(seed, mean=0, sd=1)
    {
      cpumat_fill_rnorm(private$x_ptr, seed, mean, sd)
      invisible(self)
    },
    
    scale = function(s)
    {
      cpumat_scale(private$x_ptr, s)
      invisible(self)
    },
    rev_rows = function()
    {
      cpumat_rev_rows(private$x_ptr)
      invisible(self)
    },
    rev_cols = function()
    {
      cpumat_rev_cols(private$x_ptr)
      invisible(self)
    },
    
    nrows = function() cpumat_nrows(private$x_ptr),
    ncols = function() cpumat_ncols(private$x_ptr),
    dim = function() cpumat_dim(private$x_ptr),
    
    to_robj = function() cpumat_to_robj(private$x_ptr),
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



#' @export
cpumat = function(nrows=0, ncols=0, type="double")
{
  cpumatR6$new(nrows=nrows, ncols=ncols, type=type)
}



#' @export
as_cpumat = function(x, copy=TRUE)
{
  ret = cpumat()
  
  if (isTRUE(copy))
    ret$from_robj(x)
  else
    ret$set(x)
  
  ret
}
