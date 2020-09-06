#' add
#' 
#' Add two matrices: \code{ret = alpha*x + beta*y}.
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
#' @useDynLib fmlr R_linalg_add
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
  
  if (is.null(ret))
    ret = setret(x)
  
  .Call(R_linalg_add, get_backend(x), x$get_type(), transx, transy, alpha, beta, x$data_ptr(), y$data_ptr(), ret$data_ptr())
  
  if (invisiret)
    invisible(ret)
  else
    ret
}



#' matmult
#' 
#' Multiply two matrices: \code{ret = alpha*x*y}.
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
#' @useDynLib fmlr R_linalg_matmult
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
  
  if (is.null(ret))
    ret = setret(x)
  
  .Call(R_linalg_matmult, get_backend(x), x$get_type(), transx, transy, alpha, x$data_ptr(), y$data_ptr(), ret$data_ptr())
  
  if (invisiret)
    invisible(ret)
  else
    ret
}



#' @useDynLib fmlr R_linalg_crossprod
linalg_crossprods = function(x, ret, alpha, xpose)
{
  check_is_mat(x)
  
  xpose = as.logical(xpose)
  alpha = as.double(alpha)
  
  invisiret = check_inputs(ret, x)
  
  if (is.null(ret))
    ret = setret(x)
  
  .Call(R_linalg_crossprod, get_backend(x), x$get_type(), xpose, alpha, x$data_ptr(), ret$data_ptr())
  
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
#' @useDynLib fmlr R_linalg_xpose
#' 
#' @export
linalg_xpose = function(x, ret=NULL)
{
  check_is_mat(x)
  invisiret = check_inputs(ret, x)
  
  if (is.null(ret))
    ret = setret(x)
  
  .Call(R_linalg_xpose, get_backend(x), x$get_type(), x$data_ptr(), ret$data_ptr())
  
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
#' @return Returns \code{NULL}.
#' 
#' @rdname linalg-lu
#' @name lu
#' @useDynLib fmlr R_linalg_lu
#' 
#' @export
linalg_lu = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_lu, get_backend(x), x$get_type(), x$data_ptr())
  invisible(NULL)
}



#' det
#' 
#' Determinant
#' 
#' @param x Input data, overwritten by its LU factorization.
#' 
#' @return Returns a list containing the modulus and the sign.
#' 
#' @rdname linalg-det
#' @name det
#' @useDynLib fmlr R_linalg_det
#' 
#' @export
linalg_det = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_det, get_backend(x), x$get_type(), x$data_ptr())
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
#' @useDynLib fmlr R_linalg_trace
#' 
#' @export
linalg_trace = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_trace, get_backend(x), x$get_type(), x$data_ptr())
}



#' svd
#' 
#' Computes the singular value decomposition.
#' 
#' @details
#' You will need to initialize the return objects \code{s} and/or \code{u} and
#' \code{vt}.
#' manually. See the example.
#' 
#' @param x Input data. The input values are overwritten.
#' @param s Singular values.
#' @param u,vt The left/right singular vectors. Should both be \code{NULL} or
#' matrices of the same backend and fundamental type as \code{x}.
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
#' @useDynLib fmlr R_linalg_svd
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
  
  if (is.null(u))
    .Call(R_linalg_svd, get_backend(x), x$get_type(), x$data_ptr(), s$data_ptr(), NULL, NULL)
  else
    .Call(R_linalg_svd, get_backend(x), x$get_type(), x$data_ptr(), s$data_ptr(), u$data_ptr(), vt$data_ptr())
  
  invisible(NULL)
}



#' eigen
#' 
#' Computes the eigenvalues and/or eigenvectors
#' 
#' @details
#' You will need to initialize the return objects \code{values} and/or
#' \code{vectors}.
#' manually. See the example.
#' 
#' @param x Input data. The input values are overwritten.
#' @param values The eigenvalues.
#' @param vectors The eigenvectors.
#' 
#' @rdname linalg-eigen
#' @name eigen
#' @useDynLib fmlr R_linalg_eigen_sym
#' 
#' @export
linalg_eigen_sym = function(x, values, vectors=NULL)
{
  check_is_mat(x)
  check_is_vec(values)
  check_type_consistency(x, values)
  if (!is.null(vectors))
    check_inputs(x, vectors)
  
  if (is.null(vectors))
    .Call(R_linalg_eigen_sym, get_backend(x), x$get_type(), x$data_ptr(), values$data_ptr(), NULL)
  else
    .Call(R_linalg_eigen_sym, get_backend(x), x$get_type(), x$data_ptr(), values$data_ptr(), vectors$data_ptr())
  
  invisible(NULL)
}



#' invert
#' 
#' Invert a matrix.
#' 
#' @param x Input data, overwritten by the inverse.
#' @return Returns \code{NULL}.
#' 
#' @rdname linalg-invert
#' @name invert
#' @useDynLib fmlr R_linalg_invert
#' 
#' @export
linalg_invert = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_invert, get_backend(x), x$get_type(), x$data_ptr())
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
#' @useDynLib fmlr R_linalg_solve
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
  
  .Call(R_linalg_solve, get_backend(x), x$get_type(), x$data_ptr(), class, y$data_ptr())
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
#' @useDynLib fmlr R_linalg_qr
#' 
#' @export
linalg_qr = function(x, qraux)
{
  check_is_mat(x)
  check_is_vec(qraux)
  check_type_consistency(x, qraux)
  
  .Call(R_linalg_qr, get_backend(x), x$get_type(), x$data_ptr(), qraux$data_ptr())
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
#' @useDynLib fmlr R_linalg_qr_Q
#' 
#' @export
linalg_qr_Q = function(QR, qraux, Q, work)
{
  check_inputs(QR, Q)
  check_is_vec(qraux)
  check_is_vec(work)
  check_type_consistency(QR, qraux, work)
  
  .Call(R_linalg_qr_Q, get_backend(QR), QR$get_type(), QR$data_ptr(), qraux$data_ptr(), Q$data_ptr(), work$data_ptr())
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
#' @useDynLib fmlr R_linalg_qr_R
#' 
#' @export
linalg_qr_R = function(QR, R)
{
  check_inputs(QR, R)
  .Call(R_linalg_qr_R, get_backend(QR), QR$get_type(), QR$data_ptr(), R$data_ptr())
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
#' @useDynLib fmlr R_linalg_lq
#' 
#' @export
linalg_lq = function(x, lqaux)
{
  check_is_mat(x)
  check_is_vec(lqaux)
  check_type_consistency(x, lqaux)
  
  .Call(R_linalg_lq, get_backend(x), x$get_type(), x$data_ptr(), lqaux$data_ptr())
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
#' @useDynLib fmlr R_linalg_lq_L
#' 
#' @export
linalg_lq_L = function(LQ, L)
{
  check_inputs(LQ, L)
  .Call(R_linalg_lq_L, get_backend(LQ), LQ$get_type(), LQ$data_ptr(), L$data_ptr())
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
#' @useDynLib fmlr R_linalg_lq_Q
#' 
#' @export
linalg_lq_Q = function(LQ, lqaux, Q, work)
{
  check_inputs(LQ, Q)
  check_is_vec(lqaux)
  check_is_vec(work)
  check_type_consistency(LQ, lqaux, work)
  
  .Call(R_linalg_lq_Q, get_backend(LQ), LQ$get_type(), LQ$data_ptr(), lqaux$data_ptr(), Q$data_ptr(), work$data_ptr())
  invisible(NULL)
}



#' qrsvd
#' 
#' QR/LQ-based SVD. Useful for very tall/skinny or short/wide data.
#' 
#' @param x Input data. The input values are overwritten.
#' @param s Singular values.
#' @param u,vt The left/right singular vectors. Should both be \code{NULL} or
#' matrices of the same backend and fundamental type as \code{x}.
#' 
#' @rdname linalg-qrsvd
#' @name qrsvd
#' @useDynLib fmlr R_linalg_qrsvd
#' 
#' @export
linalg_qrsvd = function(x, s, u=NULL, vt=NULL)
{
  check_is_mat(x)
  check_is_vec(s)
  
  check_type_consistency(x, s)
  if (!is.null(u) && !is.null(vt))
    check_inputs(x, u, vt)
  else if (!is.null(u) || !is.null(vt))
    stop("must pass neither u and vt or both u and vt")
  
  if (is.null(u))
    .Call(R_linalg_qrsvd, get_backend(x), x$get_type(), x$data_ptr(), s$data_ptr(), NULL, NULL)
  else
    .Call(R_linalg_qrsvd, get_backend(x), x$get_type(), x$data_ptr(), s$data_ptr(), u$data_ptr(), vt$data_ptr())
  
  invisible(NULL)
}



#' cpsvd
#' 
#' "Crossproducts" SVD.
#' 
#' @details
#' Computes the approximate SVD via the eigenvalue decomposition of
#' \code{crossprod(x)} if the input is tall/skinny and \code{tcrossprod(x)}
#' otherwise.
#' 
#' @param x Input data. The input values are overwritten.
#' @param s Singular values.
#' @param u,vt The left/right singular vectors. Should both be \code{NULL} or
#' matrices of the same backend and fundamental type as \code{x}.
#' 
#' @rdname linalg-cpsvd
#' @name cpsvd
#' @useDynLib fmlr R_linalg_cpsvd
#' 
#' @export
linalg_cpsvd = function(x, s, u=NULL, vt=NULL)
{
  check_is_mat(x)
  check_is_vec(s)
  
  check_type_consistency(x, s)
  if (!is.null(u) && !is.null(vt))
    check_inputs(x, u, vt)
  else if (!is.null(u) || !is.null(vt))
    stop("must pass neither u and vt or both u and vt")
  
  if (is.null(u))
    .Call(R_linalg_cpsvd, get_backend(x), x$get_type(), x$data_ptr(), s$data_ptr(), NULL, NULL)
  else
    .Call(R_linalg_cpsvd, get_backend(x), x$get_type(), x$data_ptr(), s$data_ptr(), u$data_ptr(), vt$data_ptr())
  
  invisible(NULL)
}



#' chol
#' 
#' Compute the lower-triangular Cholesky factor.
#' 
#' @param x Input data, overwritten by the inverse.
#' @return Returns \code{NULL}.
#' 
#' @rdname linalg-chol
#' @name chol
#' @useDynLib fmlr R_linalg_chol
#' 
#' @export
linalg_chol = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_chol, get_backend(x), x$get_type(), x$data_ptr())
  invisible(NULL)
}



#' norms
#' 
#' Norms.
#' 
#' @param x Input data. The data is un-modified except for \code{norm_2()}.
#' 
#' @return The requested norm.
#' 
#' @rdname linalg-norm
#' @name norm
#' 
#' @useDynLib fmlr R_linalg_norm
NULL

#' @rdname linalg-norm
#' @export
linalg_norm_1 = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_norm, get_backend(x), x$get_type(), x$data_ptr(), "1")
}

#' @rdname linalg-norm
#' @export
linalg_norm_I = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_norm, get_backend(x), x$get_type(), x$data_ptr(), "I")
}

#' @rdname linalg-norm
#' @export
linalg_norm_F = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_norm, get_backend(x), x$get_type(), x$data_ptr(), "F")
}

#' @rdname linalg-norm
#' @export
linalg_norm_M = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_norm, get_backend(x), x$get_type(), x$data_ptr(), "M")
}

#' @rdname linalg-norm
#' @export
linalg_norm_2 = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_norm, get_backend(x), x$get_type(), x$data_ptr(), "2")
}



#' Condition Number
#' 
#' Condition numbers.
#' 
#' @param x Input data. The data is modified in each case.
#' 
#' @return The requested condition number.
#' 
#' @rdname linalg-cond
#' @name cond
#' 
#' @useDynLib fmlr R_linalg_cond
NULL

#' @rdname linalg-cond
#' @export
linalg_cond_1 = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_cond, get_backend(x), x$get_type(), x$data_ptr(), "1")
}

#' @rdname linalg-cond
#' @export
linalg_cond_I = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_cond, get_backend(x), x$get_type(), x$data_ptr(), "I")
}

#' @rdname linalg-cond
#' @export
linalg_cond_2 = function(x)
{
  check_is_mat(x)
  .Call(R_linalg_cond, get_backend(x), x$get_type(), x$data_ptr(), "2")
}



#' dot
#' 
#' Compute vector dot product i.e. \code{sum(x*y)}.
#' 
#' @param x,y Input data.
#' class and type as \code{x}.
#' @return Returns the dot product.
#' 
#' @rdname linalg-dot
#' @name dot
#' 
#' @useDynLib fmlr R_linalg_dot
#' 
#' @export
linalg_dot = function(x, y=NULL)
{
  check_is_vec(x)
  
  if (!is.null(y))
  {
    check_is_vec(y)
    check_backend_consistency(x, y)
    .Call(R_linalg_dot, get_backend(x), x$get_type(), x$data_ptr(), y$data_ptr())
  }
  else
    .Call(R_linalg_dot, get_backend(x), x$get_type(), x$data_ptr(), NULL)
}



#' trinv
#' 
#' Invert a triangular matrix.
#' 
#' @param upper Is the matrix upper triangular? Otherwise only the lower
#' triangle will be referenced.
#' @param unit_diag Is the matrix unit diagonal?
#' @param x Input data, overwritten by the inverse.
#' @return Returns \code{NULL}.
#' 
#' @rdname linalg-trinv
#' @name trinv
#' @useDynLib fmlr R_linalg_trinv
#' 
#' @export
linalg_trinv = function(upper, unit_diag, x)
{
  check_is_mat(x)
  
  upper = as.logical(upper)
  unit_diag = as.logical(unit_diag)
  
  .Call(R_linalg_trinv, get_backend(x), x$get_type(), upper, unit_diag, x$data_ptr())
  invisible(NULL)
}
