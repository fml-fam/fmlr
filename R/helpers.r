# ------------------------------------------------------------------------------
# cpuhelpers
# ------------------------------------------------------------------------------

#' cpu2cpu
#' 
#' Copy the data in one CPU object to another. The objects must be of the same
#' class (e.g. cpuvec/cpuvec and cpumat/cpumat), but they can be of different
#' fundamental types (e.g. float/double).
#' 
#' @param cpu_in Input.
#' @param cpu_out Ouput.
#' 
#' @return Returns \code{NULL}.
#' 
#' @examples
#' library(fmlr)
#' x = cpumat(3, 2)
#' x$fill_linspace(1, 6)
#' 
#' y = cpumat(type="float")
#' cpu2cpu(x, y)
#' 
#' y$info()
#' y
#' 
#' @useDynLib fmlr R_cpuvec_cpu2cpu
#' @useDynLib fmlr R_cpumat_cpu2cpu
#' @export
cpu2cpu = function(cpu_in, cpu_out)
{
  if (!is_cpu(cpu_in) || !is_cpu(cpu_out))
    stop("one or more arguments of the wrong class")
  
  check_class_consistency(cpu_in, cpu_out)
  
  if (is_cpuvec(cpu_in))
    CFUN = R_cpuvec_cpu2cpu
  else
    CFUN = R_cpumat_cpu2cpu
  
  .Call(CFUN, cpu_in$get_type(), cpu_out$get_type(), cpu_in$data_ptr(), cpu_out$data_ptr())
  
  invisible(NULL)
}



# ------------------------------------------------------------------------------
# gpuhelpers
# ------------------------------------------------------------------------------

#' gpu2cpu
#' 
#' Copy the data in a GPU object to a CPU object. The objects must be of the
#' core class (e.g. gpuvec/cpuvec and gpumat/cpumat), but they can be of
#' different fundamental types (e.g. float/double).
#' 
#' @param gpu_in Input.
#' @param cpu_out Ouput.
#' 
#' @return Returns \code{NULL}.
#' 
#' @useDynLib fmlr R_gpuvec_gpu2cpu
#' @useDynLib fmlr R_gpumat_gpu2cpu
#' @export
gpu2cpu = function(gpu_in, cpu_out)
{
  if (!is_gpu(gpu_in) || !is_cpu(cpu_out))
    stop("one or more arguments of the wrong class")
  if ((is_vec(gpu_in) && !is_vec(cpu_out)) || (is_mat(gpu_in) && !is_mat(cpu_out)))
    stop("inconsistent object usage")
  
  if (is_gpuvec(gpu_in))
    CFUN = R_gpuvec_gpu2cpu
  else
    CFUN = R_gpumat_gpu2cpu
  
  .Call(CFUN, gpu_in$get_type(), cpu_out$get_type(), gpu_in$data_ptr(), cpu_out$data_ptr())
  
  invisible(NULL)
}



#' cpu2gpu
#' 
#' Copy the data in a CPU object to a GPU object. The objects must be of the
#' core class (e.g. cpuvec/gpuvec and cpumat/gpumat), but they can be of
#' different fundamental types (e.g. float/double).
#' 
#' @param cpu_in Input.
#' @param gpu_out Ouput.
#' 
#' @return Returns \code{NULL}.
#' 
#' @useDynLib fmlr R_gpuvec_cpu2gpu
#' @useDynLib fmlr R_gpumat_cpu2gpu
#' @export
cpu2gpu = function(cpu_in, gpu_out)
{
  if (!is_cpu(cpu_in) || !is_gpu(gpu_out))
    stop("one or more arguments of the wrong class")
  if ((is_vec(cpu_in) && !is_vec(gpu_out)) || (is_mat(cpu_in) && !is_mat(gpu_out)))
    stop("inconsistent object usage")
  
  if (is_cpuvec(cpu_in))
    CFUN = R_gpuvec_cpu2gpu
  else
    CFUN = R_gpumat_cpu2gpu
  
  .Call(CFUN, cpu_in$get_type(), gpu_out$get_type(), cpu_in$data_ptr(), gpu_out$data_ptr())
  
  invisible(NULL)
}



#' gpu2gpu
#' 
#' Copy the data in one GPU object to another. The objects must be of the same
#' class (e.g. gpuvec/gpuvec and gpumat/gpumat), but they can be of different
#' fundamental types (e.g. float/double).
#' 
#' @param gpu_in Input.
#' @param gpu_out Ouput.
#' 
#' @return Returns \code{NULL}.
#' 
#' @useDynLib fmlr R_gpuvec_gpu2gpu
#' @useDynLib fmlr R_gpumat_gpu2gpu
#' @export
gpu2gpu = function(gpu_in, gpu_out)
{
  if (!is_gpu(gpu_in) || !is_gpu(gpu_out))
    stop("one or more arguments of the wrong class")
  
  check_class_consistency(gpu_in, gpu_out)
  
  if (is_gpuvec(gpu_in))
    CFUN = R_gpuvec_gpu2gpu
  else
    CFUN = R_gpumat_gpu2gpu
  
  .Call(CFUN, gpu_in$get_type(), gpu_out$get_type(), gpu_in$data_ptr(), gpu_out$data_ptr())
  
  invisible(NULL)
}



# ------------------------------------------------------------------------------
# mpihelpers
# ------------------------------------------------------------------------------

#' cpu2mpi
#' 
#' Copy the data in an MPI matrix to a CPU matrix. They can be of different
#' fundamental types (e.g. float/double).
#' 
#' @param cpu_in Input.
#' @param mpi_out Ouput.
#' 
#' @return Returns \code{NULL}.
#' 
#' @useDynLib fmlr R_mpimat_cpu2mpi
#' @export
cpu2mpi = function(cpu_in, mpi_out)
{
  if (!is_cpumat(cpu_in) || !is_mpimat(mpi_out))
    stop("one or more arguments of the wrong class")
  
  g = mpi_out$get_grid()
  
  .Call(R_mpimat_cpu2mpi, cpu_in$get_type(), mpi_out$get_type(), cpu_in$data_ptr(), mpi_out$data_ptr())
  
  invisible(NULL)
}



#' mpi2cpu
#' 
#' Copy the data in an MPI matrix to a CPU matrix. They can be of different
#' fundamental types (e.g. float/double).
#' 
#' @param mpi_in Input.
#' @param cpu_out Ouput.
#' @param rdest,cdest The row/column index of the receiving process.
#' 
#' @return Returns \code{NULL}.
#' 
#' @useDynLib fmlr R_mpimat_mpi2cpu
#' @export
mpi2cpu = function(mpi_in, cpu_out, rdest=0, cdest=0)
{
  if (!is_mpimat(mpi_in) || !is_cpumat(cpu_out))
    stop("one or more arguments of the wrong class")
  
  rdest = as.integer(rdest)
  cdest = as.integer(cdest)
  g = mpi_in$get_grid()
  if (rdest < 0 || rdest >= g$nprow() || cdest < 0 || cdest >= g$npcol())
    stop("rdest/cdest out of bounds")
  
  .Call(R_mpimat_mpi2cpu, mpi_in$get_type(), cpu_out$get_type(), mpi_in$data_ptr(), cpu_out$data_ptr(), rdest, cdest)
  
  invisible(NULL)
}



#' mpi2mpi
#' 
#' Copy the data in one MPI matrix to another. They can be of different
#' fundamental types (e.g. float/double).
#' 
#' @param mpi_in Input.
#' @param mpi_out Ouput.
#' 
#' @return Returns \code{NULL}.
#' 
#' @useDynLib fmlr R_mpimat_mpi2mpi
#' @export
mpi2mpi = function(mpi_in, mpi_out)
{
  if (!is_mpimat(mpi_in) || !is_mpimat(mpi_out))
    stop("one or more arguments of the wrong class")
  
  .Call(R_mpimat_mpi2mpi, mpi_in$get_type(), mpi_out$get_type(), mpi_in$data_ptr(), mpi_out$data_ptr())
  
  invisible(NULL)
}
