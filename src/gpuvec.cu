#include "extptr.h"
#include "types.h"

#include "fml/src/cpu/cpuvec.hh"

#include "fml/src/gpu/card.hh"
#include "fml/src/gpu/gpuhelpers.hh"
#include "fml/src/gpu/gpuvec.hh"


extern "C" SEXP R_gpuvec_init(SEXP type, SEXP c_robj, SEXP size_)
{
  SEXP ret;
  
  int size = INTEGER(size_)[0];
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  
  if (INT(type) == TYPE_DOUBLE)
  {
    gpuvec<double> *x = new gpuvec<double>(*c);
    x->resize(size);
    newRptr(x, ret, fml_object_finalizer<gpuvec<double>>);
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    gpuvec<float> *x = new gpuvec<float>(*c);
    x->resize(size);
    newRptr(x, ret, fml_object_finalizer<gpuvec<float>>);
  }
  else //if (INT(type) == TYPE_INT)
  {
    gpuvec<int> *x = new gpuvec<int>(*c);
    x->resize(size);
    newRptr(x, ret, fml_object_finalizer<gpuvec<int>>);
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpuvec_size(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  if (INT(type) == TYPE_DOUBLE)
  {
    gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->size();
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    gpuvec<float> *x = (gpuvec<float>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->size();
  }
  else //if (INT(type) == TYPE_INT)
  {
    gpuvec<int> *x = (gpuvec<int>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->size();
  }
  
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



extern "C" SEXP R_gpuvec_resize(SEXP type, SEXP x_robj, SEXP size)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, resize, INTEGER(size)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, print, INTEGER(ndigits)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_info(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, info);
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_fill_zero(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, fill_zero);
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, fill_val, DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, fill_linspace, DBL(start), DBL(stop));
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_scale(SEXP type, SEXP x_robj, SEXP s)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, scale, DBL(s));
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_rev(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, rev);
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
