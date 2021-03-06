#ifndef FMLR_APPLY_H
#define FMLR_APPLY_H
#pragma once


#include <cstdarg>

#include "rutils.h"
#include "types.h"


// -----------------------------------------------------------------------------
// apply templated functions/methods
// -----------------------------------------------------------------------------

#define APPLY_TEMPLATED_METHOD_0(MAT, data_type, x_robj, FUN) \
  if (INT(data_type) == TYPE_DOUBLE){ \
    MAT<double> *x = (MAT<double>*) getRptr(x_robj); \
    TRY_CATCH( x->FUN() ) \
  } else if (INT(data_type) == TYPE_FLOAT){ \
    MAT<float> *x = (MAT<float>*) getRptr(x_robj); \
    TRY_CATCH( x->FUN() ) \
  } else if (INT(data_type) == TYPE_INT){ \
    MAT<int> *x = (MAT<int>*) getRptr(x_robj); \
    TRY_CATCH( x->FUN() ) \
  }

#define APPLY_TEMPLATED_METHOD(MAT, data_type, x_robj, FUN, ...) \
  if (INT(data_type) == TYPE_DOUBLE){ \
    MAT<double> *x = (MAT<double>*) getRptr(x_robj); \
    TRY_CATCH( x->FUN(__VA_ARGS__) ) \
  } else if (INT(data_type) == TYPE_FLOAT){ \
    MAT<float> *x = (MAT<float>*) getRptr(x_robj); \
    TRY_CATCH( x->FUN(__VA_ARGS__) ) \
  } else if (INT(data_type) == TYPE_INT){ \
    MAT<int> *x = (MAT<int>*) getRptr(x_robj); \
    TRY_CATCH( x->FUN(__VA_ARGS__) ) \
  }



#define CAST_MAT(MAT, REAL, x_cast, x) MAT<REAL>* x_cast = (MAT<REAL>*) x
#define CAST_FML(MAT, REAL, x, x_robj) MAT<REAL>* x = (MAT<REAL>*) getRptr(x_robj)

#define APPLY_TEMPLATED_FUNCTION(data_type, FUN, ...) \
  if (INT(data_type) == TYPE_DOUBLE){ \
    TRY_CATCH( FUN<double>(__VA_ARGS__) ) \
  } else if (INT(data_type) == TYPE_FLOAT){ \
    TRY_CATCH( FUN<float>(__VA_ARGS__) ) \
  } else { \
    error(TYPE_ERR); \
  }


#define APPLY_TEMPLATED_MACRO(MACRO, type_robj) \
  if (INT(type_robj) == TYPE_DOUBLE) \
    TRY_CATCH( MACRO(double) ) \
  else if (INT(type_robj) == TYPE_FLOAT) \
    TRY_CATCH( MACRO(float) ) \
  else \
    error(TYPE_ERR);



#endif
