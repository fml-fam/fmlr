cpumatR6 = R6::R6Class("cpumat",
  public = list(
    initialize = function(nrows=0, ncols=0, type="double")
    {
      private$x_ptr = cpumat_init(nrows, ncols, type)
      private$type = type
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
