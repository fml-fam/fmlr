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



get_cfun = function(cfun_post, x)
{
  if (is_cpumat(x))
    cfun_pre = "R_cpumat_linalg_"
  else if (is_gpumat(x))
    cfun_pre = "R_gpumat_linalg_"
  else if (is_mpimat(x))
    cfun_pre = "R_mpimat_linalg_"
  
  CFUN = eval(parse(text=paste0(cfun_pre, cfun_post)))
  CFUN
}



setret = function(m, n, x)
{
  if (is_cpumat(x))
    ret = cpumat(m, n, type=x$get_type_str())
  else if (is_gpumat(x))
    ret = gpumat(x$get_card(), m, n)
  else if (is_mpimat(x))
  {
    bfdim = x$bfdim()
    ret = mpimat(x$get_grid(), m, n, bfdim[1], bfdim[2], type=x$get_type_str())
  }
  
  ret
}



#' add
#' 
#' Add two matrices: `ret = alpha*x + beta*y`.
#' 
#' @param transx,transy Should x/y be transposed?
#' @param alpha,beta Scalars.
#' @param x,y Input data.
#' @param ret Either \code{NULL} or an already allocated fml matrix of the same
#' class and type as \code{x}.
#' @return Returns the matrix sum.
#' 
#' @rdname linalg-add
#' @name add
#' 
#' @useDynLib fmlr R_cpumat_linalg_add
#' @useDynLib fmlr R_gpumat_linalg_add
#' @useDynLib fmlr R_mpimat_linalg_add
#' 
#' @export
linalg_add = function(transx=FALSE, transy=FALSE, alpha=1, beta=1, x, y, ret=NULL)
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
  
  CFUN = get_cfun("add", x)
  if (is.null(ret))
    ret = setret(m, n, x)
  .Call(CFUN, x$get_type(), transx, transy, alpha, beta, x$data_ptr(), y$data_ptr(), ret$data_ptr())
  
  if (invisiret)
    invisible(ret)
  else
    ret
}



#' matmult
#' 
#' Multiply two matrices: `ret = alpha*x*y`.
#' 
#' @param transx,transy Should x/y be transposed?
#' @param alpha Scalar.
#' @param x,y Input data.
#' @param ret Either \code{NULL} or an already allocated fml matrix of the same
#' class and type as \code{x}.
#' @return Returns the matrix product.
#' 
#' @rdname linalg-matmult
#' @name add
#' 
#' @useDynLib fmlr R_cpumat_linalg_matmult
#' @useDynLib fmlr R_gpumat_linalg_matmult
#' @useDynLib fmlr R_mpimat_linalg_matmult
#' 
#' @export
linalg_matmult = function(transx=FALSE, transy=FALSE, alpha=1, x, y, ret=NULL)
{
  transx = as.logical(transx)
  transy = as.logical(transy)
  
  alpha = as.double(alpha)
  
  invisiret = check_inputs(ret, x, y)
  
  if (!isTRUE(transx))
    m = x$nrows()
  else
    m = x$ncols()
  
  if (!isTRUE(transy))
    n = y$ncols()
  else
    n = y$nrows()
  
  CFUN = get_cfun("matmult", x)
  if (is.null(ret))
    ret = setret(m, n, x)
  .Call(CFUN, x$get_type(), transx, transy, alpha, x$data_ptr(), y$data_ptr(), ret$data_ptr())
  
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
  
  CFUN = get_cfun("crossprod", x)
  if (is.null(ret))
    ret = setret(m, n, x)
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
#' @param alpha Number to scale the crossproduct by.
#' @param x Input data.
#' @param ret Either \code{NULL} or an already allocated fml matrix of the same
#' class and type as \code{x}.
#' @return Returns the crossproduct.
#' 
#' @rdname linalg-crossprod
#' @name crossprod
NULL

#' @rdname linalg-crossprod
#' @export
linalg_crossprod = function(alpha=1, x, ret=NULL)
{
  linalg_crossprods(x, ret, alpha, xpose=FALSE)
}

#' @rdname linalg-crossprod
#' @export
linalg_tcrossprod = function(alpha=1, x, ret=NULL)
{
  linalg_crossprods(x, ret, alpha, xpose=TRUE)
}



#' xpose
#' 
#' Matrix transpose.
#' 
#' @param x Input data.
#' @param ret Either \code{NULL} or an already allocated fml matrix of the same
#' class and type as \code{x}.
#' @return Returns the xpose.
#' 
#' @rdname linalg-xpose
#' @name xpose
#' @useDynLib fmlr R_cpumat_linalg_xpose
#' @useDynLib fmlr R_gpumat_linalg_xpose
#' @useDynLib fmlr R_mpimat_linalg_xpose
#' 
#' @export
linalg_xpose = function(x, ret=NULL)
{
  invisiret = check_inputs(ret, x)
  
  m = x$ncols()
  n = x$nrows()
  
  CFUN = get_cfun("xpose", x)
  if (is.null(ret))
    ret = setret(m, n, x)
  .Call(CFUN, x$get_type(), x$data_ptr(), ret$data_ptr())
  
  if (invisiret)
    invisible(ret)
  else
    ret
}
