#include "extptr.h"

#include "fml/src/cpu/cpuvec.hh"

#include "fml/src/gpu/card.hh"
#include "fml/src/gpu/gpuhelpers.hh"
#include "fml/src/gpu/gpumat.hh"
#include "fml/src/gpu/linalg.hh"


// -----------------------------------------------------------------------------
// gpumat bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_init(SEXP c_robj, SEXP m_, SEXP n_)
{
  SEXP ret;
  
  int m = INTEGER(m_)[0];
  int n = INTEGER(n_)[0];
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  
  gpumat<double> *x = new gpumat<double>(*c);
  if (m > 0 && n > 0)
    x->resize(m, n);
  
  newRptr(x, ret, fml_object_finalizer<gpumat<double>>);
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpumat_dim(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  INTEGER(ret)[0] = x->nrows();
  INTEGER(ret)[1] = x->ncols();
  
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



extern "C" SEXP R_gpumat_resize(SEXP x_robj, SEXP m, SEXP n)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->resize(INTEGER(m)[0], INTEGER(n)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_print(SEXP x_robj, SEXP ndigits)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->print(INTEGER(ndigits)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_info(SEXP x_robj)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->info();
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_zero(SEXP x_robj)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->fill_zero();
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_val(SEXP x_robj, SEXP v)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->fill_val(REAL(v)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_linspace(SEXP x_robj, SEXP start, SEXP stop)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->fill_linspace(REAL(start)[0], REAL(stop)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpumat_fill_eye(SEXP x_robj)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->fill_eye();
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



extern "C" SEXP R_gpumat_scale(SEXP x_robj, SEXP s)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->scale(REAL(s)[0]);
  return R_NilValue;
}



// extern "C" SEXP R_gpumat_rev_rows(SEXP x_robj)
// {
//   gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
//   x->rev_rows();
//   return R_NilValue;
// }



// extern "C" SEXP R_gpumat_rev_cols(SEXP x_robj)
// {
//   gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
//   x->rev_cols();
//   return R_NilValue;
// }



extern "C" SEXP R_gpumat_to_robj(SEXP x_robj)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  len_t m = x->nrows();
  len_t n = x->ncols();
  
  SEXP ret;
  PROTECT(ret = allocMatrix(REALSXP, m, n));
  
  cpumat<double> ret_mat(REAL(ret), m, n, false);
  gpuhelpers::gpu2cpu(*x, ret_mat);
  
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

extern "C" SEXP R_gpumat_linalg_crossprod(SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  gpumat<double> *ret = (gpumat<double>*) getRptr(ret_robj);
  
  if (LOGICAL(xpose)[0])
    linalg::tcrossprod(REAL(alpha)[0], *x, *ret);
  else
    linalg::crossprod(REAL(alpha)[0], *x, *ret);
  
  return R_NilValue;
}
