is_card = function(x) inherits(x, "card")

is_cpumat = function(x) inherits(x, "cpumat")
is_cpuvec = function(x) inherits(x, "cpuvec")

is_gpuvec = function(x) inherits(x, "gpuvec")
is_gpumat = function(x) inherits(x, "gpumat")

is_grid = function(x) inherits(x, "grid")

is_mpimat = function(x) inherits(x, "mpimat")

fmlr_is_funs = c(is_cpumat, is_cpuvec, is_gpuvec, is_gpumat)
