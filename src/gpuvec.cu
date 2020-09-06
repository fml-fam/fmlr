#define R_USE_C99_IN_CXX
#define FML_PRINT_R

#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/cpu/cpuvec.hh>

#include <fml/gpu/card.hh>
#include <fml/gpu/copy.hh>
#include <fml/gpu/gpuvec.hh>

using namespace fml;


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



extern "C" SEXP R_gpuvec_resize(SEXP type, SEXP x_robj, SEXP size)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, resize, INTEGER(size)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_dupe(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  #define FMLR_TMP_DUPE(type) { \
    gpuvec<type> *x = (gpuvec<type>*) getRptr(x_robj); \
    gpuvec<type> *y = new gpuvec<type>(x->get_card()); \
    copy::gpu2gpu(*x, *y); \
    newRptr(y, ret, fml_object_finalizer<gpuvec<type>>); }
  
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



extern "C" SEXP R_gpuvec_sum(SEXP type, SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_SUM(type){ \
    gpuvec<type> *x = (gpuvec<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_gpuvec_get(SEXP type, SEXP x_robj, SEXP i)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  #define FMLR_TMP_GET(type) { \
    gpuvec<type> *x = (gpuvec<type>*) getRptr(x_robj); \
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



extern "C" SEXP R_gpuvec_set(SEXP type, SEXP x_robj, SEXP i, SEXP v)
{
  APPLY_TEMPLATED_METHOD(gpuvec, type, x_robj, set, INT(i), DBL(v));
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_to_robj(SEXP type, SEXP x_robj)
{
  SEXP ret;
  
  if (INT(type) == TYPE_DOUBLE)
  {
    gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
    len_t size = x->size();
    
    PROTECT(ret = allocVector(REALSXP, size));
    cpuvec<double> ret_vec(REAL(ret), size, false);
    copy::gpu2cpu(*x, ret_vec);
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    gpuvec<float> *x = (gpuvec<float>*) getRptr(x_robj);
    len_t size = x->size();
    
    PROTECT(ret = allocVector(INTSXP, size));
    cpuvec<float> ret_vec((float*) INTEGER(ret), size, false);
    copy::gpu2cpu(*x, ret_vec);
  }
  else //if (INT(type) == TYPE_INT)
  {
    gpuvec<int> *x = (gpuvec<int>*) getRptr(x_robj);
    len_t size = x->size();
    
    PROTECT(ret = allocVector(INTSXP, size));
    cpuvec<int> ret_vec(INTEGER(ret), size, false);
    copy::gpu2cpu(*x, ret_vec);
  }
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpuvec_from_robj(SEXP type, SEXP x_robj, SEXP type_robj, SEXP robj)
{
  const int size = LENGTH(robj);
  
  #define FML_TMP_VECCOPY(type_robj) \
    const len_t size_x = x->size(); \
    if (size_x != size) \
      x->resize(size); \
    if (INT(type_robj) == TYPE_DOUBLE) \
    { \
      cpuvec<double> robj_vec(REAL(robj), size, false); \
      TRY_CATCH( copy::cpu2gpu(robj_vec, *x) ) \
    } \
    else if (INT(type_robj) == TYPE_FLOAT) \
    { \
      cpuvec<float> robj_vec(FLOAT(robj), size, false); \
      TRY_CATCH( copy::cpu2gpu(robj_vec, *x) ) \
    } \
    else \
    { \
      cpuvec<int> robj_vec(INTEGER(robj), size, false); \
      TRY_CATCH( copy::cpu2gpu(robj_vec, *x) ) \
    }
  
  if (INT(type) == TYPE_DOUBLE)
  {
    CAST_FML(gpuvec, double, x, x_robj);
    FML_TMP_VECCOPY(type_robj)
  }
  else if (INT(type) == TYPE_FLOAT)
  {
    CAST_FML(gpuvec, float, x, x_robj);
    FML_TMP_VECCOPY(type_robj)
  }
  else if (INT(type) == TYPE_INT)
  {
    CAST_FML(gpuvec, int, x, x_robj);
    FML_TMP_VECCOPY(type_robj)
  }
  
  #undef FML_TMP_VECCOPY
  
  return R_NilValue;
}
