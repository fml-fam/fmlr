#include "apply.hpp"
#include "extptr.h"
#include "types.h"

#include <fml/src/_internals/arraytools/src/arraytools.hpp>
#include <fml/src/cpu/cpumat.hh>


extern "C" SEXP R_cpumat_init(SEXP type, SEXP m_, SEXP n_)
{
  SEXP ret;
  
  int m = INTEGER(m_)[0];
  int n = INTEGER(n_)[0];
  
  #define FMLR_TMP_INIT(type) { \
    cpumat<type> *x = new cpumat<type>; \
    x->resize(m, n); \
    newRptr(x, ret, fml_object_finalizer<cpumat<type>>); }
  
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



extern "C" SEXP R_cpumat_dim(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  #define FMLR_TMP_DIM(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_cpumat_inherit(SEXP x_robj, SEXP data)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  x->inherit(REAL(data), nrows(data), ncols(data), false);
  return R_NilValue;
}



extern "C" SEXP R_cpumat_resize(SEXP type, SEXP x_robj, SEXP m, SEXP n)
{
  APPLY_TEMPLATED_METHOD(cpumat, type, x_robj, resize, INTEGER(m)[0], INTEGER(n)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpumat_dupe(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  #define FMLR_TMP_DUPE(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    cpumat<type> *y = new cpumat<type>(x->nrows(), x->ncols()); \
    arraytools::copy(x->nrows(), x->ncols(), x->data_ptr(), y->data_ptr()); \
    newRptr(y, ret, fml_object_finalizer<cpumat<type>>); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_DUPE(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_DUPE(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_DUPE(int)
  
  #undef FMLR_TMP_DUPE
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpumat_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  APPLY_TEMPLATED_METHOD(cpumat, type, x_robj, print, INTEGER(ndigits)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpumat_info(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(cpumat, type, x_robj, info);
  return R_NilValue;
}



extern "C" SEXP R_cpumat_fill_zero(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(cpumat, type, x_robj, fill_zero);
  return R_NilValue;
}



extern "C" SEXP R_cpumat_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  APPLY_TEMPLATED_METHOD(cpumat, type, x_robj, fill_val, DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_cpumat_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  APPLY_TEMPLATED_METHOD(cpumat, type, x_robj, fill_linspace, DBL(start), DBL(stop));
  return R_NilValue;
}



extern "C" SEXP R_cpumat_fill_eye(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(cpumat, type, x_robj, fill_eye);
  return R_NilValue;
}



extern "C" SEXP R_cpumat_fill_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_FILL_DIAG(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    cpuvec<type> *v = (cpuvec<type>*) getRptr(v_robj); \
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



extern "C" SEXP R_cpumat_fill_runif(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  #define FMLR_TMP_FILL_RUNIF(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    if (INTEGER(seed)[0] == -1) \
      x->fill_runif((type) REAL(min)[0], (type) REAL(max)[0]); \
    else \
      x->fill_runif(INTEGER(seed)[0], (type) REAL(min)[0], (type) REAL(max)[0]); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_FILL_RUNIF(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_FILL_RUNIF(float)
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_FILL_RUNIF
  
  return R_NilValue;
}



extern "C" SEXP R_cpumat_fill_rnorm(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  #define FMLR_TMP_FILL_RNORM(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    if (INTEGER(seed)[0] == -1) \
      x->fill_rnorm((type) REAL(min)[0], (type) REAL(max)[0]); \
    else \
      x->fill_rnorm(INTEGER(seed)[0], (type) REAL(min)[0], (type) REAL(max)[0]); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_FILL_RNORM(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_FILL_RNORM(float)
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_FILL_RNORM
  
  
  return R_NilValue;
}



extern "C" SEXP R_cpumat_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_DIAG(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    cpuvec<type> *v = (cpuvec<type>*) getRptr(v_robj); \
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



extern "C" SEXP R_cpumat_antidiag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_ANTIDIAG(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    cpuvec<type> *v = (cpuvec<type>*) getRptr(v_robj); \
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



extern "C" SEXP R_cpumat_scale(SEXP type, SEXP x_robj, SEXP s)
{
  APPLY_TEMPLATED_METHOD(cpumat, type, x_robj, scale, DBL(s));
  return R_NilValue;
}



extern "C" SEXP R_cpumat_rev_rows(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(cpumat, type, x_robj, rev_rows);
  return R_NilValue;
}



extern "C" SEXP R_cpumat_rev_cols(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(cpumat, type, x_robj, rev_cols);
  return R_NilValue;
}



extern "C" SEXP R_cpumat_get(SEXP type, SEXP x_robj, SEXP i, SEXP j)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_GET(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    DBL(ret) = (double) x->get(INT(i), INT(j)); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_GET(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_GET(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_GET(int)
  
  #undef FMLR_TMP_GET
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpumat_set(SEXP type, SEXP x_robj, SEXP i, SEXP j, SEXP v)
{
  APPLY_TEMPLATED_METHOD(cpumat, type, x_robj, set, INT(i), INT(j), DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_cpumat_get_row(SEXP type, SEXP x_robj, SEXP i, SEXP v_robj)
{
  #define FMLR_TMP_GET_ROW(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    cpuvec<type> *v = (cpuvec<type>*) getRptr(v_robj); \
    x->get_row(INT(i), *v); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_GET_ROW(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_GET_ROW(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_GET_ROW(int)
  
  #undef FMLR_TMP_GET_ROW
  
  return R_NilValue;
}



extern "C" SEXP R_cpumat_get_col(SEXP type, SEXP x_robj, SEXP j, SEXP v_robj)
{
  #define FMLR_TMP_GET_COL(type) { \
    cpumat<type> *x = (cpumat<type>*) getRptr(x_robj); \
    cpuvec<type> *v = (cpuvec<type>*) getRptr(v_robj); \
    x->get_col(INT(j), *v); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_GET_COL(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_GET_COL(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_GET_COL(int)
  
  #undef FMLR_TMP_GET_COL
  
  return R_NilValue;
}



extern "C" SEXP R_cpumat_to_robj(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  if (INT(type) == TYPE_DOUBLE)
  {
    cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(REALSXP, m, n));
    arraytools::copy(m*n, x->data_ptr(), REAL(ret));
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    cpumat<float> *x = (cpumat<float>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(INTSXP, m, n));
    arraytools::copy(m*n, x->data_ptr(), (float*) INTEGER(ret));
  }
  else //if (INT(type) == TYPE_INT)
  {
    cpumat<int> *x = (cpumat<int>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(INTSXP, m, n));
    arraytools::copy(m*n, x->data_ptr(), INTEGER(ret));
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpumat_from_robj(SEXP x_robj, SEXP robj)
{
  int m = nrows(robj);
  int n = ncols(robj);
  
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  len_t m_x = x->nrows();
  len_t n_x = x->ncols();
  
  if (m_x != m || n_x != n)
    x->resize(m, n);
  
  arraytools::copy(m*n, REAL(robj), x->data_ptr());
  
  return R_NilValue;
}
