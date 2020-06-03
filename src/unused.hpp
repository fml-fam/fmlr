#ifndef FMLR_UNUSED_H
#define FMLR_UNUSED_H
#pragma once


#include <Rinternals.h>

#include <string>
static inline std::string warnmsg(std::string backend)
{
  return "fmlr built without " + backend + " support; this does nothing";
}
#define WARN_AND_RETURN(BACKEND) warning(warnmsg(BACKEND).c_str());return R_NilValue;

namespace
{
  static inline void unused(){}
  
  template <typename T>
  static inline void unused(T *x)
  {
    (void)x;
  }
  
  template <typename T, typename... VAT>
  static inline void unused(T *x, VAT... vax)
  {
    unused(x);
    unused(vax ...);
  }
}


#endif
