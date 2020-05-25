#include "apply.hpp"
#include "extptr.h"
#include "types.h"

#include <fml/src/mpi/mpimat.hh>
#include <fml/src/mpi/stats.hh>


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
