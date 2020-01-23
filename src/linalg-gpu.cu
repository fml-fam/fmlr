#include "apply.hpp"
#include "extptr.h"
#include "types.h"

#include <fml/src/gpu/card.hh>
#include <fml/src/gpu/gpuhelpers.hh>
#include <fml/src/gpu/gpumat.hh>
#include <fml/src/gpu/linalg.hh>


template <typename REAL>
static inline void add(bool transx, bool transy, REAL alpha, REAL beta, void *x, void *y, void *ret)
{
  CAST_MAT(gpumat, REAL, x_cast, x);
  CAST_MAT(gpumat, REAL, y_cast, y);
  CAST_MAT(gpumat, REAL, ret_cast, ret);
  linalg::add(transx, transy, alpha, beta, *x_cast, *y_cast, *ret_cast);
}

extern "C" SEXP R_gpumat_linalg_add(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP beta, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  void *x = getRptr(x_robj);
  void *y = getRptr(y_robj);
  void *ret = getRptr(ret_robj);
  APPLY_TEMPLATED_FUNCTION(type, add, LGL(transx), LGL(transy), DBL(alpha), DBL(beta), x, y, ret);
  
  return R_NilValue;
}



template <typename REAL>
static inline void matmult(bool transx, bool transy, REAL alpha, void *x, void *y, void *ret)
{
  CAST_MAT(gpumat, REAL, x_cast, x);
  CAST_MAT(gpumat, REAL, y_cast, y);
  CAST_MAT(gpumat, REAL, ret_cast, ret);
  linalg::matmult(transx, transy, alpha, *x_cast, *y_cast, *ret_cast);
}

extern "C" SEXP R_gpumat_linalg_matmult(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  void *x = getRptr(x_robj);
  void *y = getRptr(y_robj);
  void *ret = getRptr(ret_robj);
  APPLY_TEMPLATED_FUNCTION(type, matmult, LGL(transx), LGL(transy), DBL(alpha), x, y, ret);
  
  return R_NilValue;
}



template <typename REAL>
static inline void crossprod(bool xpose, REAL alpha, void *x, void *ret)
{
  CAST_MAT(gpumat, REAL, x_cast, x);
  CAST_MAT(gpumat, REAL, ret_cast, ret);
  if (xpose)
    linalg::tcrossprod(alpha, *x_cast, *ret_cast);
  else
    linalg::crossprod(alpha, *x_cast, *ret_cast);
}

extern "C" SEXP R_gpumat_linalg_crossprod(SEXP type, SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  void *x = getRptr(x_robj);
  void *ret = getRptr(ret_robj);
  APPLY_TEMPLATED_FUNCTION(type, crossprod, LGL(xpose), DBL(alpha), x, ret);
  
  return R_NilValue;
}



template <typename REAL>
static inline void xpose(void *x, void *ret)
{
  CAST_MAT(gpumat, REAL, x_cast, x);
  CAST_MAT(gpumat, REAL, ret_cast, ret);
  linalg::xpose(*x_cast, *ret_cast);
}

extern "C" SEXP R_gpumat_linalg_xpose(SEXP type, SEXP x_robj, SEXP ret_robj)
{
  void *x = getRptr(x_robj);
  void *ret = getRptr(ret_robj);
  APPLY_TEMPLATED_FUNCTION(type, xpose, x, ret);
  
  return R_NilValue;
}



template <typename REAL>
static inline void lu(void *x)
{
  CAST_MAT(gpumat, REAL, x_cast, x);
  linalg::lu(*x_cast);
}

extern "C" SEXP R_gpumat_linalg_lu(SEXP type, SEXP x_robj)
{
  void *x = getRptr(x_robj);
  APPLY_TEMPLATED_FUNCTION(type, lu, x);
  
  return R_NilValue;
}
