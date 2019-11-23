linalg_crossprods = function(x, ret, alpha, xpose)
{
  if (inherits(x, "cpumat"))
  {
    if (is.null(ret))
    {
      n = x$ncols()
      ret = cpumat(n, n)
      invisiret = FALSE
    }
    else if (!inherits(ret, "cpumat"))
      stop("")
    else
      invisiret = TRUE
    
    cpumat_linalg_crossprod(xpose, alpha, x$data_ptr(), ret$data_ptr())
  }
  else
    stop("")
  
  if (invisiret)
    invisible(ret)
  else
    ret
}



#' @export
linalg_crossprod = function(x, ret=NULL, alpha=1)
{
  linalg_crossprods(x, ret, alpha, xpose=FALSE)
}

#' @export
linalg_tcrossprod = function(x, ret=NULL, alpha=1)
{
  linalg_crossprods(x, ret, alpha, xpose=TRUE)
}
