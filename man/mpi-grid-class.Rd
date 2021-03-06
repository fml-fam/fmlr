% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grid.r
\name{mpi-grid-class}
\alias{mpi-grid-class}
\alias{gridR6}
\title{grid class}
\description{
Storage and methods for MPI grid data.
}
\details{
Data is held in an external pointer.
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{gridR6$new()}}
\item \href{#method-set}{\code{gridR6$set()}}
\item \href{#method-exit}{\code{gridR6$exit()}}
\item \href{#method-finalize}{\code{gridR6$finalize()}}
\item \href{#method-info}{\code{gridR6$info()}}
\item \href{#method-print}{\code{gridR6$print()}}
\item \href{#method-rank0}{\code{gridR6$rank0()}}
\item \href{#method-ingrid}{\code{gridR6$ingrid()}}
\item \href{#method-barrier}{\code{gridR6$barrier()}}
\item \href{#method-ictxt}{\code{gridR6$ictxt()}}
\item \href{#method-nprocs}{\code{gridR6$nprocs()}}
\item \href{#method-nprow}{\code{gridR6$nprow()}}
\item \href{#method-npcol}{\code{gridR6$npcol()}}
\item \href{#method-myrow}{\code{gridR6$myrow()}}
\item \href{#method-mycol}{\code{gridR6$mycol()}}
\item \href{#method-valid_grid}{\code{gridR6$valid_grid()}}
\item \href{#method-data_ptr}{\code{gridR6$data_ptr()}}
\item \href{#method-clone}{\code{gridR6$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$new(gridtype = PROC_GRID_SQUARE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{gridtype}}{Type of processor grid: \code{PROC_GRID_SQUARE},
\code{PROC_GRID_WIDE}, or \code{PROC_GRID_TALL}.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Class initializer.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-set"></a>}}
\if{latex}{\out{\hypertarget{method-set}{}}}
\subsection{Method \code{set()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$set(blacs_context)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{blacs_context}}{The BLACS integer context number.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Set grid to another BLACS context.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-exit"></a>}}
\if{latex}{\out{\hypertarget{method-exit}{}}}
\subsection{Method \code{exit()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$exit()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Exits the BLACS grid, but does not shutdown BLACS/MPI.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-finalize"></a>}}
\if{latex}{\out{\hypertarget{method-finalize}{}}}
\subsection{Method \code{finalize()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$finalize(mpi_continue = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{mpi_continue}}{Should MPI continue, i.e., not be shut down too?}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Shuts down BLACS, and optionally MPI.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-info"></a>}}
\if{latex}{\out{\hypertarget{method-info}{}}}
\subsection{Method \code{info()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$info()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Print one-line information about the object.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-print"></a>}}
\if{latex}{\out{\hypertarget{method-print}{}}}
\subsection{Method \code{print()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$print()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Print one-line information about the object.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-rank0"></a>}}
\if{latex}{\out{\hypertarget{method-rank0}{}}}
\subsection{Method \code{rank0()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$rank0()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Is the calling process rank 0, i.e. row 0 and col 0?
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ingrid"></a>}}
\if{latex}{\out{\hypertarget{method-ingrid}{}}}
\subsection{Method \code{ingrid()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$ingrid()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Is the calling process in the grid, i.e. row and col not -1?
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-barrier"></a>}}
\if{latex}{\out{\hypertarget{method-barrier}{}}}
\subsection{Method \code{barrier()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$barrier(scope = "A")}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{scope}}{'A' for all, 'R' for row, or 'C' for column.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Execute a barrier.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ictxt"></a>}}
\if{latex}{\out{\hypertarget{method-ictxt}{}}}
\subsection{Method \code{ictxt()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$ictxt()}\if{html}{\out{</div>}}
}

\subsection{Details}{
The BLACS integer context.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-nprocs"></a>}}
\if{latex}{\out{\hypertarget{method-nprocs}{}}}
\subsection{Method \code{nprocs()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$nprocs()}\if{html}{\out{</div>}}
}

\subsection{Details}{
The BLACS integer context.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-nprow"></a>}}
\if{latex}{\out{\hypertarget{method-nprow}{}}}
\subsection{Method \code{nprow()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$nprow()}\if{html}{\out{</div>}}
}

\subsection{Details}{
The BLACS integer context.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-npcol"></a>}}
\if{latex}{\out{\hypertarget{method-npcol}{}}}
\subsection{Method \code{npcol()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$npcol()}\if{html}{\out{</div>}}
}

\subsection{Details}{
The BLACS integer context.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-myrow"></a>}}
\if{latex}{\out{\hypertarget{method-myrow}{}}}
\subsection{Method \code{myrow()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$myrow()}\if{html}{\out{</div>}}
}

\subsection{Details}{
The BLACS integer context.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-mycol"></a>}}
\if{latex}{\out{\hypertarget{method-mycol}{}}}
\subsection{Method \code{mycol()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$mycol()}\if{html}{\out{</div>}}
}

\subsection{Details}{
The BLACS integer context.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-valid_grid"></a>}}
\if{latex}{\out{\hypertarget{method-valid_grid}{}}}
\subsection{Method \code{valid_grid()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$valid_grid()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns whether or not the grid object is valid.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-data_ptr"></a>}}
\if{latex}{\out{\hypertarget{method-data_ptr}{}}}
\subsection{Method \code{data_ptr()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$data_ptr()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns the external pointer data. For developers only.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gridR6$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
