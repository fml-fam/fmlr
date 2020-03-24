#' fmlr
#' 
#' Interface to the fml library, which defines a single
#' "medium-level" interface for multiple dense matrix types (CPU, GPU, and
#' MPI), each supporting multiple fundamental types (half, float, double). Data
#' is held externally to R and operations that modify data generally occur
#' in-place. The fmlr interface largely tracks with the core fml interface.
#' We use R6 so that generally an R code can be easily translated to C++.
#' 
#' @import pbdMPI
#' @import pbdSLAP
#' @importFrom float fl
#' @importFrom R6 R6Class
#' 
#' @name fmlr-package
#' @docType package
#' @author Drew Schmidt \email{wrathematics AT gmail.com}
#' @keywords Package
NULL
