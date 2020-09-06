#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/mpi/grid.hh>
#include <fml/mpi/linalg.hh>
#include <fml/mpi/mpimat.hh>

using namespace fml;


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



extern "C" SEXP R_mpimat_linalg_xpose(SEXP type, SEXP x_robj, SEXP ret_robj)
{
  #define FMLR_TMP_XPOSE(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(mpimat, type, ret, ret_robj); \
    linalg::xpose(*x, *ret); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_XPOSE, type);
  #undef FMLR_TMP_XPOSE
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_lu(SEXP type, SEXP x_robj)
{
  #define FMLR_TMP_LU(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    linalg::lu(*x); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_LU, type);
  #undef FMLR_TMP_LU
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_det(SEXP type, SEXP x_robj)
{
  SEXP ret, ret_names;
  SEXP sign, modulus;
  
  PROTECT(ret = allocVector(VECSXP, 2));
  PROTECT(ret_names = allocVector(STRSXP, 2));
  
  PROTECT(sign = allocVector(INTSXP, 1));
  PROTECT(modulus = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_DET(type) { \
    type mod; \
    CAST_FML(mpimat, type, x, x_robj); \
    linalg::det(*x, INT(sign), mod); \
    DBL(modulus) = (double) mod; }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_DET, type);
  #undef FMLR_TMP_DET
  
  SET_VECTOR_ELT(ret, 0, sign);
  SET_VECTOR_ELT(ret, 1, modulus);
  SET_STRING_ELT(ret_names, 0, mkChar("sign"));
  SET_STRING_ELT(ret_names, 1, mkChar("modulus"));
  setAttrib(ret, R_NamesSymbol, ret_names);
  
  UNPROTECT(4);
  return ret;
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



extern "C" SEXP R_mpimat_linalg_invert(SEXP type, SEXP x_robj)
{
  #define FMLR_TMP_INVERT(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    linalg::invert(*x); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_INVERT, type);
  #undef FMLR_TMP_INVERT
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_solve(SEXP type, SEXP x_robj, SEXP y_class, SEXP y_robj)
{
  (void) y_class;
  
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



extern "C" SEXP R_mpimat_linalg_qr(SEXP type, SEXP x_robj, SEXP qraux_robj)
{
  #define FMLR_TMP_QR(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(cpuvec, type, qraux, qraux_robj); \
    linalg::qr(false, *x, *qraux); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_QR, type);
  #undef FMLR_TMP_QR
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_qr_Q(SEXP type, SEXP QR_robj, SEXP qraux_robj, SEXP Q_robj, SEXP work_robj)
{
  #define FMLR_TMP_QR_Q(type) { \
    CAST_FML(mpimat, type, QR, QR_robj); \
    CAST_FML(cpuvec, type, qraux, qraux_robj); \
    CAST_FML(mpimat, type, Q, Q_robj); \
    CAST_FML(cpuvec, type, work, work_robj); \
    linalg::qr_Q(*QR, *qraux, *Q, *work); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_QR_Q, type);
  #undef FMLR_TMP_QR_Q
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_qr_R(SEXP type, SEXP QR_robj, SEXP R_robj)
{
  #define FMLR_TMP_QR_R(type) { \
    CAST_FML(mpimat, type, QR, QR_robj); \
    CAST_FML(mpimat, type, R, R_robj); \
    linalg::qr_R(*QR, *R); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_QR_R, type);
  #undef FMLR_TMP_QR_R
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_lq(SEXP type, SEXP x_robj, SEXP lqaux_robj)
{
  #define FMLR_TMP_LQ(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(cpuvec, type, lqaux, lqaux_robj); \
    linalg::lq(*x, *lqaux); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_LQ, type);
  #undef FMLR_TMP_LQ
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_lq_L(SEXP type, SEXP LQ_robj, SEXP L_robj)
{
  #define FMLR_TMP_LQ_L(type) { \
    CAST_FML(mpimat, type, LQ, LQ_robj); \
    CAST_FML(mpimat, type, L, L_robj); \
    linalg::lq_L(*LQ, *L); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_LQ_L, type);
  #undef FMLR_TMP_LQ_L
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_lq_Q(SEXP type, SEXP LQ_robj, SEXP lqaux_robj, SEXP Q_robj, SEXP work_robj)
{
  #define FMLR_TMP_LQ_Q(type) { \
    CAST_FML(mpimat, type, LQ, LQ_robj); \
    CAST_FML(cpuvec, type, lqaux, lqaux_robj); \
    CAST_FML(mpimat, type, Q, Q_robj); \
    CAST_FML(cpuvec, type, work, work_robj); \
    linalg::lq_Q(*LQ, *lqaux, *Q, *work); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_LQ_Q, type);
  #undef FMLR_TMP_LQ_Q
  
  return R_NilValue;
}


extern "C" SEXP R_mpimat_linalg_qrsvd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  #define FMLR_TMP_TSSVD(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(cpuvec, type, s, s_robj); \
    if (u_robj == R_NilValue) \
      linalg::qrsvd(*x, *s); \
    else { \
      CAST_FML(mpimat, type, u, u_robj); \
      CAST_FML(mpimat, type, vt, vt_robj); \
      linalg::qrsvd(*x, *s, *u, *vt); } }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_TSSVD, type);
  #undef FMLR_TMP_TSSVD
  
  return R_NilValue;
}


extern "C" SEXP R_mpimat_linalg_cpsvd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  #define FMLR_TMP_CPSVD(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(cpuvec, type, s, s_robj); \
    if (u_robj == R_NilValue) \
      linalg::cpsvd(*x, *s); \
    else { \
      CAST_FML(mpimat, type, u, u_robj); \
      CAST_FML(mpimat, type, vt, vt_robj); \
      linalg::cpsvd(*x, *s, *u, *vt); } }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_CPSVD, type);
  #undef FMLR_TMP_CPSVD
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_chol(SEXP type, SEXP x_robj)
{
  #define FMLR_TMP_CHOL(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    linalg::chol(*x); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_CHOL, type);
  #undef FMLR_TMP_CHOL
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_norm(SEXP type, SEXP x_robj, SEXP norm)
{
  SEXP ret;
  
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_NORM(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    if (CHR(norm) == '1') \
      DBL(ret) = (double)linalg::norm_1(*x); \
    else if (CHR(norm) == 'I') \
      DBL(ret) = (double)linalg::norm_I(*x); \
    else if (CHR(norm) == 'F') \
      DBL(ret) = (double)linalg::norm_F(*x); \
    else if (CHR(norm) == 'M') \
      DBL(ret) = (double)linalg::norm_M(*x); \
    else /*if (CHR(norm) == '2')*/ \
      DBL(ret) = (double)linalg::norm_2(*x); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_NORM, type);
  #undef FMLR_TMP_NORM
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_mpimat_linalg_cond(SEXP type, SEXP x_robj, SEXP norm)
{
  SEXP ret;
  
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_COND(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    if (CHR(norm) == '1') \
      DBL(ret) = (double)linalg::cond_1(*x); \
    else if (CHR(norm) == 'I') \
      DBL(ret) = (double)linalg::cond_I(*x); \
    else /*if (CHR(norm) == '2')*/ \
      DBL(ret) = (double)linalg::cond_2(*x); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_COND, type);
  #undef FMLR_TMP_COND
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_mpimat_linalg_dot(SEXP type, SEXP x_robj, SEXP y_robj)
{
  (void)type;
  (void)x_robj;
  (void)y_robj;
  return R_NilValue;
}



extern "C" SEXP R_mpimat_linalg_trinv(SEXP type, SEXP upper, SEXP unit_diag, SEXP x_robj)
{
  #define FMLR_TMP_TRINV(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    linalg::trinv(INT(upper), INT(unit_diag), *x); }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_TRINV, type);
  #undef FMLR_TMP_TRINV
  
  return R_NilValue;
}


extern "C" SEXP R_mpimat_linalg_rsvd(SEXP type, SEXP seed, SEXP k, SEXP q, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  #define FMLR_TMP_RSVD(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(cpuvec, type, s, s_robj); \
    if (u_robj == R_NilValue) \
      linalg::rsvd(INT(seed), INT(k), INT(q), *x, *s); \
    else { \
      CAST_FML(mpimat, type, u, u_robj); \
      CAST_FML(mpimat, type, vt, vt_robj); \
      linalg::rsvd(INT(seed), INT(k), INT(q), *x, *s, *u, *vt); } }
  
  APPLY_TEMPLATED_MACRO(FMLR_TMP_RSVD, type);
  #undef FMLR_TMP_RSVD
  
  return R_NilValue;
}
