#include <Rinternals.h>

#define WARNMSG "fmlr built without GPU support; this does nothing"
#define WARN_AND_RETURN warning(WARNMSG);return R_NilValue;

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



// -----------------------------------------------------------------------------
// card bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_card_init(SEXP id_)
{
  unused(id_);
  WARN_AND_RETURN;
}

extern "C" SEXP R_card_info(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_card_get_id(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_card_valid_card(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}
