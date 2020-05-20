#include "apply.hpp"
#include "extptr.h"
#include "types.h"

#include <fml/src/mpi/mpimat.hh>
#include <fml/src/mpi/dimops.hh>


template <typename REAL>
static inline void matsums(bool row, bool mean, void *x, void *s)
{
  CAST_MAT(mpimat, REAL, x_cast, x);
  CAST_MAT(cpuvec, REAL, s_cast, s);
  
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

extern "C" SEXP R_mpimat_dimops_matsums(SEXP type, SEXP row, SEXP mean, SEXP x_robj, SEXP s_robj)
{
  void *x = getRptr(x_robj);
  void *s = getRptr(s_robj);
  APPLY_TEMPLATED_FUNCTION(type, matsums, INT(row), INT(mean), x, s);
  
  return R_NilValue;
}
