check_class_consistency = function(...)
{
  l = list(...)
  if (all(sapply(l, is_cpumat)))
    invisible(TRUE)
  else
    stop("")
}


linalg_crossprods = function(x, ret, alpha, xpose)
{
  if (!is.null(ret))
  {
    check_class_consistency(x, ret)
    invisiret = TRUE
  }
  else
    invisiret = FALSE
  
  if (inherits(x, "cpumat"))
  {
    if (is.null(ret))
    {
      n = x$ncols()
      ret = cpumat(n, n)
    }
    
    cpumat_linalg_crossprod(xpose, alpha, x$data_ptr(), ret$data_ptr())
  }
  
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
