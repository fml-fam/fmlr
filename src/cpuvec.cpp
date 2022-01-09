#define R_USE_C99_IN_CXX
#define FML_PRINT_R

#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/_internals/arraytools/src/arraytools.hpp>
#include <fml/cpu/cpuvec.hh>

using namespace fml;


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



extern "C" SEXP R_cpuvec_size(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  if (INT(type) == TYPE_DOUBLE)
  {
    cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->size();
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    cpuvec<float> *x = (cpuvec<float>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->size();
  }
  else //if (INT(type) == TYPE_INT)
  {
    cpuvec<int> *x = (cpuvec<int>*) getRptr(x_robj);
    INTEGER(ret)[0] = x->size();
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_inherit(SEXP type, SEXP x_robj, SEXP data)
{
  if (INT(type) == TYPE_DOUBLE)
  {
    CAST_FML(cpuvec, double, x, x_robj);
    TRY_CATCH( x->inherit(REAL(data), LENGTH(data), false); );
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    CAST_FML(cpuvec, float, x, x_robj);
    TRY_CATCH( x->inherit(FLOAT(data), LENGTH(data), false); );
  }
  else if (INT(type) == TYPE_INT)
  {
    CAST_FML(cpuvec, int, x, x_robj);
    TRY_CATCH( x->inherit(INTEGER(data), LENGTH(data), false); );
  }
  
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_resize(SEXP type, SEXP x_robj, SEXP size)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, resize, INTEGER(size)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_dupe(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  #define FMLR_TMP_DUPE(type) { \
    cpuvec<type> *x = (cpuvec<type>*) getRptr(x_robj); \
    cpuvec<type> *y = new cpuvec<type>(x->size()); \
    arraytools::copy(x->size(), x->data_ptr(), y->data_ptr()); \
    newRptr(y, ret, fml_object_finalizer<cpuvec<type>>); }
  
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



extern "C" SEXP R_cpuvec_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, print, INTEGER(ndigits)[0]);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_info(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(cpuvec, type, x_robj, info);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_fill_zero(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(cpuvec, type, x_robj, fill_zero);
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



extern "C" SEXP R_cpuvec_pow(SEXP type, SEXP x_robj, SEXP s)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, pow, DBL(s));
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_rev(SEXP type, SEXP x_robj)
{
  APPLY_TEMPLATED_METHOD_0(cpuvec, type, x_robj, rev);
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_sum(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_SUM(type){ \
    cpuvec<type> *x = (cpuvec<type>*) getRptr(x_robj); \
    REAL(ret)[0] = (double) x->sum(); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_SUM(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_SUM(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_SUM(int)
  
  #undef FMLR_TMP_SUM
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_min(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_MIN(type){ \
    cpuvec<type> *x = (cpuvec<type>*) getRptr(x_robj); \
    REAL(ret)[0] = (double) x->min(); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_MIN(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_MIN(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_MIN(int)
  
  #undef FMLR_TMP_MIN
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_max(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_MAX(type){ \
    cpuvec<type> *x = (cpuvec<type>*) getRptr(x_robj); \
    REAL(ret)[0] = (double) x->max(); }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_MAX(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_MAX(float)
  else //if (INT(type) == TYPE_INT)
    FMLR_TMP_MAX(int)
  
  #undef FMLR_TMP_MAX
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_get(SEXP type, SEXP x_robj, SEXP i)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_GET(type) { \
    cpuvec<type> *x = (cpuvec<type>*) getRptr(x_robj); \
    DBL(ret) = (double) x->get(INT(i)); }
  
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



extern "C" SEXP R_cpuvec_set(SEXP type, SEXP x_robj, SEXP i, SEXP v)
{
  APPLY_TEMPLATED_METHOD(cpuvec, type, x_robj, set, INT(i), DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_cpuvec_to_robj(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  if (INT(type) == TYPE_DOUBLE)
  {
    cpuvec<double> *x = (cpuvec<double>*) getRptr(x_robj);
    len_t size = x->size();
    
    PROTECT(ret = allocVector(REALSXP, size));
    arraytools::copy(size, x->data_ptr(), REAL(ret));
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    cpuvec<float> *x = (cpuvec<float>*) getRptr(x_robj);
    len_t size = x->size();
    
    PROTECT(ret = allocVector(INTSXP, size));
    arraytools::copy(size, x->data_ptr(), (float*) INTEGER(ret));
  }
  else //if (INT(type) == TYPE_INT)
  {
    cpuvec<int> *x = (cpuvec<int>*) getRptr(x_robj);
    len_t size = x->size();
    
    PROTECT(ret = allocVector(INTSXP, size));
    arraytools::copy(size, x->data_ptr(), INTEGER(ret));
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpuvec_from_robj(SEXP type, SEXP x_robj, SEXP type_robj, SEXP robj)
{
  const int size = LENGTH(robj);
  
  #define FML_TMP_VECCOPY(type_robj) \
    const len_t size_x = x->size(); \
    if (size_x != size) \
      x->resize(size); \
    if (INT(type_robj) == TYPE_DOUBLE) \
      TRY_CATCH( arraytools::copy(size, REAL(robj), x->data_ptr()) ) \
    else if (INT(type_robj) == TYPE_FLOAT) \
      TRY_CATCH( arraytools::copy(size, FLOAT(robj), x->data_ptr()) ) \
    else \
      TRY_CATCH( arraytools::copy(size, INTEGER(robj), x->data_ptr()) )
  
  if (INT(type) == TYPE_DOUBLE)
  {
    CAST_FML(cpuvec, double, x, x_robj);
    FML_TMP_VECCOPY(type_robj)
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    CAST_FML(cpuvec, float, x, x_robj);
    FML_TMP_VECCOPY(type_robj)
  }
  else if (INT(type) == TYPE_INT)
  {
    CAST_FML(cpuvec, int, x, x_robj);
    FML_TMP_VECCOPY(type_robj)
  }
  
  #undef FML_TMP_VECCOPY
  
  return R_NilValue;
}
