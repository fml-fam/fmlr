# -----------------------------------------------------------------------------
# type globals
# -----------------------------------------------------------------------------

TYPES_STR_NUMERIC = c("double", "float")
TYPES_STR_INTEGER = "int"
TYPES_STR = c(TYPES_STR_NUMERIC, TYPES_STR_INTEGER)

TYPES_INT = 1:length(TYPES_STR)
names(TYPES_INT) = TYPES_STR

type_int2str = function(type) TYPES_STR[type]
type_str2int = function(type) TYPES_INT[[type]]
