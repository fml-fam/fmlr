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
  check_is_mat(x)
  check_is_mat(y)
  
  transx = as.logical(transx)
  transy = as.logical(transy)
  
  alpha = as.double(alpha)
  beta = as.double(beta)
  
  invisiret = check_inputs(ret, x, y)
  
  CFUN = get_cfun(x, "linalg", "add")
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
#' @name matmult
#' 
#' @useDynLib fmlr R_cpumat_linalg_matmult
#' @useDynLib fmlr R_gpumat_linalg_matmult
#' @useDynLib fmlr R_mpimat_linalg_matmult
#' 
#' @export
linalg_matmult = function(transx=FALSE, transy=FALSE, alpha=1, x, y, ret=NULL)
{
  check_is_mat(x)
  check_is_mat(y)
  
  transx = as.logical(transx)
  transy = as.logical(transy)
  
  alpha = as.double(alpha)
  
  invisiret = check_inputs(ret, x, y)
  
  CFUN = get_cfun(x, "linalg", "matmult")
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
  check_is_mat(x)
  
  xpose = as.logical(xpose)
  alpha = as.double(alpha)
  
  invisiret = check_inputs(ret, x)
  
  CFUN = get_cfun(x, "linalg", "crossprod")
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
  check_is_mat(x)
  invisiret = check_inputs(ret, x)
  
  CFUN = get_cfun(x, "linalg", "xpose")
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
  check_is_mat(x)
  CFUN = get_cfun(x, "linalg", "lu")
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
  check_is_mat(x)
  CFUN = get_cfun(x, "linalg", "trace")
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
  check_is_mat(x)
  check_is_vec(s)
  
  check_type_consistency(x, s)
  if (!is.null(u) && !is.null(vt))
    check_inputs(x, u, vt)
  else if (!is.null(u) || !is.null(vt))
    stop("must pass neither u and vt or both u and vt")
  
  CFUN = get_cfun(x, "linalg", "svd")
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
  check_is_mat(x)
  check_is_vec(values)
  check_type_consistency(x, values)
  if (!is.null(vectors))
    check_inputs(x, vectors)
  
  CFUN = get_cfun(x, "linalg", "eigen_sym")
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
  check_is_mat(x)
  CFUN = get_cfun(x, "linalg", "invert")
  .Call(CFUN, x$get_type(), x$data_ptr())
  invisible(NULL)
}



#' solve
#' 
#' Solve a system of equations.
#' 
#' @param x Input data. The input values are overwritten.
#' @param y The RHS, overwritten by the solution.
#' 
#' @rdname linalg-solve
#' @name solve
#' @useDynLib fmlr R_cpumat_linalg_solve
#' @useDynLib fmlr R_gpumat_linalg_solve
#' @useDynLib fmlr R_mpimat_linalg_solve
#' 
#' @export
linalg_solve = function(x, y)
{
  check_is_mat(x)
  check_type_consistency(x, y)
  
  if (is_vec(y))
  {
    if (is_mpimat(x))
      stop("can not mix vector with mpimat")
    
    class = CLASS_VEC
  }
  else
  {
    check_class_consistency(x, y)
    class = CLASS_MAT
  }
  
  CFUN = get_cfun(x, "linalg", "solve")
  .Call(CFUN, x$get_type(), x$data_ptr(), class, y$data_ptr())
  
  invisible(NULL)
}



#' qr
#' 
#' Computes the compact QR factorization.
#' 
#' @param x Input data. The input values are overwritten.
#' @param qraux Auxilliary data for the compact QR.
#' 
#' @rdname linalg-qr
#' @name qr
#' @useDynLib fmlr R_cpumat_linalg_qr
#' @useDynLib fmlr R_gpumat_linalg_qr
#' @useDynLib fmlr R_mpimat_linalg_qr
#' 
#' @export
linalg_qr = function(x, qraux)
{
  check_is_mat(x)
  check_is_vec(qraux)
  check_type_consistency(x, qraux)
  
  CFUN = get_cfun(x, "linalg", "qr")
  .Call(CFUN, x$get_type(), x$data_ptr(), qraux$data_ptr())
  
  invisible(NULL)
}



#' qr_Q
#' 
#' Computes the Q matrix from the compact QR factorization.
#' 
#' @param QR The compact QR factorization. The return from \code{qr()}.
#' @param qraux Auxilliary data for the compact QR.
#' @param Q The output Q matrix.
#' @param work A workspace vector.
#' 
#' @rdname linalg-qr-Q
#' @name qr_Q
#' @useDynLib fmlr R_cpumat_linalg_qr_Q
#' @useDynLib fmlr R_gpumat_linalg_qr_Q
#' @useDynLib fmlr R_mpimat_linalg_qr_Q
#' 
#' @export
linalg_qr_Q = function(QR, qraux, Q, work)
{
  check_inputs(QR, Q)
  check_is_vec(qraux)
  check_is_vec(work)
  check_type_consistency(QR, qraux, work)
  
  CFUN = get_cfun(x, "linalg", "qr_Q")
  .Call(CFUN, QR$get_type(), QR$data_ptr(), qraux$data_ptr(), Q$data_ptr(), work$data_ptr())
  
  invisible(NULL)
}



#' qr_R
#' 
#' Computes the R matrix from the compact QR factorization.
#' 
#' @param QR The compact QR factorization. The return from \code{qr()}.
#' @param R The output R matrix.
#' 
#' @rdname linalg-qr-R
#' @name qr_R
#' @useDynLib fmlr R_cpumat_linalg_qr_R
#' @useDynLib fmlr R_gpumat_linalg_qr_R
#' @useDynLib fmlr R_mpimat_linalg_qr_R
#' 
#' @export
linalg_qr_R = function(QR, R)
{
  check_inputs(QR, R)
  
  CFUN = get_cfun(x, "linalg", "qr_R")
  .Call(CFUN, QR$get_type(), QR$data_ptr(), R$data_ptr())
  
  invisible(NULL)
}



#' lq
#' 
#' Computes the compact LQ factorization.
#' 
#' @param x Input data. The input values are overwritten.
#' @param lqaux Auxilliary data for the compact LQ.
#' 
#' @rdname linalg-lq
#' @name lq
#' @useDynLib fmlr R_cpumat_linalg_lq
#' @useDynLib fmlr R_gpumat_linalg_lq
#' @useDynLib fmlr R_mpimat_linalg_lq
#' 
#' @export
linalg_lq = function(x, lqaux)
{
  check_is_mat(x)
  check_is_vec(lqaux)
  check_type_consistency(x, lqaux)
  
  CFUN = get_cfun(x, "linalg", "lq")
  .Call(CFUN, x$get_type(), x$data_ptr(), lqaux$data_ptr())
  
  invisible(NULL)
}



#' lq_L
#' 
#' Computes the L matrix from the compact LQ factorization.
#' 
#' @param LQ The compact LQ factorization. The return from \code{lq()}.
#' @param L The output L matrix.
#' 
#' @rdname linalg-qr-R
#' @name lq_L
#' @useDynLib fmlr R_cpumat_linalg_lq_L
#' @useDynLib fmlr R_gpumat_linalg_lq_L
#' @useDynLib fmlr R_mpimat_linalg_lq_L
#' 
#' @export
linalg_lq_L = function(LQ, L)
{
  check_inputs(LQ, L)
  
  CFUN = get_cfun(x, "linalg", "lq_L")
  .Call(CFUN, LQ$get_type(), LQ$data_ptr(), L$data_ptr())
  
  invisible(NULL)
}



#' lq_Q
#' 
#' Computes the Q matrix from the compact LQ factorization.
#' 
#' @param LQ The compact LQ factorization. The return from \code{lq()}.
#' @param lqaux Auxilliary data for the compact LQ.
#' @param Q The output Q matrix.
#' @param work A workspace vector.
#' 
#' @rdname linalg-lq-Q
#' @name lq_Q
#' @useDynLib fmlr R_cpumat_linalg_lq_Q
#' @useDynLib fmlr R_gpumat_linalg_lq_Q
#' @useDynLib fmlr R_mpimat_linalg_lq_Q
#' 
#' @export
linalg_lq_Q = function(LQ, lqaux, Q, work)
{
  check_inputs(LQ, Q)
  check_is_vec(lqaux)
  check_is_vec(work)
  check_type_consistency(LQ, lqaux, work)
  
  CFUN = get_cfun(x, "linalg", "lq_Q")
  .Call(CFUN, LQ$get_type(), LQ$data_ptr(), lqaux$data_ptr(), Q$data_ptr(), work$data_ptr())
  
  invisible(NULL)
}
