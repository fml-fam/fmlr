#include "extptr.h"
#include "fml/src/gpu/card.hh"


// -----------------------------------------------------------------------------
// card bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_card_init(SEXP id_)
{
  SEXP ret;
  
  int id = INTEGER(id_)[0];
  card *c = new card(id);
  
  newRptr(c, ret, fml_object_finalizer<card>);
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_card_info(SEXP x_robj)
{
  card *c = (card*) getRptr(x_robj);
  c->info();
  
  return R_NilValue;
}



extern "C" SEXP R_card_get_id(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  card *c = (card*) getRptr(x_robj);
  INTEGER(ret)[0] = c->get_id();
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_card_valid_card(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(LGLSXP, 1));
  
  card *c = (card*) getRptr(x_robj);
  LOGICAL(ret)[0] = c->valid_card();
  UNPROTECT(1);
  return ret;
}
