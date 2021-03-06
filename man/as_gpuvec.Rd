% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gpuvec.r
\name{as_gpuvec}
\alias{as_gpuvec}
\title{as_gpuvec}
\usage{
as_gpuvec(card, x)
}
\arguments{
\item{card}{A GPU card object; the return of \code{card()}. See \code{?card}.}

\item{x}{R vector.}
}
\value{
A gpuvec object.
}
\description{
Convert an R vector to a gpuvec object.
}
