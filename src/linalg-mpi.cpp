#include "apply.hpp"
#include "extptr.h"
#include "types.h"

#include <fml/src/mpi/grid.hh>
#include <fml/src/mpi/linalg.hh>
#include <fml/src/mpi/mpimat.hh>


template <typename REAL>
static inline void add(bool transx, bool transy, REAL alpha, REAL beta, void *x, void *y, void *ret)
{
  CAST_MAT(mpimat, REAL, x_cast, x);
  CAST_MAT(mpimat, REAL, y_cast, y);
  CAST_MAT(mpimat, REAL, ret_cast, ret);
  linalg::add(transx, transy, alpha, beta, *x_cast, *y_cast, *ret_cast);
}

extern "C" SEXP R_mpimat_linalg_add(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP beta, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
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
  CAST_MAT(mpimat, REAL, x_cast, x);
  CAST_MAT(mpimat, REAL, y_cast, y);
  CAST_MAT(mpimat, REAL, ret_cast, ret);
  linalg::matmult(transx, transy, alpha, *x_cast, *y_cast, *ret_cast);
}

extern "C" SEXP R_mpimat_linalg_matmult(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
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
  CAST_MAT(mpimat, REAL, x_cast, x);
  CAST_MAT(mpimat, REAL, ret_cast, ret);
  if (xpose)
    linalg::tcrossprod(alpha, *x_cast, *ret_cast);
  else
    linalg::crossprod(alpha, *x_cast, *ret_cast);
}

extern "C" SEXP R_mpimat_linalg_crossprod(SEXP type, SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  void *x = getRptr(x_robj);
  void *ret = getRptr(ret_robj);
  APPLY_TEMPLATED_FUNCTION(type, crossprod, LGL(xpose), DBL(alpha), x, ret);
  
  return R_NilValue;
}



template <typename REAL>
static inline void xpose(void *x, void *ret)
{
  CAST_MAT(mpimat, REAL, x_cast, x);
  CAST_MAT(mpimat, REAL, ret_cast, ret);
  linalg::xpose(*x_cast, *ret_cast);
}

extern "C" SEXP R_mpimat_linalg_xpose(SEXP type, SEXP x_robj, SEXP ret_robj)
{
  void *x = getRptr(x_robj);
  void *ret = getRptr(ret_robj);
  APPLY_TEMPLATED_FUNCTION(type, xpose, x, ret);
  
  return R_NilValue;
}



template <typename REAL>
static inline void lu(void *x)
{
  CAST_MAT(mpimat, REAL, x_cast, x);
  linalg::lu(*x_cast);
}

extern "C" SEXP R_mpimat_linalg_lu(SEXP type, SEXP x_robj)
{
  void *x = getRptr(x_robj);
  APPLY_TEMPLATED_FUNCTION(type, lu, x);
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_trace(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_TRACE(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
    DBL(ret) = linalg::trace(*x); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_TRACE(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_TRACE(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_TRACE(int)
  
  #undef FMLR_TMP_TRACE
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_mpimat_linalg_svd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  #define FMLR_TMP_SVD(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
    cpuvec<type> *s = (cpuvec<type>*) getRptr(s_robj); \
    if (u_robj == R_NilValue) \
      linalg::svd(*x, *s); \
    else { \
      mpimat<type> *u = (mpimat<type>*) getRptr(u_robj); \
      mpimat<type> *vt = (mpimat<type>*) getRptr(vt_robj); \
      linalg::svd(*x, *s, *u, *vt); } }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_SVD(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_SVD(float)
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_SVD
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_eigen_sym(SEXP type, SEXP x_robj, SEXP values_robj, SEXP vectors_robj)
{
  #define FMLR_TMP_EIGEN_SYM(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
    cpuvec<type> *values = (cpuvec<type>*) getRptr(values_robj); \
    if (vectors_robj == R_NilValue) \
      linalg::eigen_sym(*x, *values); \
    else { \
      mpimat<type> *vectors = (mpimat<type>*) getRptr(vectors_robj); \
      linalg::eigen_sym(*x, *values, *vectors); } }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_EIGEN_SYM(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_EIGEN_SYM(float)
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_EIGEN_SYM
  
  return R_NilValue;
}



template <typename REAL>
static inline void invert(void *x)
{
  CAST_MAT(mpimat, REAL, x_cast, x);
  linalg::invert(*x_cast);
}

extern "C" SEXP R_mpimat_linalg_invert(SEXP type, SEXP x_robj)
{
  void *x = getRptr(x_robj);
  APPLY_TEMPLATED_FUNCTION(type, invert, x);
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_solve(SEXP type, SEXP x_robj, SEXP y_class, SEXP y_robj)
{
  if (INT(type) == TYPE_DOUBLE)
  {
    mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
    mpimat<double> *y = (mpimat<double>*) getRptr(y_robj);
    linalg::solve(*x, *y);
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    mpimat<float> *x = (mpimat<float>*) getRptr(x_robj);
    mpimat<float> *y = (mpimat<float>*) getRptr(y_robj);
    linalg::solve(*x, *y);
  }
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_SOLVE
  
  return R_NilValue;
}
