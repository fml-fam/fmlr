#ifndef FMLR_APPLY_H
#define FMLR_APPLY_H
#pragma once


#include <cstdarg>

#include "rutils.h"
#include "types.h"


// -----------------------------------------------------------------------------
// apply templated functions/methods
// -----------------------------------------------------------------------------

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
