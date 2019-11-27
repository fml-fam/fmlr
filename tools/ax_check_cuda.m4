##### 
#
# SYNOPSIS
#
# AX_CHECK_CUDA
#
# DESCRIPTION
#
# Figures out if CUDA Driver API/nvcc is available, i.e. existence of:
# 	cuda.h
#   libcuda.so
#   nvcc
#
# If something isn't found, fails straight away.
#
# Locations of these are included in 
#   CUDA_CFLAGS and 
#   CUDA_LDFLAGS.
# Path to nvcc is included as
#   NVCC
# in config.h
# 
# The author is personally using CUDA such that the .cu code is generated
# at runtime, so don't expect any automake magic to exist for compile time
# compilation of .cu files.
#
# LICENCE
# Public domain
#
# AUTHOR
# wili
#
##### 
# Modified 10/16/2018 to also check /usr/bin for nvcc - Drew Schmidt

AC_DEFUN([AX_CHECK_CUDA], [

# Provide your CUDA path with this		
AC_ARG_WITH(cuda, [  --with-cuda=PREFIX      Prefix of your CUDA installation], [cuda_prefix=$withval], [cuda_prefix="/usr/local/cuda"])

# Setting the prefix to the default if only --with-cuda was given
if test "$cuda_prefix" == "yes"; then
	if test "$withval" == "yes"; then
		cuda_prefix="/usr/local/cuda"
	fi
fi

# Announcing the new variables
AC_SUBST([CUDA_CFLAGS])
AC_SUBST([CUDA_LDFLAGS])
AC_SUBST([NVCC])

# Saving the current flags
ax_save_CFLAGS="${CFLAGS}"
ax_save_LDFLAGS="${LDFLAGS}"

# Checking for nvcc
AC_MSG_CHECKING([nvcc path])
if test -x "$cuda_prefix/bin/nvcc"; then
	AC_MSG_RESULT([found in $cuda_prefix/bin])
	NVCC="${cuda_prefix}/bin/nvcc"
	CUDA_CFLAGS="-I$cuda_prefix/include"
	CUDA_LDFLAGS="-L$cuda_prefix/lib64"
elif test -x "/usr/bin/nvcc"; then
	AC_MSG_RESULT([found in /usr/bin])
	NVCC="/usr/bin/nvcc"
	CUDA_CFLAGS=""
	CUDA_LDFLAGS=""
else
	AC_MSG_RESULT([not found!])
	AC_MSG_FAILURE([nvcc was not found in $cuda_prefix/bin or /usr/bin])
fi


CFLAGS="$CUDA_CFLAGS $CFLAGS"
LDFLAGS="$CUDA_LDFLAGS $LDFLAGS"

# And the header and the lib
AC_CHECK_HEADER([cuda.h], [], AC_MSG_FAILURE([Couldn't find cuda.h]), [#include <cuda.h>])
AC_CHECK_LIB([cudart], [cudaMalloc], [], AC_MSG_FAILURE([Couldn't find libcuda]))

# Returning to the original flags
CFLAGS=${ax_save_CFLAGS}
LDFLAGS=${ax_save_LDFLAGS}

])
