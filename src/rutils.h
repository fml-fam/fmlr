#ifndef FMLR_RUTILS_H
#define FMLR_RUTILS_H
#pragma once


#include <Rinternals.h>


#define LGL(x) (LOGICAL(x)[0])
#define INT(x) (INTEGER(x)[0])
#define DBL(x) (REAL(x)[0])

#define LGLP(x) (LOGICAL(x))
#define INTP(x) (INTEGER(x))
#define DBLP(x) (REAL(x))

#define TRY_CATCH(expr) try { expr; } catch(const std::exception& e) { error(e.what()); }


#endif
