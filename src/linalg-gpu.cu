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



extern "C" SEXP R_gpumat_linalg_trace(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_TRACE(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_gpumat_linalg_svd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  #define FMLR_TMP_SVD(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    gpuvec<type> *s = (gpuvec<type>*) getRptr(s_robj); \
    if (u_robj == R_NilValue) \
      linalg::svd(*x, *s); \
    else { \
      gpumat<type> *u = (gpumat<type>*) getRptr(u_robj); \
      gpumat<type> *vt = (gpumat<type>*) getRptr(vt_robj); \
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



extern "C" SEXP R_gpumat_linalg_eigen_sym(SEXP type, SEXP x_robj, SEXP values_robj, SEXP vectors_robj)
{
  #define FMLR_TMP_EIGEN_SYM(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    gpuvec<type> *values = (gpuvec<type>*) getRptr(values_robj); \
    if (vectors_robj == R_NilValue) \
      linalg::eigen_sym(*x, *values); \
    else { \
      gpumat<type> *vectors = (gpumat<type>*) getRptr(vectors_robj); \
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
  CAST_MAT(gpumat, REAL, x_cast, x);
  linalg::invert(*x_cast);
}

extern "C" SEXP R_gpumat_linalg_invert(SEXP type, SEXP x_robj)
{
  void *x = getRptr(x_robj);
  APPLY_TEMPLATED_FUNCTION(type, invert, x);
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_linalg_solve(SEXP type, SEXP x_robj, SEXP y_class, SEXP y_robj)
{
  #define FMLR_TMP_SOLVE(type) \
    if (INT(y_class) == CLASS_VEC){ \
      gpuvec<type> *y = (gpuvec<type>*) getRptr(y_robj); \
      linalg::solve(*x, *y); \
    } else { \
      gpumat<type> *y = (gpumat<type>*) getRptr(y_robj); \
      linalg::solve(*x, *y); }
  
  if (INT(type) == TYPE_DOUBLE)
  {
    gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
    FMLR_TMP_SOLVE(double)
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    gpumat<float> *x = (gpumat<float>*) getRptr(x_robj);
    FMLR_TMP_SOLVE(float)
  }
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_SOLVE
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_linalg_qr(SEXP type, SEXP x_robj, SEXP qraux_robj)
{
  #define FMLR_TMP_QR(type) { \
    CAST_FML(gpumat, type, x, x_robj); \
    CAST_FML(gpuvec, type, qraux, qraux_robj); \
    linalg::qr(false, *x, *qraux); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_QR, type);
  
  #undef FMLR_TMP_QR
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_linalg_qr_Q(SEXP type, SEXP QR_robj, SEXP qraux_robj, SEXP Q_robj, SEXP work_robj)
{
  #define FMLR_TMP_QR_Q(type) { \
    CAST_FML(gpumat, type, QR, QR_robj); \
    CAST_FML(gpuvec, type, qraux, qraux_robj); \
    CAST_FML(gpumat, type, Q, Q_robj); \
    CAST_FML(gpuvec, type, work, work_robj); \
    linalg::qr_Q(*QR, *qraux, *Q, *work); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_QR_Q, type);
  
  #undef FMLR_TMP_QR_Q
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_linalg_qr_R(SEXP type, SEXP QR_robj, SEXP R_robj)
{
  #define FMLR_TMP_QR_R(type) { \
    CAST_FML(gpumat, type, QR, QR_robj); \
    CAST_FML(gpumat, type, R, R_robj); \
    linalg::qr_R(*QR, *R); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_QR_R, type);
  
  #undef FMLR_TMP_QR_R
  
  return R_NilValue;
}
