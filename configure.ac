AC_PREREQ([2.69])
AC_INIT(DESCRIPTION)
AC_CONFIG_MACRO_DIR([tools/])


# Determine R_HOME.
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi

R_SCMD="${R_HOME}/bin/Rscript -e"

# R flags
R_CPPFLAGS=`"${R_HOME}/bin/R" CMD config --cppflags`

FLOAT_LIBS=`${R_SCMD} "float:::ldflags()"`
FLOAT_INCL=`${R_SCMD} "float:::cppflags()"`

# MPI flags
SPMD_CPPFLAGS=`${R_SCMD} "source('./R/conf/get_conf.r');get.conf('PKG_CPPFLAGS','"${R_ARCH}"')"`
SPMD_LDFLAGS=`${R_SCMD} "source('./R/conf/get_conf.r');get.conf('PKG_LIBS','"${R_ARCH}"')"`

# ScaLAPACK flags
EXT_LDFLAGS=`${R_SCMD} "source('./R/conf/get_conf.r');get.conf('EXT_LDFLAGS','"${R_ARCH}"','pbdSLAP')"`
R_SLAP=`${R_SCMD} "source('./R/conf/get_lib.r');get.lib('R_SLAP','"${R_ARCH}"')"`
if test -f "$R_SLAP"; then
  SLAP_LDFLAGS="$R_SLAP \$(LAPACK_LIBS) \$(BLAS_LIBS)"
else
  SLAP_LDFLAGS="$EXT_LDFLAGS"
fi


# GPU flags
AC_ARG_ENABLE(gpu,
  AC_HELP_STRING(
    [--enable-gpu], 
    [Enable GPU bindings.]
  ),
  [USE_GPU="TRUE"],
  [USE_GPU="FALSE"]
)

if test "X${USE_GPU}" = "XTRUE"; then
  AC_MSG_NOTICE([using GPU])
  AX_CHECK_CUDA()
else
  AC_MSG_NOTICE([not using GPU])
fi



# wrapup
echo " "
echo "******************* Results of fmlr package configure *******************"
echo " "
echo "* R Report:"
echo "    >> R_CPPFLAGS=${R_CPPFLAGS}"
echo "    >> FLOAT_LIBS=${FLOAT_LIBS}"
echo "    >> FLOAT_INCL=${FLOAT_INCL}"
echo "* GPU Report:"
if test "X${USE_GPU}" = "XTRUE"; then
  echo "    >> NVCC=${NVCC}"
  echo "    >> CUDA_CFLAGS=${CUDA_CFLAGS}"
  echo "    >> CUDA_LDFLAGS=${CUDA_LDFLAGS}"
else
  echo "    >> not used"
fi
echo "* MPI report:"
echo "    >> SPMD_CPPFLAGS = ${SPMD_CPPFLAGS}"
echo "    >> SPMD_LDFLAGS = ${SPMD_LDFLAGS}"
echo "    >> SLAP_LDFLAGS = ${SLAP_LDFLAGS}"
echo "*************************************************************************"
echo " "



AC_SUBST(R_CPPFLAGS)
AC_SUBST(FLOAT_LIBS)
AC_SUBST(FLOAT_INCL)

AC_SUBST(SPMD_CPPFLAGS)
AC_SUBST(SPMD_LDFLAGS)
AC_SUBST(SLAP_LDFLAGS)

AC_SUBST(USE_GPU)
AC_SUBST(NVCC)
AC_SUBST(CUDA_CFLAGS)
AC_SUBST(CUDA_LDFLAGS)

AC_OUTPUT(src/Makevars)
