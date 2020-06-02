setret = function(x, vec=FALSE)
{
  if (is_cpumat(x))
  {
    if (vec)
      ret = cpuvec(type=x$get_type_str())
    else
      ret = cpumat(type=x$get_type_str())
  }
  else if (is_gpumat(x))
  {
    if (vec)
      ret = gpuvec(x$get_card(), type=x$get_type_str())
    else
      ret = gpumat(x$get_card(), type=x$get_type_str())
  }
  else if (is_mpimat(x))
  {
    if (vec)
      ret = cpuvec(type=x$get_type_str())
    else
    {
      bfdim = x$bfdim()
      ret = mpimat(x$get_grid(), bf_rows=bfdim[1], bf_cols=bfdim[2], type=x$get_type_str())
    }
  }
  
  ret
}
