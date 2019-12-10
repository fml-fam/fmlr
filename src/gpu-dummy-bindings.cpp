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

extern "C" SEXP R_card_set(SEXP c_robj, SEXP id)
{
  unused(c_robj, id);
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



// -----------------------------------------------------------------------------
// gpuvec bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpuvec_init(SEXP c_robj, SEXP size_)
{
  unused(c_robj, size_);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_size(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_inherit(SEXP x_robj, SEXP data)
{
  unused(x_robj, data);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_resize(SEXP x_robj, SEXP size)
{
  unused(x_robj, size);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_print(SEXP x_robj, SEXP ndigits)
{
  unused(x_robj, ndigits);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_info(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_fill_zero(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_fill_val(SEXP x_robj, SEXP v)
{
  unused(x_robj, v);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_fill_linspace(SEXP x_robj, SEXP start, SEXP stop)
{
  unused(x_robj, start, stop);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_scale(SEXP x_robj, SEXP s)
{
  unused(x_robj, s);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_rev(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_to_robj(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_from_robj(SEXP x_robj, SEXP robj)
{
  unused(x_robj, robj);
  WARN_AND_RETURN;
}



// -----------------------------------------------------------------------------
// gpumat bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_init(SEXP c_robj, SEXP m_, SEXP n_)
{
  unused(c_robj, m_, n_);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_dim(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_inherit(SEXP x_robj, SEXP data)
{
  unused(x_robj, data);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_resize(SEXP x_robj, SEXP m, SEXP n)
{
  unused(x_robj, m, n);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_print(SEXP x_robj, SEXP ndigits)
{
  unused(x_robj, ndigits);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_info(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_zero(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_val(SEXP x_robj, SEXP v)
{
  unused(x_robj, v);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_linspace(SEXP x_robj, SEXP start, SEXP stop)
{
  unused(x_robj, start, stop);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_eye(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

// TODO diag

extern "C" SEXP R_gpumat_fill_runif(SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  unused(x_robj, seed, min, max);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_rnorm(SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  unused(x_robj, seed, min, max);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_scale(SEXP x_robj, SEXP s)
{
  unused(x_robj, s);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_rev_rows(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_rev_cols(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_to_robj(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_from_robj(SEXP x_robj, SEXP robj)
{
  unused(x_robj, robj);
  WARN_AND_RETURN;
}



// -----------------------------------------------------------------------------
// linalg namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_linalg_crossprod(SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  unused(xpose, alpha, x_robj, ret_robj);
  WARN_AND_RETURN;
}
