#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/mpi/copy.hh>
#include <fml/cpu/cpumat.hh>
#include <fml/mpi/mpimat.hh>

using namespace fml;


extern "C" SEXP R_mpimat_cpu2mpi(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_CPU2MPI_SINGLE(type, out_robj) \
    mpimat<type> *out = (mpimat<type>*) getRptr(out_robj); \
    copy::cpu2mpi(*in, *out);
  
  #define FMLR_TMP_CPU2MPI(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_CPU2MPI_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_CPU2MPI_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_CPU2MPI_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    cpumat<double> *in = (cpumat<double>*) getRptr(in_robj); \
    FMLR_TMP_CPU2MPI(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    cpumat<float> *in = (cpumat<float>*) getRptr(in_robj); \
    FMLR_TMP_CPU2MPI(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    cpumat<int> *in = (cpumat<int>*) getRptr(in_robj); \
    FMLR_TMP_CPU2MPI(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_CPU2MPI_SINGLE
  #undef FMLR_TMP_CPU2MPI
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_mpi2cpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj, SEXP rdest, SEXP cdest)
{
  #define FMLR_TMP_MPI2CPU_SINGLE(type, out_robj) \
    cpumat<type> *out = (cpumat<type>*) getRptr(out_robj); \
    copy::mpi2cpu(*in, *out, INT(rdest), INT(cdest));
  
  #define FMLR_TMP_MPI2CPU(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_MPI2CPU_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_MPI2CPU_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_MPI2CPU_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    mpimat<double> *in = (mpimat<double>*) getRptr(in_robj); \
    FMLR_TMP_MPI2CPU(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    mpimat<float> *in = (mpimat<float>*) getRptr(in_robj); \
    FMLR_TMP_MPI2CPU(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    mpimat<int> *in = (mpimat<int>*) getRptr(in_robj); \
    FMLR_TMP_MPI2CPU(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_MPI2CPU_SINGLE
  #undef FMLR_TMP_MPI2CPU
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_mpi2mpi(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  #define FMLR_TMP_MPI2MPI_SINGLE(type, out_robj) \
    mpimat<type> *out = (mpimat<type>*) getRptr(out_robj); \
    copy::mpi2mpi(*in, *out);
  
  #define FMLR_TMP_MPI2MPI(type_out, in, out_robj) \
    if (INT(type_out) == TYPE_DOUBLE) { \
      FMLR_TMP_MPI2MPI_SINGLE(double, out_robj) \
    } else if (INT(type_out) == TYPE_FLOAT) { \
      FMLR_TMP_MPI2MPI_SINGLE(float, out_robj) \
    } else { \
      FMLR_TMP_MPI2MPI_SINGLE(int, out_robj) }
  
  if (INT(type_in) == TYPE_DOUBLE)
  {
    mpimat<double> *in = (mpimat<double>*) getRptr(in_robj); \
    FMLR_TMP_MPI2MPI(type_out, in, out_robj)
  }
  else if (INT(type_in) == TYPE_FLOAT)
  {
    mpimat<float> *in = (mpimat<float>*) getRptr(in_robj); \
    FMLR_TMP_MPI2MPI(type_out, in, out_robj)
  }
  else //if (INT(type_in) == TYPE_INT)
  {
    mpimat<int> *in = (mpimat<int>*) getRptr(in_robj); \
    FMLR_TMP_MPI2MPI(type_out, in, out_robj)
  }
  
  #undef FMLR_TMP_MPI2MPI_SINGLE
  #undef FMLR_TMP_MPI2MPI
  
  return R_NilValue;
}
