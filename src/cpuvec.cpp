#include "extptr.h"

#include "fml/src/cpu/cpuvec.hh"


extern "C" SEXP R_cpuvec_init(SEXP size_)
{
  SEXP ret;
  
  int size = INTEGER(size_)[0];
  
  cpuvec<double> *x = new cpuvec<double>();
  if (size > 0)
    x->resize(size);
  
  newRptr(x, ret, fml_object_finalizer<cpuvec<double>>);
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



extern "C" SEXP R_cpuvec_resize(SEXP x_robj, SEXP size)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->resize(INTEGER(size)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_print(SEXP x_robj, SEXP ndigits)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->print(INTEGER(ndigits)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_info(SEXP x_robj)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->info();
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_fill_zero(SEXP x_robj)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->fill_zero();
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_fill_val(SEXP x_robj, SEXP v)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->fill_val(REAL(v)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_fill_linspace(SEXP x_robj, SEXP start, SEXP stop)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->fill_linspace(REAL(start)[0], REAL(stop)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_scale(SEXP x_robj, SEXP s)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->scale(REAL(s)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_rev(SEXP x_robj)
{
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  x->rev();
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_to_robj(SEXP x_robj)
{
  SEXP ret;
  
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  
  len_t size = x->size();
  auto *x_d = x->data_ptr();
  
  PROTECT(ret = allocVector(REALSXP, size));
  double *ret_d = REAL(ret);
  
  for (len_t i=0; i<size; i++)
    ret_d[i] = (double) x_d[i];
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_from_robj(SEXP x_robj, SEXP robj)
{
  int size = LENGTH(robj);
  double *r_d = REAL(robj);
  
  cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
  len_t size_x = x->size();
  
  if (size_x != size)
    x->resize(size);
  
  auto *x_d = x->data_ptr();
  for (len_t i=0; i<size; i++)
    x_d[i] = (double) r_d[i];
  
  return R_NilValue;
}
