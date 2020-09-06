#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/gpu/gpumat.hh>
#include <fml/gpu/dimops.hh>

using namespace fml;


template <typename REAL>
static inline void matsums(const bool row, const bool mean, void *x, void *s)
{
  CAST_MAT(gpumat, REAL, x_cast, x);
  CAST_MAT(gpuvec, REAL, s_cast, s);
  
  if (row)
  {
    if (mean)
      dimops::rowmeans(*x_cast, *s_cast);
    else
      dimops::rowsums(*x_cast, *s_cast);
  }
  else
  {
    if (mean)
      dimops::colmeans(*x_cast, *s_cast);
    else
      dimops::colsums(*x_cast, *s_cast);
  }
}

extern "C" SEXP R_gpumat_dimops_matsums(SEXP type, SEXP row, SEXP mean, SEXP x_robj, SEXP s_robj)
{
  void *x = getRptr(x_robj);
  void *s = getRptr(s_robj);
  APPLY_TEMPLATED_FUNCTION(type, matsums, INT(row), INT(mean), x, s);
  
  return R_NilValue;
}



template <typename REAL>
static inline void scale(const bool rm_mean, const bool rm_sd, void *x)
{
  CAST_MAT(gpumat, REAL, x_cast, x);
  dimops::scale(rm_mean, rm_sd, *x_cast);
}

extern "C" SEXP R_gpumat_dimops_scale(SEXP type, SEXP rm_mean, SEXP rm_sd, SEXP x_robj)
{
  void *x = getRptr(x_robj);
  APPLY_TEMPLATED_FUNCTION(type, scale, INT(rm_mean), INT(rm_sd), x);
  
  return R_NilValue;
}
