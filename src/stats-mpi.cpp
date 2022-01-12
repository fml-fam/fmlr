#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/mpi/mpimat.hh>
#include <fml/mpi/stats.hh>

using namespace fml;


extern "C" SEXP R_mpimat_stats_pca(SEXP type, SEXP rm_mean_, SEXP rm_sd_, SEXP x_robj, SEXP sdev_robj, SEXP rot_robj)
{
  #define FMLR_TMP_PCA(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(cpuvec, type, sdev, sdev_robj); \
    if (rot_robj == R_NilValue) \
      stats::pca(rm_mean, rm_sd, *x, *sdev); \
    else { \
      CAST_FML(mpimat, type, rot, rot_robj); \
      stats::pca(rm_mean, rm_sd, *x, *sdev, *rot); \
    } }
  
  const bool rm_mean = LOGICAL(rm_mean_)[0];
  const bool rm_sd = LOGICAL(rm_sd_)[0];
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_PCA(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_PCA(float)
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_PCA
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_stats_cov(SEXP type, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  #define FMLR_TMP_COV(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(mpimat, type, ret, ret_robj); \
    if (y_robj == R_NilValue) \
      stats::cov(*x, *ret); \
    else { \
      CAST_FML(mpimat, type, y, y_robj); \
      stats::cov(*x, *y, *ret); \
    } }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_COV(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_COV(float)
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_COV
  
  return R_NilValue;
}



extern "C" SEXP R_mpimat_stats_cor(SEXP type, SEXP x_robj, SEXP y_robj, SEXP ret_robj)
{
  #define FMLR_TMP_COR(type) { \
    CAST_FML(mpimat, type, x, x_robj); \
    CAST_FML(mpimat, type, ret, ret_robj); \
    if (y_robj == R_NilValue) \
      stats::cor(*x, *ret); \
    else { \
      CAST_FML(mpimat, type, y, y_robj); \
      stats::cor(*x, *y, *ret); \
    } }
  
  if (INT(type) == TYPE_DOUBLE)
    FMLR_TMP_COR(double)
  else if (INT(type) == TYPE_FLOAT)
    FMLR_TMP_COR(float)
  else
    error(TYPE_ERR);
  
  #undef FMLR_TMP_COR
  
  return R_NilValue;
}
