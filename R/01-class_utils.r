is_cpumat = function(x) inherits(x, "cpumat")
is_cpuvec = function(x) inherits(x, "cpuvec")

is_gpuvec = function(x) inherits(x, "gpuvec")
is_gpumat = function(x) inherits(x, "gpumat")

fmlr_is_funs = c(is_cpumat, is_cpuvec, is_gpuvec, is_gpumat)


check_class_consistency = function(...)
{
  l = list(...)
  
  
  for (fun in fmlr_is_funs)
  {
    test = sapply(l, fun)
    if (any(fun))
    {
      if (all(fun))
        return(invisible(TRUE))
      else
        stop("inconsistent object usage")
    }
  }
}
