#include "extptr.h"
#include "types.h"

#include <fml/src/cpu/cpuvec.hh>

#include <fml/src/gpu/card.hh>
#include <fml/src/gpu/gpuhelpers.hh>
#include <fml/src/gpu/gpumat.hh>
#include <fml/src/gpu/linalg.hh>


// -----------------------------------------------------------------------------
// gpumat bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_init(SEXP type, SEXP c_robj, SEXP m_, SEXP n_)
{
  SEXP ret;
  
  int m = INTEGER(m_)[0];
  int n = INTEGER(n_)[0];
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  
  #define FMLR_TMP_INIT(type) { \
    gpumat<type> *x = new gpumat<type>(*c); \
    x->resize(m, n); \
    newRptr(x, ret, fml_object_finalizer<gpumat<type>>); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_INIT(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_INIT(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_INIT(int)
  
  #undef FMLR_TMP_INIT
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpumat_dim(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  #define FMLR_TMP_DIM(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    INTEGER(ret)[0] = x->nrows(); \
    INTEGER(ret)[1] = x->ncols(); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_DIM(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_DIM(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_DIM(int)
  
  #undef FMLR_TMP_DIM
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpumat_inherit(SEXP x_robj, SEXP data)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  // TODO FIXME
  // x->inherit(REAL(data), LENGTH(data), false);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_resize(SEXP type, SEXP x_robj, SEXP m, SEXP n)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, resize, INTEGER(m)[0], INTEGER(n)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, print, INTEGER(ndigits)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_info(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, info);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_zero(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, fill_zero);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, fill_val, DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, fill_linspace, DBL(start), DBL(stop));
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_eye(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, fill_eye);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_FILL_DIAG(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    gpuvec<type> *v = (gpuvec<type>*) getRptr(v_robj); \
    x->fill_diag(*v); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_FILL_DIAG(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_FILL_DIAG(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_FILL_DIAG(int)
  
  #undef FMLR_TMP_FILL_DIAG
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_runif(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  #define FMLR_TMP_FILL_RUNIF(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    if (INTEGER(seed)[0] == -1) \
      x->fill_runif((type) REAL(min)[0], (type) REAL(max)[0]); \
    else \
      x->fill_runif(INTEGER(seed)[0], (type) REAL(min)[0], (type) REAL(max)[0]); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_FILL_RUNIF(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_FILL_RUNIF(float)
  else
    error("unsupported fundamental type");
  
  #undef FMLR_TMP_FILL_RUNIF
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_rnorm(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  #define FMLR_TMP_FILL_RNORM(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    if (INTEGER(seed)[0] == -1) \
      x->fill_rnorm((type) REAL(min)[0], (type) REAL(max)[0]); \
    else \
      x->fill_rnorm(INTEGER(seed)[0], (type) REAL(min)[0], (type) REAL(max)[0]); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_FILL_RNORM(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_FILL_RNORM(float)
  else
    error("unsupported fundamental type");
  
  #undef FMLR_TMP_FILL_RNORM
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_DIAG(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    gpuvec<type> *v = (gpuvec<type>*) getRptr(v_robj); \
    x->diag(*v); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_DIAG(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_DIAG(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_DIAG(int)
  
  #undef FMLR_TMP_DIAG
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_antidiag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_ANTIDIAG(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    gpuvec<type> *v = (gpuvec<type>*) getRptr(v_robj); \
    x->antidiag(*v); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_ANTIDIAG(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_ANTIDIAG(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_ANTIDIAG(int)
  
  #undef FMLR_TMP_ANTIDIAG
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_scale(SEXP type, SEXP x_robj, SEXP s)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, scale, DBL(s));
  return R_NilValue;
}



extern "C" SEXP R_gpumat_rev_rows(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, rev_rows);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_rev_cols(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, rev_cols);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_to_robj(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  if (INT(type) == TYPE_DOUBLE)
  {
    gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(REALSXP, m, n));
    cpumat<double> ret_mat(REAL(ret), m, n, false);
    gpuhelpers::gpu2cpu(*x, ret_mat);
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    gpumat<float> *x = (gpumat<float>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(INTSXP, m, n));
    cpumat<float> ret_mat((float*) INTEGER(ret), m, n, false);
    gpuhelpers::gpu2cpu(*x, ret_mat);
  }
  else //if (INT(type) == TYPE_INT)
  {
    gpumat<int> *x = (gpumat<int>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(INTSXP, m, n));
    cpumat<int> ret_mat(INTEGER(ret), m, n, false);
    gpuhelpers::gpu2cpu(*x, ret_mat);
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpumat_from_robj(SEXP x_robj, SEXP robj)
{
  int m = nrows(robj);
  int n = ncols(robj);
  
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  len_t m_x = x->nrows();
  len_t n_x = x->ncols();
  
  if (m_x != m || n_x != n)
    x->resize(m, n);
  
  cpumat<double> robj_mat(REAL(robj), m, n, false);
  gpuhelpers::cpu2gpu(robj_mat, *x);
  
  return R_NilValue;
}



// -----------------------------------------------------------------------------
// linalg namespace
// -----------------------------------------------------------------------------

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
