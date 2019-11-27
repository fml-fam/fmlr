#include "extptr.h"
#include "fml/src/gpu/card.hh"
#include "fml/src/gpu/gpuvec.hh"


// -----------------------------------------------------------------------------
// card bindings
// -----------------------------------------------------------------------------

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



// -----------------------------------------------------------------------------
// gpuvec bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpuvec_init(SEXP c_robj, SEXP size_)
{
  SEXP ret;
  
  int size = INTEGER(size_)[0];
  
  std::shared_ptr<card> *c = (std::shared_ptr<card>*) getRptr(c_robj);
  
  gpuvec<double> *x = new gpuvec<double>(*c);
  if (size > 0)
    x->resize(size);
  
  newRptr(x, ret, fml_object_finalizer<gpuvec<double>>);
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpuvec_size(SEXP x_robj)
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  INTEGER(ret)[0] = x->size();
  UNPROTECT(1);
  return ret;
}



extern "C" SEXP R_gpuvec_set(SEXP x_robj, SEXP data)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  // x->set(REAL(data), LENGTH(data), false);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_resize(SEXP x_robj, SEXP size)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->resize(INTEGER(size)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_print(SEXP x_robj, SEXP ndigits)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->print(INTEGER(ndigits)[0]);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_info(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->info();
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_fill_zero(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->fill_zero();
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_fill_one(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->fill_one();
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_fill_val(SEXP x_robj, SEXP v)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->fill_val(REAL(v)[0]);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_fill_linspace(SEXP x_robj, SEXP start, SEXP stop)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->fill_linspace(REAL(start)[0], REAL(stop)[0]);
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_scale(SEXP x_robj, SEXP s)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->scale(REAL(s)[0]);
  return R_NilValue;
}

extern "C" SEXP R_gpuvec_rev(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  x->rev();
  return R_NilValue;
}



extern "C" SEXP R_gpuvec_to_robj(SEXP x_robj)
{
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  len_t size = x->size();
  auto *x_d = x->data_ptr();
  
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, size));
  double *ret_d = REAL(ret);
  
  size_t copylen = (size_t) size * sizeof(ret_d);
  auto c = x->get_card();
  c->mem_gpu2cpu(ret_d, x_d, copylen);
  
  UNPROTECT(1);
  return ret;
}

extern "C" SEXP R_gpuvec_from_robj(SEXP x_robj, SEXP robj)
{
  int size = LENGTH(robj);
  double *r_d = REAL(robj);
  
  gpuvec<double> *x = (gpuvec<double>*) getRptr(x_robj);
  len_t size_x = x->size();
  
  if (size_x != size)
    x->resize(size);
  
  auto *x_d = x->data_ptr();
  size_t copylen = (size_t) size * sizeof(r_d);
  auto c = x->get_card();
  c->mem_cpu2gpu(x_d, r_d, copylen);
  
  return R_NilValue;
}
