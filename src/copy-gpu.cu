#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/cpu/cpumat.hh>
#include <fml/cpu/cpuvec.hh>

#include <fml/gpu/copy.hh>
#include <fml/gpu/gpumat.hh>
#include <fml/gpu/gpuvec.hh>

using namespace fml;


// -----------------------------------------------------------------------------
// gpu2cpu
// -----------------------------------------------------------------------------


extern "C" SEXP R_gpuvec_gpu2cpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_GPU2CPU_SINGLE(type, out_robj) \
    cpuvec<type> *out = (cpuvec<type>*) getRptr(out_robj); \
    copy::gpu2cpu(*in, *out);
  
  #define FMLR_TMP_GPU2CPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_GPU2CPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_GPU2CPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_GPU2CPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    gpuvec<double> *in = (gpuvec<double>*) getRptr(in_robj); \
    FMLR_TMP_GPU2CPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    gpuvec<float> *in = (gpuvec<float>*) getRptr(in_robj); \
    FMLR_TMP_GPU2CPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    gpuvec<int> *in = (gpuvec<int>*) getRptr(in_robj); \
    FMLR_TMP_GPU2CPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_GPU2CPU_SINGLE
  #undef FMLR_TMP_GPU2CPU
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_gpu2cpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_GPU2CPU_SINGLE(type, out_robj) \
    cpumat<type> *out = (cpumat<type>*) getRptr(out_robj); \
    copy::gpu2cpu(*in, *out);
  
  #define FMLR_TMP_GPU2CPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_GPU2CPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_GPU2CPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_GPU2CPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    gpumat<double> *in = (gpumat<double>*) getRptr(in_robj); \
    FMLR_TMP_GPU2CPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    gpumat<float> *in = (gpumat<float>*) getRptr(in_robj); \
    FMLR_TMP_GPU2CPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    gpumat<int> *in = (gpumat<int>*) getRptr(in_robj); \
    FMLR_TMP_GPU2CPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_GPU2CPU_SINGLE
  #undef FMLR_TMP_GPU2CPU
  
  return R_NilValue;
}



// -----------------------------------------------------------------------------
// cpu2gpu
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpuvec_cpu2gpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_CPU2GPU_SINGLE(type, out_robj) \
    gpuvec<type> *out = (gpuvec<type>*) getRptr(out_robj); \
    copy::cpu2gpu(*in, *out);
  
  #define FMLR_TMP_CPU2GPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_CPU2GPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_CPU2GPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_CPU2GPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    cpuvec<double> *in = (cpuvec<double>*) getRptr(in_robj); \
    FMLR_TMP_CPU2GPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    cpuvec<float> *in = (cpuvec<float>*) getRptr(in_robj); \
    FMLR_TMP_CPU2GPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    cpuvec<int> *in = (cpuvec<int>*) getRptr(in_robj); \
    FMLR_TMP_CPU2GPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_CPU2GPU_SINGLE
  #undef FMLR_TMP_CPU2GPU
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_cpu2gpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_CPU2GPU_SINGLE(type, out_robj) \
    gpumat<type> *out = (gpumat<type>*) getRptr(out_robj); \
    copy::cpu2gpu(*in, *out);
  
  #define FMLR_TMP_CPU2GPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_CPU2GPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_CPU2GPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_CPU2GPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    cpumat<double> *in = (cpumat<double>*) getRptr(in_robj); \
    FMLR_TMP_CPU2GPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    cpumat<float> *in = (cpumat<float>*) getRptr(in_robj); \
    FMLR_TMP_CPU2GPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    cpumat<int> *in = (cpumat<int>*) getRptr(in_robj); \
    FMLR_TMP_CPU2GPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_CPU2GPU_SINGLE
  #undef FMLR_TMP_CPU2GPU
  
  return R_NilValue;
}



// -----------------------------------------------------------------------------
// gpu2gpu
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpuvec_gpu2gpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_GPU2GPU_SINGLE(type, out_robj) \
    gpuvec<type> *out = (gpuvec<type>*) getRptr(out_robj); \
    copy::gpu2gpu(*in, *out);
  
  #define FMLR_TMP_GPU2GPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_GPU2GPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_GPU2GPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_GPU2GPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    gpuvec<double> *in = (gpuvec<double>*) getRptr(in_robj); \
    FMLR_TMP_GPU2GPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    gpuvec<float> *in = (gpuvec<float>*) getRptr(in_robj); \
    FMLR_TMP_GPU2GPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    gpuvec<int> *in = (gpuvec<int>*) getRptr(in_robj); \
    FMLR_TMP_GPU2GPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_GPU2GPU_SINGLE
  #undef FMLR_TMP_GPU2GPU
  
  return R_NilValue;
}



extern "C" SEXP R_gpumat_gpu2gpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_GPU2GPU_SINGLE(type, out_robj) \
    gpumat<type> *out = (gpumat<type>*) getRptr(out_robj); \
    copy::gpu2gpu(*in, *out);
  
  #define FMLR_TMP_GPU2GPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_GPU2GPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_GPU2GPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_GPU2GPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    gpumat<double> *in = (gpumat<double>*) getRptr(in_robj); \
    FMLR_TMP_GPU2GPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    gpumat<float> *in = (gpumat<float>*) getRptr(in_robj); \
    FMLR_TMP_GPU2GPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    gpumat<int> *in = (gpumat<int>*) getRptr(in_robj); \
    FMLR_TMP_GPU2GPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_GPU2GPU_SINGLE
  #undef FMLR_TMP_GPU2GPU
  
  return R_NilValue;
}
