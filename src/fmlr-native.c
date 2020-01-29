/* Automatically generated. Do not edit by hand. */

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include <stdlib.h>

extern SEXP R_card_get_id(SEXP);
extern SEXP R_card_info(SEXP);
extern SEXP R_card_init(SEXP);
extern SEXP R_card_set(SEXP, SEXP);
extern SEXP R_card_valid_card(SEXP);
extern SEXP R_cpumat_antidiag(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_cpu2cpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_diag(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_dim(SEXP, SEXP);
extern SEXP R_cpumat_dupe(SEXP, SEXP);
extern SEXP R_cpumat_fill_diag(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_eye(SEXP, SEXP);
extern SEXP R_cpumat_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_rnorm(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_runif(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_fill_zero(SEXP, SEXP);
extern SEXP R_cpumat_from_robj(SEXP, SEXP);
extern SEXP R_cpumat_get(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_get_col(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_get_row(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_info(SEXP, SEXP);
extern SEXP R_cpumat_inherit(SEXP, SEXP);
extern SEXP R_cpumat_init(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_add(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_crossprod(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_eigen_sym(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_invert(SEXP, SEXP);
extern SEXP R_cpumat_linalg_lu(SEXP, SEXP);
extern SEXP R_cpumat_linalg_matmult(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_solve(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_svd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_linalg_trace(SEXP, SEXP);
extern SEXP R_cpumat_linalg_xpose(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_print(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_resize(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_rev_cols(SEXP, SEXP);
extern SEXP R_cpumat_rev_rows(SEXP, SEXP);
extern SEXP R_cpumat_scale(SEXP, SEXP, SEXP);
extern SEXP R_cpumat_set(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpumat_to_robj(SEXP, SEXP);
extern SEXP R_cpuvec_cpu2cpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_dupe(SEXP, SEXP);
extern SEXP R_cpuvec_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_fill_zero(SEXP, SEXP);
extern SEXP R_cpuvec_from_robj(SEXP, SEXP);
extern SEXP R_cpuvec_get(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_info(SEXP, SEXP);
extern SEXP R_cpuvec_inherit(SEXP, SEXP);
extern SEXP R_cpuvec_init(SEXP, SEXP);
extern SEXP R_cpuvec_print(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_resize(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_rev(SEXP, SEXP);
extern SEXP R_cpuvec_scale(SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_set(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_cpuvec_size(SEXP, SEXP);
extern SEXP R_cpuvec_sum(SEXP, SEXP);
extern SEXP R_cpuvec_to_robj(SEXP, SEXP);
extern SEXP R_gpumat_antidiag(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_cpu2gpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_diag(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_dim(SEXP, SEXP);
extern SEXP R_gpumat_dupe(SEXP, SEXP);
extern SEXP R_gpumat_fill_diag(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_eye(SEXP, SEXP);
extern SEXP R_gpumat_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_rnorm(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_runif(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_fill_zero(SEXP, SEXP);
extern SEXP R_gpumat_from_robj(SEXP, SEXP);
extern SEXP R_gpumat_get(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_get_col(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_get_row(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_gpu2cpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_gpu2gpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_info(SEXP, SEXP);
extern SEXP R_gpumat_init(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_add(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_crossprod(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_eigen_sym(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_invert(SEXP, SEXP);
extern SEXP R_gpumat_linalg_lu(SEXP, SEXP);
extern SEXP R_gpumat_linalg_matmult(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_solve(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_svd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_linalg_trace(SEXP, SEXP);
extern SEXP R_gpumat_linalg_xpose(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_print(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_resize(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_rev_cols(SEXP, SEXP);
extern SEXP R_gpumat_rev_rows(SEXP, SEXP);
extern SEXP R_gpumat_scale(SEXP, SEXP, SEXP);
extern SEXP R_gpumat_set(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpumat_to_robj(SEXP, SEXP);
extern SEXP R_gpuvec_cpu2gpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_dupe(SEXP, SEXP);
extern SEXP R_gpuvec_fill_linspace(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_fill_val(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_fill_zero(SEXP, SEXP);
extern SEXP R_gpuvec_from_robj(SEXP, SEXP);
extern SEXP R_gpuvec_get(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_gpu2cpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_gpu2gpu(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_info(SEXP, SEXP);
extern SEXP R_gpuvec_init(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_print(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_resize(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_rev(SEXP, SEXP);
extern SEXP R_gpuvec_scale(SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_set(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_gpuvec_size(SEXP, SEXP);
extern SEXP R_gpuvec_sum(SEXP, SEXP);
extern SEXP R_gpuvec_to_robj(SEXP, SEXP);
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
extern SEXP R_mpimat_antidiag(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_bfdim(SEXP, SEXP);
extern SEXP R_mpimat_diag(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_dim(SEXP, SEXP);
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
extern SEXP R_mpimat_linalg_crossprod(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_eigen_sym(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_invert(SEXP, SEXP);
extern SEXP R_mpimat_linalg_lu(SEXP, SEXP);
extern SEXP R_mpimat_linalg_matmult(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_solve(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_svd(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_linalg_trace(SEXP, SEXP);
extern SEXP R_mpimat_linalg_xpose(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_mpi2cpu(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_mpi2mpi(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_print(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_resize(SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_rev_cols(SEXP, SEXP);
extern SEXP R_mpimat_rev_rows(SEXP, SEXP);
extern SEXP R_mpimat_scale(SEXP, SEXP, SEXP);
extern SEXP R_mpimat_set(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP R_mpimat_to_robj(SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"R_card_get_id",             (DL_FUNC) &R_card_get_id,             1},
  {"R_card_info",               (DL_FUNC) &R_card_info,               1},
  {"R_card_init",               (DL_FUNC) &R_card_init,               1},
  {"R_card_set",                (DL_FUNC) &R_card_set,                2},
  {"R_card_valid_card",         (DL_FUNC) &R_card_valid_card,         1},
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
  {"R_cpumat_from_robj",        (DL_FUNC) &R_cpumat_from_robj,        2},
  {"R_cpumat_get",              (DL_FUNC) &R_cpumat_get,              4},
  {"R_cpumat_get_col",          (DL_FUNC) &R_cpumat_get_col,          4},
  {"R_cpumat_get_row",          (DL_FUNC) &R_cpumat_get_row,          4},
  {"R_cpumat_info",             (DL_FUNC) &R_cpumat_info,             2},
  {"R_cpumat_inherit",          (DL_FUNC) &R_cpumat_inherit,          2},
  {"R_cpumat_init",             (DL_FUNC) &R_cpumat_init,             3},
  {"R_cpumat_linalg_add",       (DL_FUNC) &R_cpumat_linalg_add,       8},
  {"R_cpumat_linalg_crossprod", (DL_FUNC) &R_cpumat_linalg_crossprod, 5},
  {"R_cpumat_linalg_eigen_sym", (DL_FUNC) &R_cpumat_linalg_eigen_sym, 4},
  {"R_cpumat_linalg_invert",    (DL_FUNC) &R_cpumat_linalg_invert,    2},
  {"R_cpumat_linalg_lu",        (DL_FUNC) &R_cpumat_linalg_lu,        2},
  {"R_cpumat_linalg_matmult",   (DL_FUNC) &R_cpumat_linalg_matmult,   7},
  {"R_cpumat_linalg_solve",     (DL_FUNC) &R_cpumat_linalg_solve,     4},
  {"R_cpumat_linalg_svd",       (DL_FUNC) &R_cpumat_linalg_svd,       5},
  {"R_cpumat_linalg_trace",     (DL_FUNC) &R_cpumat_linalg_trace,     2},
  {"R_cpumat_linalg_xpose",     (DL_FUNC) &R_cpumat_linalg_xpose,     3},
  {"R_cpumat_print",            (DL_FUNC) &R_cpumat_print,            3},
  {"R_cpumat_resize",           (DL_FUNC) &R_cpumat_resize,           4},
  {"R_cpumat_rev_cols",         (DL_FUNC) &R_cpumat_rev_cols,         2},
  {"R_cpumat_rev_rows",         (DL_FUNC) &R_cpumat_rev_rows,         2},
  {"R_cpumat_scale",            (DL_FUNC) &R_cpumat_scale,            3},
  {"R_cpumat_set",              (DL_FUNC) &R_cpumat_set,              5},
  {"R_cpumat_to_robj",          (DL_FUNC) &R_cpumat_to_robj,          2},
  {"R_cpuvec_cpu2cpu",          (DL_FUNC) &R_cpuvec_cpu2cpu,          4},
  {"R_cpuvec_dupe",             (DL_FUNC) &R_cpuvec_dupe,             2},
  {"R_cpuvec_fill_linspace",    (DL_FUNC) &R_cpuvec_fill_linspace,    4},
  {"R_cpuvec_fill_val",         (DL_FUNC) &R_cpuvec_fill_val,         3},
  {"R_cpuvec_fill_zero",        (DL_FUNC) &R_cpuvec_fill_zero,        2},
  {"R_cpuvec_from_robj",        (DL_FUNC) &R_cpuvec_from_robj,        2},
  {"R_cpuvec_get",              (DL_FUNC) &R_cpuvec_get,              3},
  {"R_cpuvec_info",             (DL_FUNC) &R_cpuvec_info,             2},
  {"R_cpuvec_inherit",          (DL_FUNC) &R_cpuvec_inherit,          2},
  {"R_cpuvec_init",             (DL_FUNC) &R_cpuvec_init,             2},
  {"R_cpuvec_print",            (DL_FUNC) &R_cpuvec_print,            3},
  {"R_cpuvec_resize",           (DL_FUNC) &R_cpuvec_resize,           3},
  {"R_cpuvec_rev",              (DL_FUNC) &R_cpuvec_rev,              2},
  {"R_cpuvec_scale",            (DL_FUNC) &R_cpuvec_scale,            3},
  {"R_cpuvec_set",              (DL_FUNC) &R_cpuvec_set,              4},
  {"R_cpuvec_size",             (DL_FUNC) &R_cpuvec_size,             2},
  {"R_cpuvec_sum",              (DL_FUNC) &R_cpuvec_sum,              2},
  {"R_cpuvec_to_robj",          (DL_FUNC) &R_cpuvec_to_robj,          2},
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
  {"R_gpumat_from_robj",        (DL_FUNC) &R_gpumat_from_robj,        2},
  {"R_gpumat_get",              (DL_FUNC) &R_gpumat_get,              4},
  {"R_gpumat_get_col",          (DL_FUNC) &R_gpumat_get_col,          4},
  {"R_gpumat_get_row",          (DL_FUNC) &R_gpumat_get_row,          4},
  {"R_gpumat_gpu2cpu",          (DL_FUNC) &R_gpumat_gpu2cpu,          4},
  {"R_gpumat_gpu2gpu",          (DL_FUNC) &R_gpumat_gpu2gpu,          4},
  {"R_gpumat_info",             (DL_FUNC) &R_gpumat_info,             2},
  {"R_gpumat_init",             (DL_FUNC) &R_gpumat_init,             5},
  {"R_gpumat_linalg_add",       (DL_FUNC) &R_gpumat_linalg_add,       8},
  {"R_gpumat_linalg_crossprod", (DL_FUNC) &R_gpumat_linalg_crossprod, 5},
  {"R_gpumat_linalg_eigen_sym", (DL_FUNC) &R_gpumat_linalg_eigen_sym, 4},
  {"R_gpumat_linalg_invert",    (DL_FUNC) &R_gpumat_linalg_invert,    2},
  {"R_gpumat_linalg_lu",        (DL_FUNC) &R_gpumat_linalg_lu,        2},
  {"R_gpumat_linalg_matmult",   (DL_FUNC) &R_gpumat_linalg_matmult,   7},
  {"R_gpumat_linalg_solve",     (DL_FUNC) &R_gpumat_linalg_solve,     4},
  {"R_gpumat_linalg_svd",       (DL_FUNC) &R_gpumat_linalg_svd,       5},
  {"R_gpumat_linalg_trace",     (DL_FUNC) &R_gpumat_linalg_trace,     2},
  {"R_gpumat_linalg_xpose",     (DL_FUNC) &R_gpumat_linalg_xpose,     3},
  {"R_gpumat_print",            (DL_FUNC) &R_gpumat_print,            3},
  {"R_gpumat_resize",           (DL_FUNC) &R_gpumat_resize,           4},
  {"R_gpumat_rev_cols",         (DL_FUNC) &R_gpumat_rev_cols,         2},
  {"R_gpumat_rev_rows",         (DL_FUNC) &R_gpumat_rev_rows,         2},
  {"R_gpumat_scale",            (DL_FUNC) &R_gpumat_scale,            3},
  {"R_gpumat_set",              (DL_FUNC) &R_gpumat_set,              5},
  {"R_gpumat_to_robj",          (DL_FUNC) &R_gpumat_to_robj,          2},
  {"R_gpuvec_cpu2gpu",          (DL_FUNC) &R_gpuvec_cpu2gpu,          4},
  {"R_gpuvec_dupe",             (DL_FUNC) &R_gpuvec_dupe,             2},
  {"R_gpuvec_fill_linspace",    (DL_FUNC) &R_gpuvec_fill_linspace,    4},
  {"R_gpuvec_fill_val",         (DL_FUNC) &R_gpuvec_fill_val,         3},
  {"R_gpuvec_fill_zero",        (DL_FUNC) &R_gpuvec_fill_zero,        2},
  {"R_gpuvec_from_robj",        (DL_FUNC) &R_gpuvec_from_robj,        2},
  {"R_gpuvec_get",              (DL_FUNC) &R_gpuvec_get,              3},
  {"R_gpuvec_gpu2cpu",          (DL_FUNC) &R_gpuvec_gpu2cpu,          4},
  {"R_gpuvec_gpu2gpu",          (DL_FUNC) &R_gpuvec_gpu2gpu,          4},
  {"R_gpuvec_info",             (DL_FUNC) &R_gpuvec_info,             2},
  {"R_gpuvec_init",             (DL_FUNC) &R_gpuvec_init,             4},
  {"R_gpuvec_print",            (DL_FUNC) &R_gpuvec_print,            3},
  {"R_gpuvec_resize",           (DL_FUNC) &R_gpuvec_resize,           3},
  {"R_gpuvec_rev",              (DL_FUNC) &R_gpuvec_rev,              2},
  {"R_gpuvec_scale",            (DL_FUNC) &R_gpuvec_scale,            3},
  {"R_gpuvec_set",              (DL_FUNC) &R_gpuvec_set,              4},
  {"R_gpuvec_size",             (DL_FUNC) &R_gpuvec_size,             2},
  {"R_gpuvec_sum",              (DL_FUNC) &R_gpuvec_sum,              2},
  {"R_gpuvec_to_robj",          (DL_FUNC) &R_gpuvec_to_robj,          2},
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
  {"R_mpimat_antidiag",         (DL_FUNC) &R_mpimat_antidiag,         3},
  {"R_mpimat_bfdim",            (DL_FUNC) &R_mpimat_bfdim,            2},
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
  {"R_mpimat_linalg_add",       (DL_FUNC) &R_mpimat_linalg_add,       8},
  {"R_mpimat_linalg_crossprod", (DL_FUNC) &R_mpimat_linalg_crossprod, 5},
  {"R_mpimat_linalg_eigen_sym", (DL_FUNC) &R_mpimat_linalg_eigen_sym, 4},
  {"R_mpimat_linalg_invert",    (DL_FUNC) &R_mpimat_linalg_invert,    2},
  {"R_mpimat_linalg_lu",        (DL_FUNC) &R_mpimat_linalg_lu,        2},
  {"R_mpimat_linalg_matmult",   (DL_FUNC) &R_mpimat_linalg_matmult,   7},
  {"R_mpimat_linalg_solve",     (DL_FUNC) &R_mpimat_linalg_solve,     4},
  {"R_mpimat_linalg_svd",       (DL_FUNC) &R_mpimat_linalg_svd,       5},
  {"R_mpimat_linalg_trace",     (DL_FUNC) &R_mpimat_linalg_trace,     2},
  {"R_mpimat_linalg_xpose",     (DL_FUNC) &R_mpimat_linalg_xpose,     3},
  {"R_mpimat_mpi2cpu",          (DL_FUNC) &R_mpimat_mpi2cpu,          6},
  {"R_mpimat_mpi2mpi",          (DL_FUNC) &R_mpimat_mpi2mpi,          4},
  {"R_mpimat_print",            (DL_FUNC) &R_mpimat_print,            3},
  {"R_mpimat_resize",           (DL_FUNC) &R_mpimat_resize,           4},
  {"R_mpimat_rev_cols",         (DL_FUNC) &R_mpimat_rev_cols,         2},
  {"R_mpimat_rev_rows",         (DL_FUNC) &R_mpimat_rev_rows,         2},
  {"R_mpimat_scale",            (DL_FUNC) &R_mpimat_scale,            3},
  {"R_mpimat_set",              (DL_FUNC) &R_mpimat_set,              5},
  {"R_mpimat_to_robj",          (DL_FUNC) &R_mpimat_to_robj,          2},
  {NULL, NULL, 0}
};

void R_init_fmlr(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
