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

extern "C" SEXP R_gpuvec_init(SEXP type, SEXP c_robj, SEXP size_)
{
  unused(type, c_robj, size_);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_size(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_inherit(SEXP type, SEXP x_robj, SEXP data)
{
  unused(type, x_robj, data);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_resize(SEXP type, SEXP x_robj, SEXP size)
{
  unused(type, x_robj, size);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  unused(type, x_robj, ndigits);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_info(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_fill_zero(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  unused(type, x_robj, v);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  unused(type, x_robj, start, stop);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_antidiag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_scale(SEXP type, SEXP x_robj, SEXP s)
{
  unused(type, x_robj, s);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_rev(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_to_robj(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpuvec_from_robj(SEXP type, SEXP x_robj, SEXP robj)
{
  unused(type, x_robj, robj);
  WARN_AND_RETURN;
}



// -----------------------------------------------------------------------------
// gpumat bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_init(SEXP type, SEXP c_robj, SEXP m_, SEXP n_)
{
  unused(type, c_robj, m_, n_);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_dim(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_inherit(SEXP type, SEXP x_robj, SEXP data)
{
  unused(type, x_robj, data);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_resize(SEXP type, SEXP x_robj, SEXP m, SEXP n)
{
  unused(type, x_robj, m, n);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  unused(type, x_robj, ndigits);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_info(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_zero(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  unused(type, x_robj, v);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  unused(type, x_robj, start, stop);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_eye(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_runif(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  unused(type, x_robj, seed, min, max);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_fill_rnorm(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  unused(type, x_robj, seed, min, max);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_scale(SEXP type, SEXP x_robj, SEXP s)
{
  unused(type, x_robj, s);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_rev_rows(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_rev_cols(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_to_robj(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_from_robj(SEXP type, SEXP x_robj, SEXP robj)
{
  unused(type, x_robj, robj);
  WARN_AND_RETURN;
}



// -----------------------------------------------------------------------------
// linalg namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_linalg_add(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP beta, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  unused(type, transx, transy, alpha, beta, x_robj, y_robj, ret_robj);
  WARN_AND_RETURN;
}

extern "C" SEXP R_gpumat_linalg_crossprod(SEXP type, SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  unused(type, xpose, alpha, x_robj, ret_robj);
  WARN_AND_RETURN;
}
