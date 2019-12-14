#include "extptr.h"

#include "fml/src/mpi/grid.hh"
#include "fml/src/mpi/linalg.hh"
#include "fml/src/mpi/mpihelpers.hh"
#include "fml/src/mpi/mpimat.hh"

#define GET_R_STRING(x,i) ((char*)CHAR(STRING_ELT(x,i)))
#define GET_R_CHAR(x,i) ((GET_R_STRING(x,i))[0])


// -----------------------------------------------------------------------------
// grid bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_grid_init(SEXP gridtype)
{
  SEXP ret;
  
  grid *g = new grid((gridshape) INTEGER(gridtype)[0]);
  
  newRptr(g, ret, fml_object_finalizer<grid>);
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_grid_set(SEXP g_robj, SEXP blacs_context)
{
  grid *g = (grid*) getRptr(g_robj);
  g->set(INTEGER(blacs_context)[0]);
  
  return R_NilValue;
}

extern "C" SEXP R_grid_exit(SEXP g_robj)
{
  grid *g = (grid*) getRptr(g_robj);
  g->exit();
  
  return R_NilValue;
}

extern "C" SEXP R_grid_finalize(SEXP g_robj, SEXP mpi_continue)
{
  grid *g = (grid*) getRptr(g_robj);
  g->finalize(LOGICAL(mpi_continue)[0]);
  
  return R_NilValue;
}

extern "C" SEXP R_grid_info(SEXP g_robj)
{
  grid *g = (grid*) getRptr(g_robj);
  g->info();
  
  return R_NilValue;
}

extern "C" SEXP R_grid_rank0(SEXP g_robj)
{
  grid *g = (grid*) getRptr(g_robj);
  g->rank0();
  
  return R_NilValue;
}

extern "C" SEXP R_grid_ingrid(SEXP g_robj)
{
  grid *g = (grid*) getRptr(g_robj);
  g->ingrid();
  
  return R_NilValue;
}

extern "C" SEXP R_grid_barrier(SEXP g_robj, SEXP scope)
{
  grid *g = (grid*) getRptr(g_robj);
  g->barrier(GET_R_CHAR(scope, 0));
  
  return R_NilValue;
}

extern "C" SEXP R_grid_ictxt(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  INTEGER(ret)[0] = g->ictxt();
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_grid_nprocs(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  INTEGER(ret)[0] = g->nprocs();
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_grid_nprow(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  INTEGER(ret)[0] = g->nprow();
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_grid_npcol(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  INTEGER(ret)[0] = g->npcol();
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_grid_myrow(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  INTEGER(ret)[0] = g->myrow();
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_grid_mycol(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  INTEGER(ret)[0] = g->mycol();
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_grid_valid_grid(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(LGLSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  LOGICAL(ret)[0] = g->valid_grid();
  UNPROTECT(1);
  return ret;
}



// -----------------------------------------------------------------------------
// mpimat bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_mpimat_init(SEXP g_robj, SEXP m_, SEXP n_, SEXP mb, SEXP nb)
{
  SEXP ret;
  
  int m = INTEGER(m_)[0];
  int n = INTEGER(n_)[0];
  grid *g = (grid*) getRptr(g_robj);
  
  mpimat<double> *x = new mpimat<double>(*g, INTEGER(mb)[0], INTEGER(nb)[0]);
  if (m > 0 && n > 0)
    x->resize(m, n);
  
  newRptr(x, ret, fml_object_finalizer<mpimat<double>>);
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_mpimat_dim(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  INTEGER(ret)[0] = x->nrows();
  INTEGER(ret)[1] = x->ncols();
  
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_mpimat_ldim(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  INTEGER(ret)[0] = x->nrows_local();
  INTEGER(ret)[1] = x->ncols_local();
  
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_mpimat_bfdim(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 2));
  
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  INTEGER(ret)[0] = x->bf_rows();
  INTEGER(ret)[1] = x->bf_cols();
  
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_mpimat_inherit(SEXP x_robj, SEXP data)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  // TODO FIXME
  // x->inherit(REAL(data), LENGTH(data), false);
  return R_NilValue;
}

extern "C" SEXP R_mpimat_resize(SEXP x_robj, SEXP m, SEXP n)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  x->resize(INTEGER(m)[0], INTEGER(n)[0]);
  return R_NilValue;
}

extern "C" SEXP R_mpimat_print(SEXP x_robj, SEXP ndigits)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  x->print(INTEGER(ndigits)[0]);
  return R_NilValue;
}

extern "C" SEXP R_mpimat_info(SEXP x_robj)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  x->info();
  return R_NilValue;
}

extern "C" SEXP R_mpimat_fill_zero(SEXP x_robj)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  x->fill_zero();
  return R_NilValue;
}

extern "C" SEXP R_mpimat_fill_val(SEXP x_robj, SEXP v)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  x->fill_val(REAL(v)[0]);
  return R_NilValue;
}

extern "C" SEXP R_mpimat_fill_linspace(SEXP x_robj, SEXP start, SEXP stop)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  x->fill_linspace(REAL(start)[0], REAL(stop)[0]);
  return R_NilValue;
}

extern "C" SEXP R_mpimat_fill_eye(SEXP x_robj)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  x->fill_eye();
  return R_NilValue;
}

extern "C" SEXP R_mpimat_fill_runif(SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  if (INTEGER(seed)[0] == -1)
    x->fill_runif(REAL(min)[0], REAL(max)[0]);
  else
    x->fill_runif(INTEGER(seed)[0], REAL(min)[0], REAL(max)[0]);
  
  return R_NilValue;
}

extern "C" SEXP R_mpimat_fill_rnorm(SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  if (INTEGER(seed)[0] == -1)
    x->fill_rnorm(REAL(min)[0], REAL(max)[0]);
  else
    x->fill_rnorm(INTEGER(seed)[0], REAL(min)[0], REAL(max)[0]);
  
  return R_NilValue;
}

// TODO diag
// TODO antidiag

extern "C" SEXP R_mpimat_scale(SEXP x_robj, SEXP s)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  x->scale(REAL(s)[0]);
  return R_NilValue;
}

// extern "C" SEXP R_mpimat_rev_rows(SEXP x_robj)
// {
//   mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
//   x->rev_rows();
//   return R_NilValue;
// }
// 
// extern "C" SEXP R_mpimat_rev_cols(SEXP x_robj)
// {
//   mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
//   x->rev_cols();
//   return R_NilValue;
// }

extern "C" SEXP R_mpimat_to_robj(SEXP x_robj)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  len_t m = x->nrows();
  len_t n = x->ncols();
  
  SEXP ret;
  PROTECT(ret = allocMatrix(REALSXP, m, n));
  
  cpumat<double> ret_mat(REAL(ret), m, n, false);
  mpihelpers::mpi2cpu(*x, ret_mat);
  
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_mpimat_from_robj(SEXP x_robj, SEXP robj)
{
  int m = nrows(robj);
  int n = ncols(robj);
  
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  len_t m_x = x->nrows();
  len_t n_x = x->ncols();
  
  if (m_x != m || n_x != n)
    x->resize(m, n);
  
  cpumat<double> robj_mat(REAL(robj), m, n, false);
  mpihelpers::cpu2mpi(robj_mat, *x);
  
  return R_NilValue;
}



// -----------------------------------------------------------------------------
// linalg namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_mpimat_linalg_crossprod(SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  mpimat<double> *x = (mpimat<double>*) getRptr(x_robj);
  mpimat<double> *ret = (mpimat<double>*) getRptr(ret_robj);
  
  if (LOGICAL(xpose)[0])
    linalg::tcrossprod(REAL(alpha)[0], *x, *ret);
  else
    linalg::crossprod(REAL(alpha)[0], *x, *ret);
  
  return R_NilValue;
}
