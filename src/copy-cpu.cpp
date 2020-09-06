#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/cpu/copy.hh>
#include <fml/cpu/cpumat.hh>
#include <fml/cpu/cpuvec.hh>

using namespace fml;


extern "C" SEXP R_cpuvec_cpu2cpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_CPU2CPU_SINGLE(type, out_robj) \
    cpuvec<type> *out = (cpuvec<type>*) getRptr(out_robj); \
    copy::cpu2cpu(*in, *out);
  
  #define FMLR_TMP_CPU2CPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_CPU2CPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_CPU2CPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_CPU2CPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    cpuvec<double> *in = (cpuvec<double>*) getRptr(in_robj); \
    FMLR_TMP_CPU2CPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    cpuvec<float> *in = (cpuvec<float>*) getRptr(in_robj); \
    FMLR_TMP_CPU2CPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    cpuvec<int> *in = (cpuvec<int>*) getRptr(in_robj); \
    FMLR_TMP_CPU2CPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_CPU2CPU_SINGLE
  #undef FMLR_TMP_CPU2CPU
  
  return R_NilValue;
}



extern "C" SEXP R_cpumat_cpu2cpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_CPU2CPU_SINGLE(type, out_robj) \
    cpumat<type> *out = (cpumat<type>*) getRptr(out_robj); \
    copy::cpu2cpu(*in, *out);
  
  #define FMLR_TMP_CPU2CPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_CPU2CPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_CPU2CPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_CPU2CPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    cpumat<double> *in = (cpumat<double>*) getRptr(in_robj); \
    FMLR_TMP_CPU2CPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    cpumat<float> *in = (cpumat<float>*) getRptr(in_robj); \
    FMLR_TMP_CPU2CPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    cpumat<int> *in = (cpumat<int>*) getRptr(in_robj); \
    FMLR_TMP_CPU2CPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_CPU2CPU_SINGLE
  #undef FMLR_TMP_CPU2CPU
  
  return R_NilValue;
}
