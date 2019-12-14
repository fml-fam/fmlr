#' grid class
#' 
#' Storage and methods for GPU grid data.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @rdname gpu-grid-class
#' @name gpu-grid-class
gridR6 = R6::R6Class("grid",
  public = list(
    #' @details
    #' Class initializer.
    #' @param gridtype Type of processor grid.
    initialize = function(gridtype=PROC_GRID_SQUARE)
    {
      private$g_ptr = grid_init(gridtype)
    },
    
    #' @details
    #' Set grid to another BLACS context.
    #' @param blacs_context The BLACS integer context number.
    set = function(blacs_context)
    {
      grid_set(private$g_ptr, blacs_context)
      invisible(self)
    },
    
    #' @details
    #' Exits the BLACS grid, but does not shutdown BLACS/MPI.
    exit = function()
    {
      grid_exit(private$g_ptr)
      invisible(self)
    },
    
    #' @details
    #' Shuts down BLACS, and optionally MPI.
    #' @param mpi_continue Should MPI continue, i.e., not be shut down too?
    finalize = function(mpi_continue=FALSE)
    {
      grid_finalize(private$g_ptr, mpi_continue)
      invisible(self)
    },
    
    #' @details
    #' Print one-line information about the object.
    info = function()
    {
      grid_info(private$g_ptr)
      invisible(self)
    },
    
    #' @details
    #' Print one-line information about the object.
    print = function()
    {
      grid_info(private$g_ptr)
      invisible(self)
    },
    
    #' @details
    #' Is the calling process rank 0, i.e. row 0 and col 0?
    rank0 = function() grid_rank0(private$g_ptr),
    
    #' @details
    #' Is the calling process in the grid, i.e. row and col not -1?
    ingrid = function() grid_ingrid(private$g_ptr),
    
    #' @details
    #' Execute a barrier.
    #' @param scope 'A' for all, 'R' for row, or 'C' for column.
    barrier = function(scope='A')
    {
      grid_barrier(private$g_ptr, scope)
      invisible(self)
    },
    
    #' @details
    #' The BLACS integer context.
    ictxt = function() grid_ictxt(private$g_ptr),
    
    #' @details
    #' The BLACS integer context.
    nprocs = function() grid_nprocs(private$g_ptr),
    
    #' @details
    #' The BLACS integer context.
    nprow = function() grid_nprow(private$g_ptr),
    
    #' @details
    #' The BLACS integer context.
    npcol = function() grid_npcol(private$g_ptr),
    
    #' @details
    #' The BLACS integer context.
    myrow = function() grid_myrow(private$g_ptr),
    
    #' @details
    #' The BLACS integer context.
    mycol = function() grid_mycol(private$g_ptr),
    
    #' @details
    #' Returns whether or not the grid object is valid.
    valid_grid = function() grid_valid_grid(private$g_ptr),
    
    #' @details
    #' Returns the external pointer data. For developers only.
    data_ptr = function() private$g_ptr
  ),
  
  private = list(
    g_ptr = NULL
  )
)



#' grid
#' 
#' Constructor for GPU grid objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param id GPU id number.
#' @return A grid class object.
#' 
#' @export
grid = function(gridtype=PROC_GRID_SQUARE)
{
  gridR6$new(gridtype=gridtype)
}
