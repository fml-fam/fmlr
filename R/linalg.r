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



setret = function(x)
{
  if (is_cpumat(x))
    ret = cpumat(type=x$get_type_str())
  else if (is_gpumat(x))
    ret = gpumat(x$get_card(), type=x$get_type_str())
  else if (is_mpimat(x))
  {
    bfdim = x$bfdim()
    ret = mpimat(x$get_grid(), bf_rows=bfdim[1], bf_cols=bfdim[2], type=x$get_type_str())
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
  
  CFUN = get_cfun("add", x)
  if (is.null(ret))
    ret = setret(x)
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
  
  CFUN = get_cfun("matmult", x)
  if (is.null(ret))
    ret = setret(x)
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
  
  CFUN = get_cfun("crossprod", x)
  if (is.null(ret))
    ret = setret(x)
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
  
  CFUN = get_cfun("xpose", x)
  if (is.null(ret))
    ret = setret(x)
  .Call(CFUN, x$get_type(), x$data_ptr(), ret$data_ptr())
  
  if (invisiret)
    invisible(ret)
  else
    ret
}



#' lu
#' 
#' LU factorization. The factorization occurs in-place.
#' 
#' @param x Input data, overwritten by its LU factorization.
#' @return Returns `NULL`.
#' 
#' @rdname linalg-lu
#' @name lu
#' @useDynLib fmlr R_cpumat_linalg_lu
#' @useDynLib fmlr R_gpumat_linalg_lu
#' @useDynLib fmlr R_mpimat_linalg_lu
#' 
#' @export
linalg_lu = function(x)
{
  CFUN = get_cfun("lu", x)
  .Call(CFUN, x$get_type(), x$data_ptr())
  invisible(NULL)
}



#' trace
#' 
#' Matrix trace, i.e. theh sum of the diagonal elements.
#' 
#' @param x Input data.
#' @return Returns the trace.
#' 
#' @rdname linalg-trace
#' @name trace
#' @useDynLib fmlr R_cpumat_linalg_trace
#' @useDynLib fmlr R_gpumat_linalg_trace
#' @useDynLib fmlr R_mpimat_linalg_trace
#' 
#' @export
linalg_trace = function(x)
{
  CFUN = get_cfun("trace", x)
  .Call(CFUN, x$get_type(), x$data_ptr())
}



#' svd
#' 
#' Computes the singular value decomposition.
#' 
#' @details
#' You will need to initialize the return objects `s` and/or `u` and `vt`
#' manually. See the example.
#' 
#' @param x Input data. The input values are overwritten.
#' @param s Singular values.
#' @param u,vt The left/right singular vectors. Should both be `NULL` or
#' matrices of the same backend and fundamental type as `x`.
#' 
#' @examples
#' suppressMessages(library(fmlr))
#' x = cpumat(3, 2)
#' x$fill_linspace(1, 6)
#' 
#' s = cpuvec()
#' linalg_svd(x, s)
#' s$info()
#' s$print()
#' 
#' @rdname linalg-svd
#' @name svd
#' @useDynLib fmlr R_cpumat_linalg_svd
#' @useDynLib fmlr R_gpumat_linalg_svd
#' @useDynLib fmlr R_mpimat_linalg_svd
#' 
#' @export
linalg_svd = function(x, s, u=NULL, vt=NULL)
{
  check_type_consistency(x, s)
  if (!is.null(u) && !is.null(vt))
    check_inputs(x, u, vt)
  else if (!is.null(u) || !is.null(vt))
    stop("must pass neither u and vt or both u and vt")
  
  CFUN = get_cfun("svd", x)
  if (is.null(u))
    .Call(CFUN, x$get_type(), x$data_ptr(), s$data_ptr(), NULL, NULL)
  else
    .Call(CFUN, x$get_type(), x$data_ptr(), s$data_ptr(), u$data_ptr(), vt$data_ptr())
  
  invisible(NULL)
}



#' eigen
#' 
#' Computes the eigenvalues and/or eigenvectors
#' 
#' @details
#' You will need to initialize the return objects `values` and/or `vectors`
#' manually. See the example.
#' 
#' @param x Input data. The input values are overwritten.
#' @param values The eigenvalues.
#' @param vectors The eigenvectors.
#' 
#' @rdname linalg-eigen
#' @name eigen
#' @useDynLib fmlr R_cpumat_linalg_eigen_sym
#' @useDynLib fmlr R_gpumat_linalg_eigen_sym
#' @useDynLib fmlr R_mpimat_linalg_eigen_sym
#' 
#' @export
linalg_eigen_sym = function(x, values, vectors=NULL)
{
  d = x$dim()
  if (d[1] != d[2])
    stop("'x' must be square")
  
  check_type_consistency(x, values)
  if (!is.null(vectors))
    check_inputs(x, vectors)
  
  CFUN = get_cfun("eigen_sym", x)
  if (is.null(vectors))
    .Call(CFUN, x$get_type(), x$data_ptr(), values$data_ptr(), NULL)
  else
    .Call(CFUN, x$get_type(), x$data_ptr(), values$data_ptr(), vectors$data_ptr())
  
  invisible(NULL)
}



#' invert
#' 
#' Invert a matrix.
#' 
#' @param x Input data, overwritten by the inverse.
#' @return Returns `NULL`.
#' 
#' @rdname linalg-invert
#' @name invert
#' @useDynLib fmlr R_cpumat_linalg_invert
#' @useDynLib fmlr R_gpumat_linalg_invert
#' @useDynLib fmlr R_mpimat_linalg_invert
#' 
#' @export
linalg_invert = function(x)
{
  d = x$dim()
  if (d[1] != d[2])
    stop("'x' must be square")
  
  CFUN = get_cfun("invert", x)
  .Call(CFUN, x$get_type(), x$data_ptr())
  invisible(NULL)
}
