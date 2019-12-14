#ifndef FMLR_TYPES_H
#define FMLR_TYPES_H
#pragma once


// -----------------------------------------------------------------------------
// types mapping - must match R/00-globals.r
// -----------------------------------------------------------------------------

#define TYPE_DOUBLE 1
#define TYPE_FLOAT 2
#define TYPE_INT 3



// -----------------------------------------------------------------------------
// apply templated functions/methods
// -----------------------------------------------------------------------------

#include <cstdarg>

#define LGL(x) (LOGICAL(x)[0])
#define INT(x) (INTEGER(x)[0])
#define DBL(x) (REAL(x)[0])

#define APPLY_TEMPLATED_METHOD(MAT, data_type, x_robj, FUN, ...) \
  if (INT(data_type) == TYPE_DOUBLE){ \
    MAT<double> *x = (MAT<double>*) getRptr(x_robj); \
    x->FUN(__VA_ARGS__); \
  } else if (INT(data_type) == TYPE_FLOAT){ \
    MAT<float> *x = (MAT<float>*) getRptr(x_robj); \
    x->FUN(__VA_ARGS__); \
  } else if (INT(data_type) == TYPE_INT){ \
    MAT<int> *x = (MAT<int>*) getRptr(x_robj); \
    x->FUN(__VA_ARGS__); \
  }



#define CAST_MAT(MAT, REAL, x_cast, x) MAT<REAL>* x_cast = (MAT<REAL>*) x

#define APPLY_TEMPLATED_FUNCTION(data_type, FUN, ...) \
  if (INT(data_type) == TYPE_DOUBLE){ \
    FUN<double>(__VA_ARGS__); \
  } else if (INT(data_type) == TYPE_FLOAT){ \
    FUN<float>(__VA_ARGS__); \
  }


#endif
