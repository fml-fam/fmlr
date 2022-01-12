#' pca
#' 
#' Perform principal components analysis.
#' 
#' @param rm_mean,rm_sd Should the data be centered/scaled first? Operations
#' occur in-place.
#' @param x Input matrix. The input values are overwritten.
#' @param sdev The standard deviations for the principal components.
#' @param rot The pca loadings. If \code{NULL} is passed, then these will not
#' be calculated.
#' 
#' @examples
#' suppressMessages(library(fmlr))
#' x = cpumat(3, 2)
#' x$fill_linspace(1, 6)
#' 
#' s = cpuvec()
#' stats_pca(TRUE, TRUE, x, s)
#' s$info()
#' s$print()
#' 
#' @rdname pca
#' @name pca
#' 
#' @useDynLib fmlr R_stats_pca
#' 
#' @export
stats_pca = function(rm_mean=TRUE, rm_sd=FALSE, x, sdev, rot=NULL)
{
  check_is_mat(x)
  check_is_vec(sdev)
  
  check_backend_consistency(x, sdev)
  check_type_consistency(x, sdev)
  if (!is.null(rot))
    check_inputs(x, rot)
  
  rm_mean = as.logical(rm_mean)
  rm_sd = as.logical(rm_sd)
  
  if (is.null(rot))
    .Call(R_stats_pca, get_backend(x), x$get_type(), rm_mean, rm_sd, x$data_ptr(), sdev$data_ptr(), NULL)
  else
    .Call(R_stats_pca, get_backend(x), x$get_type(), rm_mean, rm_sd, x$data_ptr(), sdev$data_ptr(), rot$data_ptr())
  
  invisible(NULL)
}



#' Covariance and Correlation
#' 
#' Compute covariance and pearson correlation matrices.
#' 
#' @param x,y Input data.
#' @param ret The covariance/correlation matrix.
#' 
#' @rdname cov
#' @name cov
NULL

#' @rdname cov
#' @useDynLib fmlr R_stats_cov
#' @export
stats_cov = function(x, y=NULL, ret=NULL)
{
  check_is_mat(x)
  
  if (is.null(ret))
  {
    invisiret = FALSE
    ret = setret(x)
  }
  else
    invisiret = TRUE
  
  if (!is.null(y))
  {
    y_d = y$data_ptr()
    check_inputs(ret, x, y)
  }
  else
    y_d = NULL
  
  .Call(R_stats_cov, get_backend(x), x$get_type(), x$data_ptr(), y_d, ret$data_ptr())
  
  if (invisiret)
    invisible(ret)
  else
    ret
}

#' @rdname cov
#' @useDynLib fmlr R_stats_cor
#' @export
stats_cor = function(x, y=NULL, ret=NULL)
{
  check_is_mat(x)
  
  if (is.null(ret))
  {
    invisiret = FALSE
    ret = setret(x)
  }
  else
    invisiret = TRUE
  
  if (!is.null(y))
  {
    y_d = y$data_ptr()
    check_inputs(ret, x, y)
  }
  else
    y_d = NULL
  
  .Call(R_stats_cor, get_backend(x), x$get_type(), x$data_ptr(), y_d, ret$data_ptr())
  
  if (invisiret)
    invisible(ret)
  else
    ret
}
