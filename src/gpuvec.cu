#include "extptr.h"

#include "fml/src/cpu/cpuvec.hh"

#include "fml/src/gpu/card.hh"
#include "fml/src/gpu/gpuhelpers.hh"
#include "fml/src/gpu/gpuvec.hh"


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



extern "C" SEXP R_gpuvec_inherit(SEXP x_robj, SEXP data)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  // TODO FIXME
  // x->inherit(REAL(data), LENGTH(data), false);
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
