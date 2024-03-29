#include "unused.hpp"

// -----------------------------------------------------------------------------
// card bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_card_init(SEXP id_)
{
  unused(id_);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_card_set(SEXP c_robj, SEXP id)
{
  unused(c_robj, id);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_card_synch(SEXP c_robj)
{
  unused(c_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_card_info(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_card_get_id(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_card_valid_card(SEXP x_robj)
{
  unused(x_robj);
  WARN_AND_RETURN("GPU");
}



// -----------------------------------------------------------------------------
// gpuvec bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpuvec_init(SEXP type, SEXP c_robj, SEXP size_)
{
  unused(type, c_robj, size_);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_size(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_inherit(SEXP type, SEXP x_robj, SEXP data)
{
  unused(type, x_robj, data);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_resize(SEXP type, SEXP x_robj, SEXP size)
{
  unused(type, x_robj, size);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_dupe(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  unused(type, x_robj, ndigits);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_info(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_fill_zero(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  unused(type, x_robj, v);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  unused(type, x_robj, start, stop);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_scale(SEXP type, SEXP x_robj, SEXP s)
{
  unused(type, x_robj, s);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_pow(SEXP type, SEXP x_robj, SEXP s)
{
  unused(type, x_robj, s);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_rev(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_sum(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_min(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_max(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_get(SEXP type, SEXP x_robj, SEXP i)
{
  unused(type, x_robj, i);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_set(SEXP type, SEXP x_robj, SEXP i, SEXP v)
{
  unused(type, x_robj, i, v);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_to_robj(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_from_robj(SEXP type, SEXP x_robj, SEXP type_robj, SEXP robj)
{
  unused(type, x_robj, type_robj, robj);
  WARN_AND_RETURN("GPU");
}



// -----------------------------------------------------------------------------
// gpumat bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_init(SEXP type, SEXP c_robj, SEXP m_, SEXP n_)
{
  unused(type, c_robj, m_, n_);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_dim(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_inherit(SEXP type, SEXP x_robj, SEXP data)
{
  unused(type, x_robj, data);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_resize(SEXP type, SEXP x_robj, SEXP m, SEXP n)
{
  unused(type, x_robj, m, n);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_dupe(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  unused(type, x_robj, ndigits);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_info(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_fill_zero(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  unused(type, x_robj, v);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  unused(type, x_robj, start, stop);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_fill_eye(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_fill_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_fill_runif(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  unused(type, x_robj, seed, min, max);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_fill_rnorm(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  unused(type, x_robj, seed, min, max);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_antidiag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_scale(SEXP type, SEXP x_robj, SEXP s)
{
  unused(type, x_robj, s);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_rev_rows(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_rev_cols(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_get(SEXP type, SEXP x_robj, SEXP i, SEXP j)
{
  unused(type, x_robj, i, j);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_set(SEXP type, SEXP x_robj, SEXP i, SEXP j, SEXP v)
{
  unused(type, x_robj, i, j, v);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_get_row(SEXP type, SEXP x_robj, SEXP i, SEXP v_robj)
{
  unused(type, x_robj, i, v_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_get_col(SEXP type, SEXP x_robj, SEXP j, SEXP v_robj)
{
  unused(type, x_robj, j, v_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_to_robj(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_from_robj(SEXP type, SEXP x_robj, SEXP robj)
{
  unused(type, x_robj, robj);
  WARN_AND_RETURN("GPU");
}



// -----------------------------------------------------------------------------
// gpuhelpers namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpuvec_gpu2cpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  unused(type_in, type_out, in_robj, out_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_gpu2cpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  unused(type_in, type_out, in_robj, out_robj);
  WARN_AND_RETURN("GPU");
}


extern "C" SEXP R_gpuvec_cpu2gpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  unused(type_in, type_out, in_robj, out_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_cpu2gpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  unused(type_in, type_out, in_robj, out_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpuvec_gpu2gpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  unused(type_in, type_out, in_robj, out_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_gpu2gpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  unused(type_in, type_out, in_robj, out_robj);
  WARN_AND_RETURN("GPU");
}



// -----------------------------------------------------------------------------
// linalg namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_linalg_add(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP beta, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  unused(type, transx, transy, alpha, beta, x_robj, y_robj, ret_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_matmult(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP x_class, SEXP x_robj, SEXP y_class, SEXP y_robj, SEXP ret_robj)
{
  unused(type, transx, transy, alpha, x_class, x_robj, y_class, y_robj, ret_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_crossprod(SEXP type, SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  unused(type, xpose, alpha, x_robj, ret_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_xpose(SEXP type, SEXP x_robj, SEXP ret_robj)
{
  unused(type, x_robj, ret_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_lu(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_det(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_dot(SEXP type, SEXP x_robj, SEXP y_robj)
{
  unused(type, x_robj, y_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_trace(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_svd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  unused(type, x_robj, s_robj, u_robj, vt_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_eigen_sym(SEXP type, SEXP x_robj, SEXP values_robj, SEXP vectors_robj)
{
  unused(type, x_robj, values_robj, vectors_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_invert(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_solve(SEXP type, SEXP x_robj, SEXP y_class, SEXP y_robj)
{
  unused(type, x_robj, y_class, y_robj);
  WARN_AND_RETURN("GPU");
}


extern "C" SEXP R_gpumat_linalg_qr(SEXP type, SEXP x_robj, SEXP qraux_robj)
{
  unused(type, x_robj, qraux_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_qr_Q(SEXP type, SEXP QR_robj, SEXP qraux_robj, SEXP Q_robj, SEXP work_robj)
{
  unused(type, QR_robj, qraux_robj, Q_robj, work_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_qr_R(SEXP type, SEXP QR_robj, SEXP R_robj)
{
  unused(type, QR_robj, R_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_lq(SEXP type, SEXP x_robj, SEXP lqaux_robj)
{
  unused(type, x_robj, lqaux_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_lq_L(SEXP type, SEXP LQ_robj, SEXP L_robj)
{
  unused(type, LQ_robj, L_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_lq_Q(SEXP type, SEXP LQ_robj, SEXP lqaux_robj, SEXP Q_robj, SEXP work_robj)
{
  unused(type, LQ_robj, lqaux_robj, Q_robj, work_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_qrsvd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  unused(type, x_robj, s_robj, u_robj, vt_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_cpsvd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  unused(type, x_robj, s_robj, u_robj, vt_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_chol(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_norm(SEXP type, SEXP x_robj, SEXP norm)
{
  unused(type, x_robj, norm);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_cond(SEXP type, SEXP x_robj, SEXP norm)
{
  unused(type, x_robj, norm);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_trinv(SEXP type, SEXP upper, SEXP unit_diag, SEXP x_robj)
{
  unused(type, upper, unit_diag, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_linalg_rsvd(SEXP type, SEXP seed, SEXP k, SEXP q, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  unused(type, seed, k, q, x_robj, s_robj, u_robj, vt_robj);
  WARN_AND_RETURN("GPU");
}



// -----------------------------------------------------------------------------
// dimops namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_dimops_matsums(SEXP type, SEXP row, SEXP mean, SEXP x_robj, SEXP s_robj)
{
  unused(type, row, mean, x_robj, s_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_dimops_scale(SEXP type, SEXP rm_mean, SEXP rm_sd, SEXP x_robj)
{
  unused(type, rm_mean, rm_sd, x_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_dimops_rowsweep(SEXP type, SEXP x_robj, SEXP s_robj, SEXP op)
{
  unused(type, x_robj, s_robj, op);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_dimops_colsweep(SEXP type, SEXP x_robj, SEXP s_robj, SEXP op)
{
  unused(type, x_robj, s_robj, op);
  WARN_AND_RETURN("GPU");
}



// -----------------------------------------------------------------------------
// stats namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_gpumat_stats_pca(SEXP type, SEXP rm_mean_, SEXP rm_sd_, SEXP x_robj, SEXP sdev_robj, SEXP rot_robj)
{
  unused(type, rm_mean_, rm_sd_, x_robj, sdev_robj, rot_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_stats_cov(SEXP type, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  unused(type, x_robj, y_robj, ret_robj);
  WARN_AND_RETURN("GPU");
}

extern "C" SEXP R_gpumat_stats_cor(SEXP type, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  unused(type, x_robj, y_robj, ret_robj);
  WARN_AND_RETURN("GPU");
}
