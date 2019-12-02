#include "extptr.h"

#include "fml/src/cpu/cpuvec.hh"

#include "fml/src/gpu/card.hh"
#include "fml/src/gpu/gpuhelpers.hh"
#include "fml/src/gpu/gpuvec.hh"
#include "fml/src/gpu/linalg.hh"


// -----------------------------------------------------------------------------
// card bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_card_init(SEXP id_)
{
  SEXP ret;
  
  int id = INTEGER(id_)[0];
  card *c = new card(id);
  std::shared_ptr<card> *x = new std::shared_ptr<card>(c);
  
  newRptr(x, ret, fml_object_finalizer<std::shared_ptr<card>>);
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_card_set(SEXP c_robj, SEXP id)
{
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  (*c)->set(INTEGER(id)[0]);
  
  return R_NilValue;
}

extern "C" SEXP R_card_info(SEXP c_robj)
{
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  (*c)->info();
  
  return R_NilValue;
}

extern "C" SEXP R_card_get_id(SEXP c_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  INTEGER(ret)[0] = (*c)->get_id();
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_card_valid_card(SEXP c_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(LGLSXP, 1));
  
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  LOGICAL(ret)[0] = (*c)->valid_card();
  UNPROTECT(1);
  return ret;
}



// -----------------------------------------------------------------------------
// gpuvec bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpuvec_init(SEXP c_robj, SEXP size_)
{
  SEXP ret;
  
  int size = INTEGER(size_)[0];
  
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  
  gpuvec<double> *x = new gpuvec<double>(*c);
  if (size > 0)
    x->resize(size);
  
  newRptr(x, ret, fml_object_finalizer<gpuvec<double>>);
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_gpuvec_size(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  INTEGER(ret)[0] = x->size();
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_gpuvec_set(SEXP x_robj, SEXP data)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  // TODO FIXME
  // x->set(REAL(data), LENGTH(data), false);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_resize(SEXP x_robj, SEXP size)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->resize(INTEGER(size)[0]);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_print(SEXP x_robj, SEXP ndigits)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->print(INTEGER(ndigits)[0]);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_info(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->info();
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_fill_zero(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->fill_zero();
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_fill_one(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->fill_one();
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_fill_val(SEXP x_robj, SEXP v)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->fill_val(REAL(v)[0]);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_fill_linspace(SEXP x_robj, SEXP start, SEXP stop)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->fill_linspace(REAL(start)[0], REAL(stop)[0]);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_scale(SEXP x_robj, SEXP s)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->scale(REAL(s)[0]);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_rev(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->rev();
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_to_robj(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  len_t size = x->size();
  
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, size));
  
  cpuvec<double> ret_vec(REAL(ret), size, false);
  gpuhelpers::gpu2cpu(*x, ret_vec);
  
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_gpuvec_from_robj(SEXP x_robj, SEXP robj)
{
  int size = LENGTH(robj);
  
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  len_t size_x = x->size();
  
  if (size_x != size)
    x->resize(size);
  
  cpuvec<double> robj_vec(REAL(robj), size, false);
  gpuhelpers::cpu2gpu(robj_vec, *x);
  
  return R_NilValue;
}



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
  
  return ret;
}

extern "C" SEXP R_gpumat_set(SEXP x_robj, SEXP data)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  // TODO FIXME
  // x->set(REAL(data), LENGTH(data), false);
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

extern "C" SEXP R_gpumat_fill_one(SEXP x_robj)
{
  gpumat<double> *x = (gpumat<double>*) getRptr(x_robj);
  x->fill_one();
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

// TODO diag

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
// 
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
