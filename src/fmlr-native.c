#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include <stdlib.h>

#include "types.h"


// card
extern SEXP R_card_get_id(SEXP);
extern SEXP R_card_info(SEXP);
extern SEXP R_card_init(SEXP);
extern SEXP R_card_set(SEXP, SEXP);
extern SEXP R_card_synch(SEXP);
extern SEXP R_card_valid_card(SEXP);

// cpumat
extern SEXP R_cpumat_antidiag(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_cpu2cpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_diag(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_dim(SEXP, SEXP);
extern SEXP R_cpumat_dimops_colsweep(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_dimops_matsums(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_dimops_rowsweep(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_dimops_scale(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_dupe(SEXP, SEXP);
extern SEXP R_cpumat_fill_diag(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_eye(SEXP, SEXP);
extern SEXP R_cpumat_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_rnorm(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_runif(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_zero(SEXP, SEXP);
extern SEXP R_cpumat_from_robj(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_get(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_get_col(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_get_row(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_info(SEXP, SEXP);
extern SEXP R_cpumat_inherit(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_init(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_add(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_chol(SEXP, SEXP);
extern SEXP R_cpumat_linalg_cond(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_cpsvd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_crossprod(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_det(SEXP, SEXP);
extern SEXP R_cpumat_linalg_dot(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_eigen_sym(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_invert(SEXP, SEXP);
extern SEXP R_cpumat_linalg_lq(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_lq_L(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_lq_Q(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_lu(SEXP, SEXP);
extern SEXP R_cpumat_linalg_matmult(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_norm(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_qr(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_qr_Q(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_qr_R(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_rsvd(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_solve(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_svd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_trace(SEXP, SEXP);
extern SEXP R_cpumat_linalg_trinv(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_qrsvd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_xpose(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_print(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_resize(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_rev_cols(SEXP, SEXP);
extern SEXP R_cpumat_rev_rows(SEXP, SEXP);
extern SEXP R_cpumat_scale(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_set(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_stats_pca(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_to_robj(SEXP, SEXP);

// cpuvec
extern SEXP R_cpuvec_cpu2cpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_dupe(SEXP, SEXP);
extern SEXP R_cpuvec_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_fill_zero(SEXP, SEXP);
extern SEXP R_cpuvec_from_robj(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_get(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_info(SEXP, SEXP);
extern SEXP R_cpuvec_inherit(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_init(SEXP, SEXP);
extern SEXP R_cpuvec_max(SEXP, SEXP);
extern SEXP R_cpuvec_min(SEXP, SEXP);
extern SEXP R_cpuvec_pow(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_print(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_resize(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_rev(SEXP, SEXP);
extern SEXP R_cpuvec_scale(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_set(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_size(SEXP, SEXP);
extern SEXP R_cpuvec_sum(SEXP, SEXP);
extern SEXP R_cpuvec_to_robj(SEXP, SEXP);

// gpumat
extern SEXP R_gpumat_antidiag(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_cpu2gpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_diag(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_dim(SEXP, SEXP);
extern SEXP R_gpumat_dimops_colsweep(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_dimops_matsums(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_dimops_rowsweep(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_dimops_scale(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_dupe(SEXP, SEXP);
extern SEXP R_gpumat_fill_diag(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_eye(SEXP, SEXP);
extern SEXP R_gpumat_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_rnorm(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_runif(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_zero(SEXP, SEXP);
extern SEXP R_gpumat_from_robj(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_get(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_get_col(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_get_row(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_gpu2cpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_gpu2gpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_info(SEXP, SEXP);
extern SEXP R_gpumat_init(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_add(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_chol(SEXP, SEXP);
extern SEXP R_gpumat_linalg_cond(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_cpsvd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_crossprod(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_det(SEXP, SEXP);
extern SEXP R_gpumat_linalg_dot(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_eigen_sym(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_invert(SEXP, SEXP);
extern SEXP R_gpumat_linalg_lq(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_lq_L(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_lq_Q(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_lu(SEXP, SEXP);
extern SEXP R_gpumat_linalg_matmult(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_norm(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_qr(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_qr_Q(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_qr_R(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_rsvd(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_solve(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_svd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_trace(SEXP, SEXP);
extern SEXP R_gpumat_linalg_trinv(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_qrsvd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_xpose(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_print(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_resize(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_rev_cols(SEXP, SEXP);
extern SEXP R_gpumat_rev_rows(SEXP, SEXP);
extern SEXP R_gpumat_scale(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_set(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_stats_pca(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_to_robj(SEXP, SEXP);

// gpuvec
extern SEXP R_gpuvec_cpu2gpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_dupe(SEXP, SEXP);
extern SEXP R_gpuvec_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_fill_zero(SEXP, SEXP);
extern SEXP R_gpuvec_from_robj(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_get(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_gpu2cpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_gpu2gpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_info(SEXP, SEXP);
extern SEXP R_gpuvec_init(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_max(SEXP, SEXP);
extern SEXP R_gpuvec_min(SEXP, SEXP);
extern SEXP R_gpuvec_pow(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_print(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_resize(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_rev(SEXP, SEXP);
extern SEXP R_gpuvec_scale(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_set(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_size(SEXP, SEXP);
extern SEXP R_gpuvec_sum(SEXP, SEXP);
extern SEXP R_gpuvec_to_robj(SEXP, SEXP);

// grid
extern SEXP R_grid_barrier(SEXP, SEXP);
extern SEXP R_grid_exit(SEXP);
extern SEXP R_grid_finalize(SEXP, SEXP);
extern SEXP R_grid_ictxt(SEXP);
extern SEXP R_grid_info(SEXP);
extern SEXP R_grid_ingrid(SEXP);
extern SEXP R_grid_init(SEXP);
extern SEXP R_grid_mycol(SEXP);
extern SEXP R_grid_myrow(SEXP);
extern SEXP R_grid_npcol(SEXP);
extern SEXP R_grid_nprocs(SEXP);
extern SEXP R_grid_nprow(SEXP);
extern SEXP R_grid_rank0(SEXP);
extern SEXP R_grid_set(SEXP, SEXP);
extern SEXP R_grid_valid_grid(SEXP);

// mpimat
extern SEXP R_mpimat_antidiag(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_bfdim(SEXP, SEXP);
extern SEXP R_mpimat_cpu2mpi(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_diag(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_dim(SEXP, SEXP);
extern SEXP R_mpimat_dimops_colsweep(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_dimops_matsums(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_dimops_rowsweep(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_dimops_scale(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_dupe(SEXP, SEXP);
extern SEXP R_mpimat_fill_diag(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_fill_eye(SEXP, SEXP);
extern SEXP R_mpimat_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_fill_rnorm(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_fill_runif(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_fill_zero(SEXP, SEXP);
extern SEXP R_mpimat_from_robj(SEXP, SEXP);
extern SEXP R_mpimat_get(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_get_col(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_get_row(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_info(SEXP, SEXP);
extern SEXP R_mpimat_init(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_ldim(SEXP, SEXP);
extern SEXP R_mpimat_linalg_add(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_chol(SEXP, SEXP);
extern SEXP R_mpimat_linalg_cond(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_cpsvd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_crossprod(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_det(SEXP, SEXP);
extern SEXP R_mpimat_linalg_dot(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_eigen_sym(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_invert(SEXP, SEXP);
extern SEXP R_mpimat_linalg_lq(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_lq_L(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_lq_Q(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_lu(SEXP, SEXP);
extern SEXP R_mpimat_linalg_matmult(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_norm(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_qr(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_qr_Q(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_qr_R(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_rsvd(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_solve(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_svd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_trace(SEXP, SEXP);
extern SEXP R_mpimat_linalg_trinv(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_qrsvd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_xpose(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_mpi2cpu(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_mpi2mpi(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_print(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_resize(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_rev_cols(SEXP, SEXP);
extern SEXP R_mpimat_rev_rows(SEXP, SEXP);
extern SEXP R_mpimat_scale(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_set(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_stats_pca(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_to_robj(SEXP, SEXP);


#define INT(x) (INTEGER(x)[0])

#define CALL_RFUN(FUN, backend, ...) \
  SEXP ret; \
  if (INT(backend) == BACKEND_CPU){ \
    PROTECT(ret = R_cpumat_ ## FUN(__VA_ARGS__)); \
  } else if (INT(backend) == BACKEND_GPU){ \
    PROTECT(ret = R_gpumat_ ## FUN(__VA_ARGS__)); \
  } else { \
    PROTECT(ret = R_mpimat_ ## FUN(__VA_ARGS__)); \
  } \
  UNPROTECT(1); \
  return ret;



// -----------------------------------------------------------------------------
// linalg
// -----------------------------------------------------------------------------

SEXP R_linalg_add(SEXP backend, SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP beta, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  CALL_RFUN(linalg_add, backend, type, transx, transy, alpha, beta, x_robj, y_robj, ret_robj);
}

SEXP R_linalg_chol(SEXP backend, SEXP type, SEXP x_robj)
{
  CALL_RFUN(linalg_chol, backend, type, x_robj);
}

SEXP R_linalg_cond(SEXP backend, SEXP type, SEXP x_robj, SEXP norm)
{
  CALL_RFUN(linalg_cond, backend, type, x_robj, norm);
}

SEXP R_linalg_cpsvd(SEXP backend, SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  CALL_RFUN(linalg_cpsvd, backend, type, x_robj, s_robj, u_robj, vt_robj);
}

SEXP R_linalg_crossprod(SEXP backend, SEXP type, SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  CALL_RFUN(linalg_crossprod, backend, type, xpose, alpha, x_robj, ret_robj);
}

SEXP R_linalg_dot(SEXP backend, SEXP type, SEXP x_robj, SEXP y_robj)
{
  CALL_RFUN(linalg_dot, backend, type, x_robj, y_robj);
}

SEXP R_linalg_det(SEXP backend, SEXP type, SEXP x_robj)
{
  CALL_RFUN(linalg_det, backend, type, x_robj);
}

SEXP R_linalg_eigen_sym(SEXP backend, SEXP type, SEXP x_robj, SEXP values_robj, SEXP vectors_robj)
{
  CALL_RFUN(linalg_eigen_sym, backend, type, x_robj, values_robj, vectors_robj);
}

SEXP R_linalg_invert(SEXP backend, SEXP type, SEXP x_robj)
{
  CALL_RFUN(linalg_invert, backend, type, x_robj);
}

SEXP R_linalg_lq(SEXP backend, SEXP type, SEXP x_robj, SEXP qraux_robj)
{
  CALL_RFUN(linalg_lq, backend, type, x_robj, qraux_robj);
}

SEXP R_linalg_lq_L(SEXP backend, SEXP type, SEXP QR_robj, SEXP L_robj)
{
  CALL_RFUN(linalg_lq_L, backend, type, QR_robj, L_robj);
}

SEXP R_linalg_lq_Q(SEXP backend, SEXP type, SEXP QR_robj, SEXP qraux_robj, SEXP Q_robj, SEXP work_robj)
{
  CALL_RFUN(linalg_lq_Q, backend, type, QR_robj, qraux_robj, Q_robj, work_robj);
}

SEXP R_linalg_lu(SEXP backend, SEXP type, SEXP x_robj)
{
  CALL_RFUN(linalg_lu, backend, type, x_robj);
}

SEXP R_linalg_matmult(SEXP backend, SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP x_class, SEXP x_robj, SEXP y_class, SEXP y_robj, SEXP ret_robj)
{
  CALL_RFUN(linalg_matmult, backend, type, transx, transy, alpha, x_class, x_robj, y_class, y_robj, ret_robj);
}

SEXP R_linalg_norm(SEXP backend, SEXP type, SEXP x_robj, SEXP norm)
{
  CALL_RFUN(linalg_norm, backend, type, x_robj, norm);
}

SEXP R_linalg_qr(SEXP backend, SEXP type, SEXP x_robj, SEXP qraux_robj)
{
  CALL_RFUN(linalg_qr, backend, type, x_robj, qraux_robj);
}

SEXP R_linalg_qr_Q(SEXP backend, SEXP type, SEXP QR_robj, SEXP qraux_robj, SEXP Q_robj, SEXP work_robj)
{
  CALL_RFUN(linalg_qr_Q, backend, type, QR_robj, qraux_robj, Q_robj, work_robj);
}

SEXP R_linalg_qr_R(SEXP backend, SEXP type, SEXP QR_robj, SEXP R_robj)
{
  CALL_RFUN(linalg_qr_R, backend, type, QR_robj, R_robj);
}

SEXP R_linalg_rsvd(SEXP backend, SEXP type, SEXP seed, SEXP k, SEXP q, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  CALL_RFUN(linalg_rsvd, backend, type, seed, k, q, x_robj, s_robj, u_robj, vt_robj);
}

SEXP R_linalg_solve(SEXP backend, SEXP type, SEXP x_robj, SEXP y_class, SEXP y_robj)
{
  CALL_RFUN(linalg_solve, backend, type, x_robj, y_class, y_robj);
}

SEXP R_linalg_svd(SEXP backend, SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  CALL_RFUN(linalg_svd, backend, type, x_robj, s_robj, u_robj, vt_robj);
}

SEXP R_linalg_trace(SEXP backend, SEXP type, SEXP x_robj)
{
  CALL_RFUN(linalg_trace, backend, type, x_robj);
}

SEXP R_linalg_trinv(SEXP backend, SEXP type, SEXP upper, SEXP unit_diag, SEXP x_robj)
{
  CALL_RFUN(linalg_trinv, backend, type, upper, unit_diag, x_robj);
}

SEXP R_linalg_qrsvd(SEXP backend, SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  CALL_RFUN(linalg_qrsvd, backend, type, x_robj, s_robj, u_robj, vt_robj);
}

SEXP R_linalg_xpose(SEXP backend, SEXP type, SEXP x_robj, SEXP ret_robj)
{
  CALL_RFUN(linalg_xpose, backend, type, x_robj, ret_robj);
}

// -----------------------------------------------------------------------------
// dimops
// -----------------------------------------------------------------------------

SEXP R_dimops_matsums(SEXP backend, SEXP type, SEXP row, SEXP mean, SEXP x_robj, SEXP s_robj)
{
  CALL_RFUN(dimops_matsums, backend, type, row, mean, x_robj, s_robj);
}

SEXP R_dimops_scale(SEXP backend, SEXP type, SEXP rm_mean, SEXP rm_sd, SEXP x_robj)
{
  CALL_RFUN(dimops_scale, backend, type, rm_mean, rm_sd, x_robj);
}

SEXP R_dimops_rowsweep(SEXP backend, SEXP type, SEXP x_robj, SEXP s_robj, SEXP op)
{
  CALL_RFUN(dimops_rowsweep, backend, type, x_robj, s_robj, op);
}

SEXP R_dimops_colsweep(SEXP backend, SEXP type, SEXP x_robj, SEXP s_robj, SEXP op)
{
  CALL_RFUN(dimops_colsweep, backend, type, x_robj, s_robj, op);
}

// -----------------------------------------------------------------------------
// stats
// -----------------------------------------------------------------------------

SEXP R_stats_pca(SEXP backend, SEXP type, SEXP rm_mean, SEXP rm_sd, SEXP x_robj, SEXP sdev_robj, SEXP rot_robj)
{
  CALL_RFUN(stats_pca, backend, type, rm_mean, rm_sd, x_robj, sdev_robj, rot_robj);
}



// -----------------------------------------------------------------------------
// registration
// -----------------------------------------------------------------------------

static const R_CallMethodDef CallEntries[] = {
  // card
  {"R_card_get_id",             (DL_FUNC) &R_card_get_id,             1},
  {"R_card_info",               (DL_FUNC) &R_card_info,               1},
  {"R_card_init",               (DL_FUNC) &R_card_init,               1},
  {"R_card_set",                (DL_FUNC) &R_card_set,                2},
  {"R_card_synch",              (DL_FUNC) &R_card_synch,              1},
  {"R_card_valid_card",         (DL_FUNC) &R_card_valid_card,         1},
  // cpumat 
  {"R_cpumat_antidiag",         (DL_FUNC) &R_cpumat_antidiag,         3},
  {"R_cpumat_cpu2cpu",          (DL_FUNC) &R_cpumat_cpu2cpu,          4},
  {"R_cpumat_diag",             (DL_FUNC) &R_cpumat_diag,             3},
  {"R_cpumat_dim",              (DL_FUNC) &R_cpumat_dim,              2},
  {"R_cpumat_dupe",             (DL_FUNC) &R_cpumat_dupe,             2},
  {"R_cpumat_fill_diag",        (DL_FUNC) &R_cpumat_fill_diag,        3},
  {"R_cpumat_fill_eye",         (DL_FUNC) &R_cpumat_fill_eye,         2},
  {"R_cpumat_fill_linspace",    (DL_FUNC) &R_cpumat_fill_linspace,    4},
  {"R_cpumat_fill_rnorm",       (DL_FUNC) &R_cpumat_fill_rnorm,       5},
  {"R_cpumat_fill_runif",       (DL_FUNC) &R_cpumat_fill_runif,       5},
  {"R_cpumat_fill_val",         (DL_FUNC) &R_cpumat_fill_val,         3},
  {"R_cpumat_fill_zero",        (DL_FUNC) &R_cpumat_fill_zero,        2},
  {"R_cpumat_from_robj",        (DL_FUNC) &R_cpumat_from_robj,        4},
  {"R_cpumat_get",              (DL_FUNC) &R_cpumat_get,              4},
  {"R_cpumat_get_col",          (DL_FUNC) &R_cpumat_get_col,          4},
  {"R_cpumat_get_row",          (DL_FUNC) &R_cpumat_get_row,          4},
  {"R_cpumat_info",             (DL_FUNC) &R_cpumat_info,             2},
  {"R_cpumat_inherit",          (DL_FUNC) &R_cpumat_inherit,          3},
  {"R_cpumat_init",             (DL_FUNC) &R_cpumat_init,             3},
  {"R_cpumat_print",            (DL_FUNC) &R_cpumat_print,            3},
  {"R_cpumat_resize",           (DL_FUNC) &R_cpumat_resize,           4},
  {"R_cpumat_rev_cols",         (DL_FUNC) &R_cpumat_rev_cols,         2},
  {"R_cpumat_rev_rows",         (DL_FUNC) &R_cpumat_rev_rows,         2},
  {"R_cpumat_scale",            (DL_FUNC) &R_cpumat_scale,            3},
  {"R_cpumat_set",              (DL_FUNC) &R_cpumat_set,              5},
  // cpuvec
  {"R_cpumat_to_robj",          (DL_FUNC) &R_cpumat_to_robj,          2},
  {"R_cpuvec_cpu2cpu",          (DL_FUNC) &R_cpuvec_cpu2cpu,          4},
  {"R_cpuvec_dupe",             (DL_FUNC) &R_cpuvec_dupe,             2},
  {"R_cpuvec_fill_linspace",    (DL_FUNC) &R_cpuvec_fill_linspace,    4},
  {"R_cpuvec_fill_val",         (DL_FUNC) &R_cpuvec_fill_val,         3},
  {"R_cpuvec_fill_zero",        (DL_FUNC) &R_cpuvec_fill_zero,        2},
  {"R_cpuvec_from_robj",        (DL_FUNC) &R_cpuvec_from_robj,        4},
  {"R_cpuvec_get",              (DL_FUNC) &R_cpuvec_get,              3},
  {"R_cpuvec_info",             (DL_FUNC) &R_cpuvec_info,             2},
  {"R_cpuvec_inherit",          (DL_FUNC) &R_cpuvec_inherit,          3},
  {"R_cpuvec_init",             (DL_FUNC) &R_cpuvec_init,             2},
  {"R_cpuvec_max",              (DL_FUNC) &R_cpuvec_max,              2},
  {"R_cpuvec_min",              (DL_FUNC) &R_cpuvec_min,              2},
  {"R_cpuvec_pow",              (DL_FUNC) &R_cpuvec_pow,              3},
  {"R_cpuvec_print",            (DL_FUNC) &R_cpuvec_print,            3},
  {"R_cpuvec_resize",           (DL_FUNC) &R_cpuvec_resize,           3},
  {"R_cpuvec_rev",              (DL_FUNC) &R_cpuvec_rev,              2},
  {"R_cpuvec_scale",            (DL_FUNC) &R_cpuvec_scale,            3},
  {"R_cpuvec_set",              (DL_FUNC) &R_cpuvec_set,              4},
  {"R_cpuvec_size",             (DL_FUNC) &R_cpuvec_size,             2},
  {"R_cpuvec_sum",              (DL_FUNC) &R_cpuvec_sum,              2},
  {"R_cpuvec_to_robj",          (DL_FUNC) &R_cpuvec_to_robj,          2},
  // dimops
  {"R_dimops_colsweep",         (DL_FUNC) &R_dimops_colsweep,         5},
  {"R_dimops_matsums",          (DL_FUNC) &R_dimops_matsums,          6},
  {"R_dimops_rowsweep",         (DL_FUNC) &R_dimops_rowsweep,         5},
  {"R_dimops_scale",            (DL_FUNC) &R_dimops_scale,            5},
  // gpumat
  {"R_gpumat_antidiag",         (DL_FUNC) &R_gpumat_antidiag,         3},
  {"R_gpumat_cpu2gpu",          (DL_FUNC) &R_gpumat_cpu2gpu,          4},
  {"R_gpumat_diag",             (DL_FUNC) &R_gpumat_diag,             3},
  {"R_gpumat_dim",              (DL_FUNC) &R_gpumat_dim,              2},
  {"R_gpumat_dupe",             (DL_FUNC) &R_gpumat_dupe,             2},
  {"R_gpumat_fill_diag",        (DL_FUNC) &R_gpumat_fill_diag,        3},
  {"R_gpumat_fill_eye",         (DL_FUNC) &R_gpumat_fill_eye,         2},
  {"R_gpumat_fill_linspace",    (DL_FUNC) &R_gpumat_fill_linspace,    4},
  {"R_gpumat_fill_rnorm",       (DL_FUNC) &R_gpumat_fill_rnorm,       5},
  {"R_gpumat_fill_runif",       (DL_FUNC) &R_gpumat_fill_runif,       5},
  {"R_gpumat_fill_val",         (DL_FUNC) &R_gpumat_fill_val,         3},
  {"R_gpumat_fill_zero",        (DL_FUNC) &R_gpumat_fill_zero,        2},
  {"R_gpumat_from_robj",        (DL_FUNC) &R_gpumat_from_robj,        4},
  {"R_gpumat_get",              (DL_FUNC) &R_gpumat_get,              4},
  {"R_gpumat_get_col",          (DL_FUNC) &R_gpumat_get_col,          4},
  {"R_gpumat_get_row",          (DL_FUNC) &R_gpumat_get_row,          4},
  {"R_gpumat_gpu2cpu",          (DL_FUNC) &R_gpumat_gpu2cpu,          4},
  {"R_gpumat_gpu2gpu",          (DL_FUNC) &R_gpumat_gpu2gpu,          4},
  {"R_gpumat_info",             (DL_FUNC) &R_gpumat_info,             2},
  {"R_gpumat_init",             (DL_FUNC) &R_gpumat_init,             5},
  {"R_gpumat_print",            (DL_FUNC) &R_gpumat_print,            3},
  {"R_gpumat_resize",           (DL_FUNC) &R_gpumat_resize,           4},
  {"R_gpumat_rev_cols",         (DL_FUNC) &R_gpumat_rev_cols,         2},
  {"R_gpumat_rev_rows",         (DL_FUNC) &R_gpumat_rev_rows,         2},
  {"R_gpumat_scale",            (DL_FUNC) &R_gpumat_scale,            3},
  {"R_gpumat_set",              (DL_FUNC) &R_gpumat_set,              5},
  {"R_gpumat_to_robj",          (DL_FUNC) &R_gpumat_to_robj,          2},
  // gpuvec
  {"R_gpuvec_cpu2gpu",          (DL_FUNC) &R_gpuvec_cpu2gpu,          4},
  {"R_gpuvec_dupe",             (DL_FUNC) &R_gpuvec_dupe,             2},
  {"R_gpuvec_fill_linspace",    (DL_FUNC) &R_gpuvec_fill_linspace,    4},
  {"R_gpuvec_fill_val",         (DL_FUNC) &R_gpuvec_fill_val,         3},
  {"R_gpuvec_fill_zero",        (DL_FUNC) &R_gpuvec_fill_zero,        2},
  {"R_gpuvec_from_robj",        (DL_FUNC) &R_gpuvec_from_robj,        4},
  {"R_gpuvec_get",              (DL_FUNC) &R_gpuvec_get,              3},
  {"R_gpuvec_gpu2cpu",          (DL_FUNC) &R_gpuvec_gpu2cpu,          4},
  {"R_gpuvec_gpu2gpu",          (DL_FUNC) &R_gpuvec_gpu2gpu,          4},
  {"R_gpuvec_info",             (DL_FUNC) &R_gpuvec_info,             2},
  {"R_gpuvec_init",             (DL_FUNC) &R_gpuvec_init,             4},
  {"R_gpuvec_max",              (DL_FUNC) &R_gpuvec_max,              2},
  {"R_gpuvec_min",              (DL_FUNC) &R_gpuvec_min,              2},
  {"R_gpuvec_pow",              (DL_FUNC) &R_gpuvec_pow,              3},
  {"R_gpuvec_print",            (DL_FUNC) &R_gpuvec_print,            3},
  {"R_gpuvec_resize",           (DL_FUNC) &R_gpuvec_resize,           3},
  {"R_gpuvec_rev",              (DL_FUNC) &R_gpuvec_rev,              2},
  {"R_gpuvec_scale",            (DL_FUNC) &R_gpuvec_scale,            3},
  {"R_gpuvec_set",              (DL_FUNC) &R_gpuvec_set,              4},
  {"R_gpuvec_size",             (DL_FUNC) &R_gpuvec_size,             2},
  {"R_gpuvec_sum",              (DL_FUNC) &R_gpuvec_sum,              2},
  {"R_gpuvec_to_robj",          (DL_FUNC) &R_gpuvec_to_robj,          2},
  // grid
  {"R_grid_barrier",            (DL_FUNC) &R_grid_barrier,            2},
  {"R_grid_exit",               (DL_FUNC) &R_grid_exit,               1},
  {"R_grid_finalize",           (DL_FUNC) &R_grid_finalize,           2},
  {"R_grid_ictxt",              (DL_FUNC) &R_grid_ictxt,              1},
  {"R_grid_info",               (DL_FUNC) &R_grid_info,               1},
  {"R_grid_ingrid",             (DL_FUNC) &R_grid_ingrid,             1},
  {"R_grid_init",               (DL_FUNC) &R_grid_init,               1},
  {"R_grid_mycol",              (DL_FUNC) &R_grid_mycol,              1},
  {"R_grid_myrow",              (DL_FUNC) &R_grid_myrow,              1},
  {"R_grid_npcol",              (DL_FUNC) &R_grid_npcol,              1},
  {"R_grid_nprocs",             (DL_FUNC) &R_grid_nprocs,             1},
  {"R_grid_nprow",              (DL_FUNC) &R_grid_nprow,              1},
  {"R_grid_rank0",              (DL_FUNC) &R_grid_rank0,              1},
  {"R_grid_set",                (DL_FUNC) &R_grid_set,                2},
  {"R_grid_valid_grid",         (DL_FUNC) &R_grid_valid_grid,         1},
  // linalg
  {"R_linalg_add",              (DL_FUNC) &R_linalg_add,              9},
  {"R_linalg_chol",             (DL_FUNC) &R_linalg_chol,             3},
  {"R_linalg_cond",             (DL_FUNC) &R_linalg_cond,             4},
  {"R_linalg_cpsvd",            (DL_FUNC) &R_linalg_cpsvd,            6},
  {"R_linalg_crossprod",        (DL_FUNC) &R_linalg_crossprod,        6},
  {"R_linalg_det",              (DL_FUNC) &R_linalg_det,              3},
  {"R_linalg_dot",              (DL_FUNC) &R_linalg_dot,              4},
  {"R_linalg_eigen_sym",        (DL_FUNC) &R_linalg_svd,              5},
  {"R_linalg_invert",           (DL_FUNC) &R_linalg_invert,           3},
  {"R_linalg_lu",               (DL_FUNC) &R_linalg_lu,               3},
  {"R_linalg_lq",               (DL_FUNC) &R_linalg_lq,               4},
  {"R_linalg_lq_L",             (DL_FUNC) &R_linalg_lq_L,             4},
  {"R_linalg_lq_Q",             (DL_FUNC) &R_linalg_lq_Q,             6},
  {"R_linalg_matmult",          (DL_FUNC) &R_linalg_matmult,         10},
  {"R_linalg_norm",             (DL_FUNC) &R_linalg_norm,             4},
  {"R_linalg_qr",               (DL_FUNC) &R_linalg_qr,               4},
  {"R_linalg_qr_Q",             (DL_FUNC) &R_linalg_qr_Q,             6},
  {"R_linalg_qr_R",             (DL_FUNC) &R_linalg_qr_R,             4},
  {"R_linalg_rsvd",             (DL_FUNC) &R_linalg_rsvd,             9},
  {"R_linalg_svd",              (DL_FUNC) &R_linalg_svd,              6},
  {"R_linalg_solve",            (DL_FUNC) &R_linalg_solve,            5},
  {"R_linalg_trace",            (DL_FUNC) &R_linalg_trace,            3},
  {"R_linalg_trinv",            (DL_FUNC) &R_linalg_trinv,            5},
  {"R_linalg_qrsvd",            (DL_FUNC) &R_linalg_qrsvd,            6},
  {"R_linalg_xpose",            (DL_FUNC) &R_linalg_xpose,            4},
  // mpimat
  {"R_mpimat_antidiag",         (DL_FUNC) &R_mpimat_antidiag,         3},
  {"R_mpimat_bfdim",            (DL_FUNC) &R_mpimat_bfdim,            2},
  {"R_mpimat_cpu2mpi",          (DL_FUNC) &R_mpimat_cpu2mpi,          4},
  {"R_mpimat_diag",             (DL_FUNC) &R_mpimat_diag,             3},
  {"R_mpimat_dim",              (DL_FUNC) &R_mpimat_dim,              2},
  {"R_mpimat_dupe",             (DL_FUNC) &R_mpimat_dupe,             2},
  {"R_mpimat_fill_diag",        (DL_FUNC) &R_mpimat_fill_diag,        3},
  {"R_mpimat_fill_eye",         (DL_FUNC) &R_mpimat_fill_eye,         2},
  {"R_mpimat_fill_linspace",    (DL_FUNC) &R_mpimat_fill_linspace,    4},
  {"R_mpimat_fill_rnorm",       (DL_FUNC) &R_mpimat_fill_rnorm,       5},
  {"R_mpimat_fill_runif",       (DL_FUNC) &R_mpimat_fill_runif,       5},
  {"R_mpimat_fill_val",         (DL_FUNC) &R_mpimat_fill_val,         3},
  {"R_mpimat_fill_zero",        (DL_FUNC) &R_mpimat_fill_zero,        2},
  {"R_mpimat_from_robj",        (DL_FUNC) &R_mpimat_from_robj,        2},
  {"R_mpimat_get",              (DL_FUNC) &R_mpimat_get,              4},
  {"R_mpimat_get_col",          (DL_FUNC) &R_mpimat_get_col,          4},
  {"R_mpimat_get_row",          (DL_FUNC) &R_mpimat_get_row,          4},
  {"R_mpimat_info",             (DL_FUNC) &R_mpimat_info,             2},
  {"R_mpimat_init",             (DL_FUNC) &R_mpimat_init,             7},
  {"R_mpimat_ldim",             (DL_FUNC) &R_mpimat_ldim,             2},
  {"R_mpimat_mpi2cpu",          (DL_FUNC) &R_mpimat_mpi2cpu,          6},
  {"R_mpimat_mpi2mpi",          (DL_FUNC) &R_mpimat_mpi2mpi,          4},
  {"R_mpimat_print",            (DL_FUNC) &R_mpimat_print,            3},
  {"R_mpimat_resize",           (DL_FUNC) &R_mpimat_resize,           4},
  {"R_mpimat_rev_cols",         (DL_FUNC) &R_mpimat_rev_cols,         2},
  {"R_mpimat_rev_rows",         (DL_FUNC) &R_mpimat_rev_rows,         2},
  {"R_mpimat_scale",            (DL_FUNC) &R_mpimat_scale,            3},
  {"R_mpimat_set",              (DL_FUNC) &R_mpimat_set,              5},
  {"R_mpimat_to_robj",          (DL_FUNC) &R_mpimat_to_robj,          2},
  // stats
  {"R_stats_pca",   (DL_FUNC) &R_stats_pca,   7},
  // 
  {NULL, NULL, 0}
};

void R_init_fmlr(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
