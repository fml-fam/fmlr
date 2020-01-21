#ifndef FMLR_EXTPTR_H
#define FMLR_EXTPTR_H
#pragma once


#include <Rinternals.h>


#define newRptr(ptr,Rptr,fin) PROTECT(Rptr = R_MakeExternalPtr(ptr, R_NilValue, R_NilValue));R_RegisterCFinalizerEx(Rptr, fin, TRUE)
#define getRptr(ptr) R_ExternalPtrAddr(ptr)

template <class T>
static inline void fml_object_finalizer(SEXP Rptr)
{
  if (NULL == getRptr(Rptr))
    return;
  
  T *x = (T*) getRptr(Rptr);
  delete x;
  R_ClearExternalPtr(Rptr);
}


#endif
