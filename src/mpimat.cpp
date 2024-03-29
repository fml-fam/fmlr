#define R_USE_C99_IN_CXX
#define FML_PRINT_R

#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/mpi/grid.hh>
#include <fml/mpi/copy.hh>
#include <fml/mpi/mpimat.hh>

using namespace fml;


extern "C" SEXP R_mpimat_init(SEXP type, SEXP g_robj, SEXP m_, SEXP n_, SEXP mb_, SEXP nb_)
{
  SEXP ret;
  
  int m = INTEGER(m_)[0];
  int n = INTEGER(n_)[0];
  int mb = INTEGER(mb_)[0];
  int nb = INTEGER(nb_)[0];
  
  grid *g = (grid*) getRptr(g_robj);
  
  #define FMLR_TMP_INIT(type) { \
    mpimat<type> *x = new mpimat<type>(*g, mb, nb); \
    TRY_CATCH( x->resize(m, n) ) \
    newRptr(x, ret, fml_object_finalizer<mpimat<type>>); }
  
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



extern "C" SEXP R_mpimat_dim(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  #define FMLR_TMP_DIM(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_mpimat_ldim(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  #define FMLR_TMP_LDIM(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
    INTEGER(ret)[0] = x->nrows_local(); \
    INTEGER(ret)[1] = x->ncols_local(); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_LDIM(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_LDIM(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_LDIM(int)
  
  #undef FMLR_TMP_LDIM
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_mpimat_bfdim(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  #define FMLR_TMP_BFDIM(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
    INTEGER(ret)[0] = x->bf_rows(); \
    INTEGER(ret)[1] = x->bf_cols(); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_BFDIM(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_BFDIM(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_BFDIM(int)
  
  #undef FMLR_TMP_BFDIM
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_mpimat_resize(SEXP type, SEXP x_robj, SEXP m, SEXP n)
{
  APPLY_TEMPLATED_METHOD(mpimat, type, x_robj, resize, INTEGER(m)[0], INTEGER(n)[0]);
  return R_NilValue;
}



extern "C" SEXP R_mpimat_dupe(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  #define FMLR_TMP_DUPE(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
    mpimat<type> *y = new mpimat<type>(x->get_grid(), x->bf_rows(), x->bf_cols()); \
    copy::mpi2mpi(*x, *y); \
    newRptr(y, ret, fml_object_finalizer<mpimat<type>>); }
  
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



extern "C" SEXP R_mpimat_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  APPLY_TEMPLATED_METHOD(mpimat, type, x_robj, print, INTEGER(ndigits)[0]);
  return R_NilValue;
}



extern "C" SEXP R_mpimat_info(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(mpimat, type, x_robj, info);
  return R_NilValue;
}



extern "C" SEXP R_mpimat_fill_zero(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(mpimat, type, x_robj, fill_zero);
  return R_NilValue;
}



extern "C" SEXP R_mpimat_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  APPLY_TEMPLATED_METHOD(mpimat, type, x_robj, fill_val, DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_mpimat_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  if (isNull(start))
  {
    APPLY_TEMPLATED_METHOD(mpimat, type, x_robj, fill_linspace);
  }
  else
  {
    APPLY_TEMPLATED_METHOD(mpimat, type, x_robj, fill_linspace, DBL(start), DBL(stop));
  }
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_fill_eye(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(mpimat, type, x_robj, fill_eye);
  return R_NilValue;
}



extern "C" SEXP R_mpimat_fill_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_FILL_DIAG(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_mpimat_fill_runif(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  #define FMLR_TMP_FILL_RUNIF(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_mpimat_fill_rnorm(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  #define FMLR_TMP_FILL_RNORM(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_mpimat_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_DIAG(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_mpimat_antidiag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  #define FMLR_TMP_ANTIDIAG(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_mpimat_scale(SEXP type, SEXP x_robj, SEXP s)
{
  APPLY_TEMPLATED_METHOD(mpimat, type, x_robj, scale, DBL(s));
  return R_NilValue;
}



extern "C" SEXP R_mpimat_rev_rows(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(mpimat, type, x_robj, rev_rows);
  return R_NilValue;
}



extern "C" SEXP R_mpimat_rev_cols(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(mpimat, type, x_robj, rev_cols);
  return R_NilValue;
}



extern "C" SEXP R_mpimat_get(SEXP type, SEXP x_robj, SEXP i, SEXP j)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_GET(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_mpimat_set(SEXP type, SEXP x_robj, SEXP i, SEXP j, SEXP v)
{
  APPLY_TEMPLATED_METHOD(mpimat, type, x_robj, set, INT(i), INT(j), DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_mpimat_get_row(SEXP type, SEXP x_robj, SEXP i, SEXP v_robj)
{
  #define FMLR_TMP_GET_ROW(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
    cpuvec<type> *v = (cpuvec<type>*) getRptr(v_robj); \
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



extern "C" SEXP R_mpimat_get_col(SEXP type, SEXP x_robj, SEXP j, SEXP v_robj)
{
  #define FMLR_TMP_GET_COL(type) { \
    mpimat<type> *x = (mpimat<type>*) getRptr(x_robj); \
    cpuvec<type> *v = (cpuvec<type>*) getRptr(v_robj); \
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



extern "C" SEXP R_mpimat_to_robj(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  if (INT(type) == TYPE_DOUBLE)
  {
    mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(REALSXP, m, n));
    cpumat<double> ret_mat(REAL(ret), m, n, false);
    copy::mpi2cpu(*x, ret_mat);
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    mpimat<float> *x = (mpimat<float>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(INTSXP, m, n));
    cpumat<float> ret_mat((float*) INTEGER(ret), m, n, false);
    copy::mpi2cpu(*x, ret_mat);
  }
  else //if (INT(type) == TYPE_INT)
  {
    mpimat<int> *x = (mpimat<int>*) getRptr(x_robj);
    len_t m = x->nrows();
    len_t n = x->ncols();
    
    PROTECT(ret = allocMatrix(INTSXP, m, n));
    cpumat<int> ret_mat(INTEGER(ret), m, n, false);
    copy::mpi2cpu(*x, ret_mat);
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_mpimat_from_robj(SEXP x_robj, SEXP robj)
{
  int m = nrows(robj);
  int n = ncols(robj);
  
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  len_t m_x = x->nrows();
  len_t n_x = x->ncols();
  
  if (m_x != m || n_x != n)
    x->resize(m, n);
  
  cpumat<double> robj_mat(REAL(robj), m, n, false);
  copy::cpu2mpi(robj_mat, *x);
  
  return R_NilValue;
}
