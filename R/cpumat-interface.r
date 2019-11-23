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
  ),
  
  private = list(
    x_ptr = NULL,
    type = ""
  )
)
