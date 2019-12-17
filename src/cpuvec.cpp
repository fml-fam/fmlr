#include "extptr.h"
#include "types.h"

#include "fml/src/arraytools/src/arraytools.hpp"
#include "fml/src/cpu/cpuvec.hh"


extern "C" SEXP R_cpuvec_init(SEXP type, SEXP size_)
{
  SEXP ret;
  
  int size = INTEGER(size_)[0];
  
  if (INT(type) == TYPE_DOUBLE)
  {
    cpuvec<double> *x = new cpuvec<double>();
    x->resize(size);
    newRptr(x, ret, fml_object_finalizer<cpuvec<double>>);
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    cpuvec<float> *x = new cpuvec<float>();
    x->resize(size);
    newRptr(x, ret, fml_object_finalizer<cpuvec<float>>);
  }
  else //if (INT(type) == TYPE_INT)
  {
    cpuvec<int> *x = new cpuvec<int>();
    x->resize(size);
    newRptr(x, ret, fml_object_finalizer<cpuvec<int>>);
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_size(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  INTEGER(ret)[0] = x->size();
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_inherit(SEXP x_robj, SEXP data)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->inherit(REAL(data), LENGTH(data), false);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_resize(SEXP type, SEXP x_robj, SEXP size)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, resize, INTEGER(size)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, print, INTEGER(ndigits)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_info(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, info);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_fill_zero(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, fill_zero);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, fill_val, DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, fill_linspace, DBL(start), DBL(stop));
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_scale(SEXP type, SEXP x_robj, SEXP s)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, scale, DBL(s));
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_rev(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, rev);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_to_robj(SEXP x_robj)
{
  SEXP ret;
  
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  
  len_t size = x->size();
  PROTECT(ret = allocVector(REALSXP, size));
  
  arraytools::copy(size, x->data_ptr(), REAL(ret));
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_from_robj(SEXP x_robj, SEXP robj)
{
  int size = LENGTH(robj);
  
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  len_t size_x = x->size();
  
  if (size_x != size)
    x->resize(size);
  
  arraytools::copy(size, REAL(robj), x->data_ptr());
  
  return R_NilValue;
}
