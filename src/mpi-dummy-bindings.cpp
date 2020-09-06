#include "unused.hpp"

// -----------------------------------------------------------------------------
// card bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_grid_init(SEXP gridtype)
{
  unused(gridtype);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_set(SEXP g_robj, SEXP blacs_context)
{
  unused(g_robj, blacs_context);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_exit(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_finalize(SEXP g_robj, SEXP mpi_continue)
{
  unused(g_robj, mpi_continue);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_info(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_rank0(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_ingrid(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_barrier(SEXP g_robj, SEXP scope)
{
  unused(g_robj, scope);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_ictxt(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_nprocs(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_nprow(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_npcol(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_myrow(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_mycol(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_grid_valid_grid(SEXP g_robj)
{
  unused(g_robj);
  WARN_AND_RETURN("MPI");
}



// -----------------------------------------------------------------------------
// mpimat bindings
// -----------------------------------------------------------------------------

extern "C" SEXP R_mpimat_init(SEXP type, SEXP c_robj, SEXP m_, SEXP n_)
{
  unused(type, c_robj, m_, n_);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_dim(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_ldim(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_bfdim(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_inherit(SEXP type, SEXP x_robj, SEXP data)
{
  unused(type, x_robj, data);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_resize(SEXP type, SEXP x_robj, SEXP m, SEXP n)
{
  unused(type, x_robj, m, n);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_dupe(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_print(SEXP type, SEXP x_robj, SEXP ndigits)
{
  unused(type, x_robj, ndigits);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_info(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_fill_zero(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_fill_val(SEXP type, SEXP x_robj, SEXP v)
{
  unused(type, x_robj, v);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_fill_linspace(SEXP type, SEXP x_robj, SEXP start, SEXP stop)
{
  unused(type, x_robj, start, stop);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_fill_eye(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_fill_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_fill_runif(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  unused(type, x_robj, seed, min, max);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_fill_rnorm(SEXP type, SEXP x_robj, SEXP seed, SEXP min, SEXP max)
{
  unused(type, x_robj, seed, min, max);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_diag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_antidiag(SEXP type, SEXP x_robj, SEXP v_robj)
{
  unused(type, x_robj, v_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_scale(SEXP type, SEXP x_robj, SEXP s)
{
  unused(type, x_robj, s);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_rev_rows(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_rev_cols(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_get(SEXP type, SEXP x_robj, SEXP i, SEXP j)
{
  unused(type, x_robj, i, j);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_set(SEXP type, SEXP x_robj, SEXP i, SEXP j, SEXP v)
{
  unused(type, x_robj, i, j, v);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_get_row(SEXP type, SEXP x_robj, SEXP i, SEXP v_robj)
{
  unused(type, x_robj, i, v_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_get_col(SEXP type, SEXP x_robj, SEXP j, SEXP v_robj)
{
  unused(type, x_robj, j, v_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_to_robj(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_from_robj(SEXP type, SEXP x_robj, SEXP robj)
{
  unused(type, x_robj, robj);
  WARN_AND_RETURN("MPI");
}



// -----------------------------------------------------------------------------
// mpihelpers namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_mpimat_cpu2mpi(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  unused(type_in, type_out, in_robj, out_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_mpi2cpu(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj, SEXP rdest, SEXP cdest)
{
  unused(type_in, type_out, in_robj, out_robj, rdest, cdest);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_mpi2mpi(SEXP type_in, SEXP type_out, SEXP in_robj, SEXP out_robj)
{
  unused(type_in, type_out, in_robj, out_robj);
  WARN_AND_RETURN("MPI");
}



// -----------------------------------------------------------------------------
// linalg namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_mpimat_linalg_add(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP beta, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  unused(type, transx, transy, alpha, beta, x_robj, y_robj, ret_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_matmult(SEXP type, SEXP transx, SEXP transy, SEXP alpha, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  unused(type, transx, transy, alpha, x_robj, y_robj, ret_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_crossprod(SEXP type, SEXP xpose, SEXP alpha, SEXP x_robj, SEXP ret_robj)
{
  unused(type, xpose, alpha, x_robj, ret_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_xpose(SEXP type, SEXP x_robj, SEXP ret_robj)
{
  unused(type, x_robj, ret_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_lu(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_det(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_dot(SEXP type, SEXP x_robj, SEXP y_robj)
{
  unused(type, x_robj, y_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_trace(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_svd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  unused(type, x_robj, s_robj, u_robj, vt_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_eigen_sym(SEXP type, SEXP x_robj, SEXP values_robj, SEXP vectors_robj)
{
  unused(type, x_robj, values_robj, vectors_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_invert(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_solve(SEXP type, SEXP x_robj, SEXP y_class, SEXP y_robj)
{
  unused(type, x_robj, y_class, y_robj);
  WARN_AND_RETURN("MPI");
}


extern "C" SEXP R_mpimat_linalg_qr(SEXP type, SEXP x_robj, SEXP qraux_robj)
{
  unused(type, x_robj, qraux_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_qr_Q(SEXP type, SEXP QR_robj, SEXP qraux_robj, SEXP Q_robj, SEXP work_robj)
{
  unused(type, QR_robj, qraux_robj, Q_robj, work_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_qr_R(SEXP type, SEXP QR_robj, SEXP R_robj)
{
  unused(type, QR_robj, R_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_lq(SEXP type, SEXP x_robj, SEXP lqaux_robj)
{
  unused(type, x_robj, lqaux_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_lq_L(SEXP type, SEXP LQ_robj, SEXP L_robj)
{
  unused(type, LQ_robj, L_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_lq_Q(SEXP type, SEXP LQ_robj, SEXP lqaux_robj, SEXP Q_robj, SEXP work_robj)
{
  unused(type, LQ_robj, lqaux_robj, Q_robj, work_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_qrsvd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  unused(type, x_robj, s_robj, u_robj, vt_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_cpsvd(SEXP type, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  unused(type, x_robj, s_robj, u_robj, vt_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_chol(SEXP type, SEXP x_robj)
{
  unused(type, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_norm(SEXP type, SEXP x_robj, SEXP norm)
{
  unused(type, x_robj, norm);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_cond(SEXP type, SEXP x_robj, SEXP norm)
{
  unused(type, x_robj, norm);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_trinv(SEXP type, SEXP upper, SEXP unit_diag, SEXP x_robj)
{
  unused(type, upper, unit_diag, x_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_linalg_rsvd(SEXP type, SEXP seed, SEXP k, SEXP q, SEXP x_robj, SEXP s_robj, SEXP u_robj, SEXP vt_robj)
{
  unused(type, seed, k, q, x_robj, s_robj, u_robj, vt_robj);
  WARN_AND_RETURN("MPI");
}



// -----------------------------------------------------------------------------
// dimops namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_mpimat_dimops_matsums(SEXP type, SEXP row, SEXP mean, SEXP x_robj, SEXP s_robj)
{
  unused(type, row, mean, x_robj, s_robj);
  WARN_AND_RETURN("MPI");
}

extern "C" SEXP R_mpimat_dimops_scale(SEXP type, SEXP rm_mean, SEXP rm_sd, SEXP x_robj)
{
  unused(type, rm_mean, rm_sd, x_robj);
  WARN_AND_RETURN("MPI");
}



// -----------------------------------------------------------------------------
// stats namespace
// -----------------------------------------------------------------------------

extern "C" SEXP R_mpimat_stats_pca(SEXP type, SEXP rm_mean_, SEXP rm_sd_, SEXP x_robj, SEXP sdev_robj, SEXP rot_robj)
{
  unused(type, rm_mean_, rm_sd_, x_robj, sdev_robj, rot_robj);
  WARN_AND_RETURN("MPI");
}
