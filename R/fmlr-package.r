#' fmlr
#' 
#' 'fmlr' is an R interface to the 'fml' library. It is a
#' "medium-level" interface for multiple dense matrix types, principally CPU,
#' GPU, and MPI. Each supports multiple fundamental types (int, float, double),
#' and data is held externally to R and operations that modify data generally
#' occur in-place. The interface largely tracks with the core 'fml' interface.
#' The interface is written such that generally an 'fmlr' R code can be easily
#' translated to an 'fml' C++ code.
#' 
#' @importFrom float is.float
#' @importFrom R6 R6Class
#' 
#' @name fmlr-package
#' @docType package
#' @author Drew Schmidt \email{wrathematics AT gmail.com}
#' @keywords Package
NULL
