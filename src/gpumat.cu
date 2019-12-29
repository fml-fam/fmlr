#include "extptr.h"
#include "types.h"

#include "fml/src/cpu/cpuvec.hh"

#include "fml/src/gpu/card.hh"
#include "fml/src/gpu/gpuhelpers.hh"
#include "fml/src/gpu/gpumat.hh"
#include "fml/src/gpu/linalg.hh"


// -----------------------------------------------------------------------------
// gpumat bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_init(SEXP type, SEXP c_robj, SEXP m_, SEXP n_)
{
  SEXP ret;
  
  int m = INTEGER(m_)[0];
  int n = INTEGER(n_)[0];
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  
  if (INT(type) == TYPE_DOUBLE)
  {
    gpumat<double> *x = new gpumat<double>(*c);
    x->resize(m, n);
    newRptr(x, ret, fml_object_finalizer<gpumat<double>>);
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    gpumat<float> *x = new gpumat<float>(*c);
    x->resize(m, n);
    newRptr(x, ret, fml_object_finalizer<gpumat<float>>);
  }
  else //if (INT(type) == TYPE_INT)
  {
    gpumat<int> *x = new gpumat<int>(*c);
    x->resize(m, n);
    newRptr(x, ret, fml_object_finalizer<gpumat<int>>);
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpumat_dim(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  if (INT(type) == TYPE_DOUBLE)
  {
    gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->nrows();
    INTEGER(ret)[1] = x->ncols();
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    gpumat<float> *x = (gpumat<float>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->nrows();
    INTEGER(ret)[1] = x->ncols();
  }
  else //if (INT(type) == TYPE_INT)
  {
    gpumat<int> *x = (gpumat<int>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->nrows();
    INTEGER(ret)[1] = x->ncols();
  }
  
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



extern "C" SEXP R_gpumat_fill_runif(SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  if (INTEGER(seed)[0] == -1)
    x->fill_runif(REAL(min)[0], REAL(max)[0]);
  else
    x->fill_runif(INTEGER(seed)[0], REAL(min)[0], REAL(max)[0]);
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_rnorm(SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  if (INTEGER(seed)[0] == -1)
    x->fill_rnorm(REAL(min)[0], REAL(max)[0]);
  else
    x->fill_rnorm(INTEGER(seed)[0], REAL(min)[0], REAL(max)[0]);
  
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
