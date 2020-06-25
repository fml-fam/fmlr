#define R_USE_C99_IN_CXX
#define FML_PRINT_R

#include "extptr.hpp"
#include "rutils.h"

#include <fml/src/mpi/grid.hh>

#define GET_R_STRING(x,i) ((char*)CHAR(STRING_ELT(x,i)))
#define GET_R_CHAR(x,i) ((GET_R_STRING(x,i))[0])


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
  TRY_CATCH( g->set(INTEGER(blacs_context)[0]) );
  
  return R_NilValue;
}



extern "C" SEXP R_grid_exit(SEXP g_robj)
{
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( g->exit() );
  
  return R_NilValue;
}



extern "C" SEXP R_grid_finalize(SEXP g_robj, SEXP mpi_continue)
{
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( g->finalize(LOGICAL(mpi_continue)[0]) );
  
  return R_NilValue;
}



extern "C" SEXP R_grid_info(SEXP g_robj)
{
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( g->info() );
  
  return R_NilValue;
}



extern "C" SEXP R_grid_rank0(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(LGLSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( LGL(ret) = g->rank0() );
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_grid_ingrid(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(LGLSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( LGL(ret) = g->ingrid() );
  
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_grid_barrier(SEXP g_robj, SEXP scope)
{
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( g->barrier(GET_R_CHAR(scope, 0)) );
  
  return R_NilValue;
}



extern "C" SEXP R_grid_ictxt(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( INTEGER(ret)[0] = g->ictxt() );
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_grid_nprocs(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( INTEGER(ret)[0] = g->nprocs() );
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_grid_nprow(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( INTEGER(ret)[0] = g->nprow() );
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_grid_npcol(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( INTEGER(ret)[0] = g->npcol() );
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_grid_myrow(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( INTEGER(ret)[0] = g->myrow() );
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_grid_mycol(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( INTEGER(ret)[0] = g->mycol() );
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_grid_valid_grid(SEXP g_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(LGLSXP, 1));
  
  grid *g = (grid*) getRptr(g_robj);
  TRY_CATCH( LOGICAL(ret)[0] = g->valid_grid() );
  UNPROTECT(1);
  return ret;
}
