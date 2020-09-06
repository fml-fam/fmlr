#ifndef FMLR_RUTILS_H
#define FMLR_RUTILS_H
#pragma once


#include <Rinternals.h>

#define FLOAT(x) ((float*)DATAPTR(x))

#define LGL(x) (LOGICAL(x)[0])
#define INT(x) (INTEGER(x)[0])
#define DBL(x) (REAL(x)[0])
#define CHR(x) ((char*)CHAR(STRING_ELT(x,0)))[0]

#define LGLP(x) (LOGICAL(x))
#define INTP(x) (INTEGER(x))
#define DBLP(x) (REAL(x))
#define STRP(x) ((char*)CHAR(STRING_ELT(x,0)))


#define TRY_CATCH(expr) try { expr; } catch(const std::exception& e) { error(e.what()); }


#endif
