% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.r
\name{mpi2cpu}
\alias{mpi2cpu}
\title{mpi2cpu}
\usage{
mpi2cpu(mpi_in, cpu_out, rdest = 0, cdest = 0)
}
\arguments{
\item{mpi_in}{Input.}

\item{cpu_out}{Ouput.}

\item{rdest, cdest}{The row/column index of the receiving process.}
}
\value{
Returns \code{NULL}.
}
\description{
Copy the data in an MPI matrix to a CPU matrix. They can be of different
fundamental types (e.g. float/double).
}
