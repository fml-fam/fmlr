#' grid class
#' 
#' Storage and methods for MPI grid data.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @rdname mpi-grid-class
#' @name mpi-grid-class
gridR6 = R6::R6Class("grid",
  public = list(
    #' @details
    #' Class initializer.
    #' @param gridtype Type of processor grid: `PROC_GRID_SQUARE`,
    #' `PROC_GRID_WIDE`, or `PROC_GRID_TALL`.
    #' @useDynLib fmlr R_grid_init
    initialize = function(gridtype=PROC_GRID_SQUARE)
    {
      gridtype = as.integer(gridtype)
      
      private$g_ptr = .Call(R_grid_init, gridtype)
    },
    
    
    
    #' @details
    #' Set grid to another BLACS context.
    #' @param blacs_context The BLACS integer context number.
    #' @useDynLib fmlr R_grid_set
    set = function(blacs_context)
    {
      blacs_context = as.integer(blacs_context)
      .Call(R_grid_set, private$g_ptr, blacs_context)
      invisible(self)
    },
    
    
    
    #' @details
    #' Exits the BLACS grid, but does not shutdown BLACS/MPI.
    #' @useDynLib fmlr R_grid_exit
    exit = function()
    {
      .Call(R_grid_exit, private$g_ptr)
      invisible(self)
    },
    
    
    
    #' @details
    #' Shuts down BLACS, and optionally MPI.
    #' @param mpi_continue Should MPI continue, i.e., not be shut down too?
    #' @useDynLib fmlr R_grid_finalize
    finalize = function(mpi_continue=FALSE)
    {
      mpi_continue = as.logical(mpi_continue)
      
      .Call(R_grid_finalize, private$g_ptr, mpi_continue)
      invisible(self)
    },
    
    
    
    #' @details
    #' Print one-line information about the object.
    #' @useDynLib fmlr R_grid_info
    info = function()
    {
      .Call(R_grid_info, private$g_ptr)
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
    #' @useDynLib fmlr R_grid_rank0
    rank0 = function() .Call(R_grid_rank0, private$g_ptr),
    
    
    
    #' @details
    #' Is the calling process in the grid, i.e. row and col not -1?
    #' @useDynLib fmlr R_grid_ingrid
    ingrid = function() .Call(R_grid_ingrid, private$g_ptr),
    
    
    
    #' @details
    #' Execute a barrier.
    #' @param scope 'A' for all, 'R' for row, or 'C' for column.
    #' @useDynLib fmlr R_grid_barrier
    barrier = function(scope='A')
    {
      .Call(R_grid_barrier, private$g_ptr, scope)
      invisible(self)
    },
    
    
    
    #' @details
    #' The BLACS integer context.
    #' @useDynLib fmlr R_grid_ictxt
    ictxt = function() .Call(R_grid_ictxt, private$g_ptr),
    
    
    
    #' @details
    #' The BLACS integer context.
    #' @useDynLib fmlr R_grid_nprocs
    nprocs = function() .Call(R_grid_nprocs, private$g_ptr),
    
    
    
    #' @details
    #' The BLACS integer context.
    #' @useDynLib fmlr R_grid_nprow
    nprow = function() .Call(R_grid_nprow, private$g_ptr),
    
    
    
    #' @details
    #' The BLACS integer context.
    #' @useDynLib fmlr R_grid_npcol
    npcol = function() .Call(R_grid_npcol, private$g_ptr),
    
    
    
    #' @details
    #' The BLACS integer context.
    #' @useDynLib fmlr R_grid_myrow
    myrow = function() .Call(R_grid_myrow, private$g_ptr),
    
    
    
    #' @details
    #' The BLACS integer context.
    #' @useDynLib fmlr R_grid_mycol
    mycol = function() .Call(R_grid_mycol, private$g_ptr),
    
    
    
    #' @details
    #' Returns whether or not the grid object is valid.
    #' @useDynLib fmlr R_grid_valid_grid
    valid_grid = function() .Call(R_grid_valid_grid, private$g_ptr),
    
    
    
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
#' Constructor for MPI grid objects.
#' 
#' @details
#' Data is held in an external pointer.
#' 
#' @param gridtype Type of processor grid: `PROC_GRID_SQUARE`,
#' `PROC_GRID_WIDE`, or `PROC_GRID_TALL`.
#' @return A grid class object.
#' 
#' @export
grid = function(gridtype=PROC_GRID_SQUARE)
{
  gridR6$new(gridtype=gridtype)
}
