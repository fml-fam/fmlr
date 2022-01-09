# -----------------------------------------------------------------------------
# type globals
# -----------------------------------------------------------------------------

# class globals
CLASS_MAT = 1L
CLASS_VEC = 2L

# backend globals
BACKEND_CPU = 1L
BACKEND_GPU = 2L
BACKEND_MPI = 3L

get_backend = function(x)
{
  if (is_cpu(x))
    BACKEND_CPU
  else if (is_gpu(x))
    BACKEND_GPU
  else if (is_mpi(x))
    BACKEND_MPI
  else
    stop("bad backend")
}

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

type_robj2int = function(robj)
{
  if (is.double(robj))
    TYPE_DOUBLE
  else if (float::is.float(robj))
    TYPE_FLOAT
  else if (is.integer(robj))
    TYPE_INT
  else
    stop("bad fundamental type")
}

type_robj2str = function(robj) type_int2str(type_robj2int(robj))



# grid globals
PROC_GRID_SQUARE = 0L
PROC_GRID_WIDE = 1L
PROC_GRID_TALL = 2L

# op globals
SWEEP_ADD = 0L
SWEEP_SUB = 1L
SWEEP_MUL = 2L
SWEEP_DIV = 3L
