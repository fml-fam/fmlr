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



extern "C" SEXP R_cpumat_dim(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  INTEGER(ret)[0] = x->nrows();
  INTEGER(ret)[1] = x->ncols();
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



extern "C" SEXP R_cpumat_fill_zero(SEXP x_robj)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  x->fill_zero();
  return R_NilValue;
}

extern "C" SEXP R_cpumat_fill_one(SEXP x_robj)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  x->fill_one();
  return R_NilValue;
}

extern "C" SEXP R_cpumat_fill_val(SEXP x_robj, SEXP v)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  x->fill_val(REAL(v)[0]);
  return R_NilValue;
}

extern "C" SEXP R_cpumat_fill_linspace(SEXP x_robj, SEXP start, SEXP stop)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  x->fill_linspace(REAL(start)[0], REAL(stop)[0]);
  return R_NilValue;
}

extern "C" SEXP R_cpumat_fill_eye(SEXP x_robj)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  x->fill_eye();
  return R_NilValue;
}

// TODO diag

extern "C" SEXP R_cpumat_fill_runif(SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  if (INTEGER(seed)[0] == -1)
    x->fill_runif(REAL(min)[0], REAL(max)[0]);
  else
    x->fill_runif(INTEGER(seed)[0], REAL(min)[0], REAL(max)[0]);
  
  return R_NilValue;
}

extern "C" SEXP R_cpumat_fill_rnorm(SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  cpumat<double> *x = (cpumat<double>*) getRptr(x_robj);
  if (INTEGER(seed)[0] == -1)
    x->fill_rnorm(REAL(min)[0], REAL(max)[0]);
  else
    x->fill_rnorm(INTEGER(seed)[0], REAL(min)[0], REAL(max)[0]);
  
  return R_NilValue;
}
