#' @useDynLib fmlr R_cpumat_linalg_crossprod
#' @useDynLib fmlr R_gpumat_linalg_crossprod
#' @useDynLib fmlr R_mpimat_linalg_crossprod
linalg_crossprods = function(x, ret, alpha, xpose)
{
  xpose = as.logical(xpose)
  alpha = as.double(alpha)
  
  if (!is.null(ret))
  {
    check_class_consistency(x, ret)
    invisiret = TRUE
  }
  else
    invisiret = FALSE
  
  if (isTRUE(xpose))
    n = x$nrows()
  else
    n = x$ncols()
  
  if (inherits(x, "cpumat"))
  {
    if (is.null(ret))
      ret = cpumat(n, n)
    
    .Call(R_cpumat_linalg_crossprod, xpose, alpha, x$data_ptr(), ret$data_ptr())
  }
  else if (inherits(x, "gpumat"))
  {
    if (is.null(ret))
      ret = gpumat(x$get_card(), n, n)
    
    .Call(R_gpumat_linalg_crossprod, xpose, alpha, x$data_ptr(), ret$data_ptr())
  }
  else if (inherits(x, "mpimat"))
  {
    if (is.null(ret))
    {
      bfdim = x$bfdim()
      ret = mpimat(x$get_grid(), n, n, bfdim[1], bfdim[2])
    }
    
    .Call(R_mpimat_linalg_crossprod, xpose, alpha, x$data_ptr(), ret$data_ptr())
  }
  
  if (invisiret)
    invisible(ret)
  else
    ret
}



#' crossprod
#' 
#' Compute crossproducts.
#' 
#' @param x Input data.
#' @param ret Either \code{NULL} or an already allocated fml matrix of the same
#' class and type as \code{x}.
#' @param alpha Number to scale the crossproduct by.
#' @return Returns the crossproduct.
#' 
#' @rdname linalg-crossprod
#' @name crossprod
NULL

#' @rdname linalg-crossprod
#' @export
linalg_crossprod = function(x, ret=NULL, alpha=1)
{
  linalg_crossprods(x, ret, alpha, xpose=FALSE)
}

#' @rdname linalg-crossprod
#' @export
linalg_tcrossprod = function(x, ret=NULL, alpha=1)
{
  linalg_crossprods(x, ret, alpha, xpose=TRUE)
}
