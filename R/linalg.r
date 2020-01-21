check_inputs = function(ret, ...)
{
  if (!is.null(ret))
  {
    check_class_consistency(ret, ...)
    check_type_consistency(ret, ...)
    invisiret = TRUE
  }
  else
  {
    check_class_consistency(...)
    check_type_consistency(...)
    invisiret = FALSE
  }
  
  invisiret
}



#' add
#' 
#' Add two matrices: `ret = alpha*x + beta*y`.
#' 
#' @param transx,transy Should x/y be transposed?
#' @param x,y Input data.
#' @param ret Either \code{NULL} or an already allocated fml matrix of the same
#' class and type as \code{x}.
#' @param alpha,beta Scalars.
#' @return Returns the matrix sum.
#' 
#' @rdname linalg-add
#' @name add
#' 
#' @useDynLib fmlr R_cpumat_linalg_add
#' @useDynLib fmlr R_gpumat_linalg_add
#' @useDynLib fmlr R_mpimat_linalg_add
#' @export
linalg_add = function(transx=FALSE, transy=FALSE, x, y, ret=NULL, alpha=1, beta=1)
{
  transx = as.logical(transx)
  transy = as.logical(transy)
  
  alpha = as.double(alpha)
  beta = as.double(beta)
  
  invisiret = check_inputs(ret, x, y)
  
  if (isTRUE(transx))
  {
    m = x$ncols()
    n = x$nrows()
  }
  else
  {
    m = x$nrows()
    n = x$ncols()
  }
  
  if (is_cpumat(x))
  {
    CFUN = R_cpumat_linalg_add
    if (is.null(ret))
      ret = cpumat(m, n, type=x$get_type_str())
  }
  else if (is_gpumat(x))
  {
    CFUN = R_gpumat_linalg_add
    if (is.null(ret))
      ret = gpumat(x$get_card(), m, n)
  }
  else if (is_mpimat(x))
  {
    CFUN = R_mpimat_linalg_add
    if (is.null(ret))
    {
      bfdim = x$bfdim()
      ret = mpimat(x$get_grid(), m, n, bfdim[1], bfdim[2], type=x$get_type_str())
    }
  }
  
  .Call(CFUN, x$get_type(), transx, transy, alpha, beta, x$data_ptr(), y$data_ptr(), ret$data_ptr())
  
  if (invisiret)
    invisible(ret)
  else
    ret
}



#' @useDynLib fmlr R_cpumat_linalg_crossprod
#' @useDynLib fmlr R_gpumat_linalg_crossprod
#' @useDynLib fmlr R_mpimat_linalg_crossprod
linalg_crossprods = function(x, ret, alpha, xpose)
{
  xpose = as.logical(xpose)
  alpha = as.double(alpha)
  
  invisiret = check_inputs(ret, x)
  
  if (isTRUE(xpose))
    n = x$nrows()
  else
    n = x$ncols()
  
  if (is_cpumat(x))
  {
    CFUN = R_cpumat_linalg_crossprod
    if (is.null(ret))
      ret = cpumat(n, n, type=x$get_type_str())
  }
  else if (is_gpumat(x))
  {
    CFUN = R_gpumat_linalg_crossprod
    if (is.null(ret))
      ret = gpumat(x$get_card(), n, n)
  }
  else if (is_mpimat(x))
  {
    CFUN = R_mpimat_linalg_crossprod
    if (is.null(ret))
    {
      bfdim = x$bfdim()
      ret = mpimat(x$get_grid(), n, n, bfdim[1], bfdim[2], type=x$get_type_str())
    }
  }
  
  .Call(CFUN, x$get_type(), xpose, alpha, x$data_ptr(), ret$data_ptr())
  
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
