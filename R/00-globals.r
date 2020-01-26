# -----------------------------------------------------------------------------
# type globals
# -----------------------------------------------------------------------------

# class globals
CLASS_MAT = 1L
CLASS_VEC = 2L



# type globals
TYPE_DOUBLE = 1L
TYPE_FLOAT = 2L
TYPE_INT = 3L

TYPES_STR_NUMERIC = c("double", "float")
TYPES_STR_INTEGER = "int"
TYPES_STR = c(TYPES_STR_NUMERIC, TYPES_STR_INTEGER)

TYPES_INT = 1:length(TYPES_STR)
names(TYPES_INT) = TYPES_STR

type_int2str = function(type) TYPES_STR[type]
type_str2int = function(type) TYPES_INT[[type]]



# grid globals
PROC_GRID_SQUARE = 0L
PROC_GRID_WIDE = 1L
PROC_GRID_TALL = 2L
