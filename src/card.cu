#include "apply.hpp"
#include "extptr.h"

#include <fml/src/gpu/card.hh>


extern "C" SEXP R_card_init(SEXP id_)
{
  SEXP ret;
  
  int id = INTEGER(id_)[0];
  card *c = new card(id);
  std::shared_ptr<card> *x = new std::shared_ptr<card>(c);
  
  newRptr(x, ret, fml_object_finalizer<std::shared_ptr<card>>);
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_card_set(SEXP c_robj, SEXP id)
{
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  (*c)->set(INTEGER(id)[0]);
  
  return R_NilValue;
}



extern "C" SEXP R_card_info(SEXP c_robj)
{
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  (*c)->info();
  
  return R_NilValue;
}



extern "C" SEXP R_card_get_id(SEXP c_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  INTEGER(ret)[0] = (*c)->get_id();
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_card_valid_card(SEXP c_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(LGLSXP, 1));
  
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  LOGICAL(ret)[0] = (*c)->valid_card();
  UNPROTECT(1);
  return ret;
}
