#define R_USE_C99_IN_CXX
#define FML_PRINT_R

#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/src/cpu/cpuvec.hh>

#include <fml/src/gpu/card.hh>
#include <fml/src/gpu/gpuhelpers.hh>
#include <fml/src/gpu/gpumat.hh>


extern "C" SEXP R_gpumat_init(SEXP type, SEXP c_robj, SEXP m_, SEXP n_)
{
  SEXP ret;
  
  int m = INTEGER(m_)[0];
  int n = INTEGER(n_)[0];
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  
  #define FMLR_TMP_INIT(type) { \
    gpumat<type> *x = new gpumat<type>(*c); \
    TRY_CATCH( x->resize(m, n) ) \
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



extern "C" SEXP R_gpumat_resize(SEXP type, SEXP x_robj, SEXP m, SEXP n)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, resize, INTEGER(m)[0], INTEGER(n)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_dupe(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  #define FMLR_TMP_DUPE(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    gpumat<type> *y = new gpumat<type>(x->get_card()); \
    gpuhelpers::gpu2gpu(*x, *y); \
    newRptr(y, ret, fml_object_finalizer<gpumat<type>>); }
  
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
    error(TYPE_ERR);
  
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
    error(TYPE_ERR);
  
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



extern "C" SEXP R_gpumat_get(SEXP type, SEXP x_robj, SEXP i, SEXP j)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_GET(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    TRY_CATCH( DBL(ret) = (double) x->get(INT(i), INT(j)) ) }
  
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



extern "C" SEXP R_gpumat_set(SEXP type, SEXP x_robj, SEXP i, SEXP j, SEXP v)
{
  APPLY_TEMPLATED_METHOD(gpumat, type, x_robj, set, INT(i), INT(j), DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_gpumat_get_row(SEXP type, SEXP x_robj, SEXP i, SEXP v_robj)
{
  #define FMLR_TMP_GET_ROW(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    gpuvec<type> *v = (gpuvec<type>*) getRptr(v_robj); \
    TRY_CATCH( x->get_row(INT(i), *v) ) }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_GET_ROW(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_GET_ROW(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_GET_ROW(int)
  
  #undef FMLR_TMP_GET_ROW
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_get_col(SEXP type, SEXP x_robj, SEXP j, SEXP v_robj)
{
  #define FMLR_TMP_GET_COL(type) { \
    gpumat<type> *x = (gpumat<type>*) getRptr(x_robj); \
    gpuvec<type> *v = (gpuvec<type>*) getRptr(v_robj); \
    TRY_CATCH( x->get_col(INT(j), *v) ) }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_GET_COL(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_GET_COL(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_GET_COL(int)
  
  #undef FMLR_TMP_GET_COL
  
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



extern "C" SEXP R_gpumat_from_robj(SEXP type, SEXP x_robj, SEXP type_robj, SEXP robj)
{
  const int m = nrows(robj);
  const int n = ncols(robj);
  
  #define FML_TMP_MATCOPY(type_robj) \
    if (x->nrows() != m || x->ncols() != n) \
      x->resize(m, n); \
    if (INT(type_robj) == TYPE_DOUBLE) \
    { \
      cpumat<double> robj_mat(REAL(robj), m, n, false); \
      TRY_CATCH( gpuhelpers::cpu2gpu(robj_mat, *x) ) \
    } \
    else if (INT(type_robj) == TYPE_FLOAT) \
    { \
      cpumat<float> robj_mat(FLOAT(robj), m, n, false); \
      TRY_CATCH( gpuhelpers::cpu2gpu(robj_mat, *x) ) \
    } \
    else \
    { \
      cpumat<int> robj_mat(INTEGER(robj), m, n, false); \
      TRY_CATCH( gpuhelpers::cpu2gpu(robj_mat, *x) ) \
    }
  
  if (INT(type) == TYPE_DOUBLE)
  {
    CAST_FML(gpumat, double, x, x_robj);
    FML_TMP_MATCOPY(type_robj)
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    CAST_FML(gpumat, float, x, x_robj);
    FML_TMP_MATCOPY(type_robj)
  }
  else if (INT(type) == TYPE_INT)
  {
    CAST_FML(gpumat, int, x, x_robj);
    FML_TMP_MATCOPY(type_robj)
  }
  
  #undef FML_TMP_MATCOPY
  
  return R_NilValue;
}
