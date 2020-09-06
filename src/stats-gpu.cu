#include "apply.hpp"
#include "extptr.hpp"
#include "types.h"

#include <fml/gpu/gpumat.hh>
#include <fml/gpu/stats.hh>

using namespace fml;


extern "C" SEXP R_gpumat_stats_pca(SEXP type, SEXP rm_mean_, SEXP rm_sd_, SEXP x_robj, SEXP sdev_robj, SEXP rot_robj)
{
  #define FMLR_TMP_PCA(type) { \
    CAST_FML(gpumat, type, x, x_robj); \
    CAST_FML(gpuvec, type, sdev, sdev_robj); \
    if (rot_robj == R_NilValue) \
      stats::pca(rm_mean, rm_sd, *x, *sdev); \
    else { \
      CAST_FML(gpumat, type, rot, rot_robj); \
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
