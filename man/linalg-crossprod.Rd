% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linalg.r
\name{crossprod}
\alias{crossprod}
\alias{linalg_crossprod}
\alias{linalg_tcrossprod}
\title{crossprod}
\usage{
linalg_crossprod(x, ret = NULL, alpha = 1)

linalg_tcrossprod(x, ret = NULL, alpha = 1)
}
\arguments{
\item{x}{Input data.}

\item{ret}{Either \code{NULL} or an already allocated fml matrix of the same
class and type as \code{x}.}

\item{alpha}{Number to scale the crossproduct by.}
}
\value{
Returns the crossproduct.
}
\description{
Compute crossproducts.
}