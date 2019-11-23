cpumatR6 = R6::R6Class("cpumat",
  public = list(
    initialize = function(nrows=0, ncols=0, type="double")
    {
      private$x_ptr = cpumat_init(nrows, ncols, type)
      private$type = type
    },
  ),
  
  private = list(
    x_ptr = NULL,
    type = ""
  )
)
