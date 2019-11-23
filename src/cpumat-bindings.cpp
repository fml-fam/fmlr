#include "extptr.h"
#include "fml/src/cpu/cpumat.hh"
#include "fml/src/cpu/linalg.hh"


extern "C" SEXP R_cpumat_init(SEXP m_, SEXP n_)
{
  SEXP ret;
  
  int m = INTEGER(m_)[0];
  int n = INTEGER(n_)[0];
  
  cpumat<double> *x = new cpumat<double>();
  if (m > 0 && n > 0)
    x->resize(m, n);
  
  newRptr(x, ret, fml_object_finalizer<cpumat<double>>);
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_cpumat_print(SEXP x_robj, SEXP ndigits)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  x->print(INTEGER(ndigits)[0]);
  return R_NilValue;
}

extern "C" SEXP R_cpumat_info(SEXP x_robj)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  x->info();
  return R_NilValue;
}
