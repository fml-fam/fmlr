#' @useDynLib fmlr R_cpumat_dimops_matsums
#' @useDynLib fmlr R_gpumat_dimops_matsums
#' @useDynLib fmlr R_mpimat_dimops_matsums
matsums = function(row, mean, x, s)
{
  CFUN = get_cfun(x, "dimops", "matsums")
  if (is.null(s))
    s = setret(x, vec=TRUE)
  .Call(CFUN, x$get_type(), row, mean, x$data_ptr(), s$data_ptr())
  s
}



#' matsums
#' 
#' Compute the sums/means of the rows/columns of a matrix.
#' 
#' @param x Input matrix.
#' @param s Either \code{NULL} or an already allocated fml matrix of the same
#' class and type as \code{x}.
#' @return Returns the matrix sum.
#' 
#' @rdname dimops
#' @name dimops
NULL



#' @name dimops
#' @export
dimops_rowsums = function(x, s=NULL)
{
  check_is_mat(x)
  invisiret = check_inputs(s, x)
  
  s = matsums(TRUE, FALSE, x, s)
  
  if (invisiret)
    invisible(s)
  else
    s
}

#' @name dimops
#' @export
dimops_rowmeans = function(x, s=NULL)
{
  check_is_mat(x)
  invisiret = check_inputs(s, x)
  
  s = matsums(TRUE, TRUE, x, s)
  
  if (invisiret)
    invisible(s)
  else
    s
}

#' @name dimops
#' @export
dimops_colsums = function(x, s=NULL)
{
  check_is_mat(x)
  invisiret = check_inputs(s, x)
  
  s = matsums(FALSE, FALSE, x, s)
  
  if (invisiret)
    invisible(s)
  else
    s
}

#' @name dimops
#' @export
dimops_colmeans = function(x, s=NULL)
{
  check_is_mat(x)
  invisiret = check_inputs(s, x)
  
  s = matsums(FALSE, TRUE, x, s)
  
  if (invisiret)
    invisible(s)
  else
    s
}



#' scale
#' 
#' Remove the rows and/or sd of the columns of a matrix.
#' 
#' @param x Input matrix.
#' @return Returns the matrix sum.
#' 
#' @rdname scale
#' @name scale
#' 
#' @useDynLib fmlr R_cpumat_dimops_scale
#' @useDynLib fmlr R_gpumat_dimops_scale
#' @useDynLib fmlr R_mpimat_dimops_scale
#' 
#' @export
dimops_scale = function(rm_mean=TRUE, rm_sd=FALSE, x)
{
  check_is_mat(x)
  
  rm_mean = as.logical(rm_mean)
  rm_sd = as.logical(rm_sd)
  
  CFUN = get_cfun(x, "dimops", "scale")
  .Call(CFUN, x$get_type(), rm_mean, rm_sd, x$data_ptr())
  
  invisible(NULL)
}
