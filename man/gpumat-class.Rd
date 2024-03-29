% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gpumat.r
\name{gpumat-class}
\alias{gpumat-class}
\alias{gpumatR6}
\title{gpumat class}
\description{
Storage and methods for GPU matrix data.
}
\details{
Data is held in an external pointer.
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{gpumatR6$new()}}
\item \href{#method-resize}{\code{gpumatR6$resize()}}
\item \href{#method-info}{\code{gpumatR6$info()}}
\item \href{#method-dupe}{\code{gpumatR6$dupe()}}
\item \href{#method-print}{\code{gpumatR6$print()}}
\item \href{#method-fill_zero}{\code{gpumatR6$fill_zero()}}
\item \href{#method-fill_val}{\code{gpumatR6$fill_val()}}
\item \href{#method-fill_linspace}{\code{gpumatR6$fill_linspace()}}
\item \href{#method-fill_eye}{\code{gpumatR6$fill_eye()}}
\item \href{#method-fill_diag}{\code{gpumatR6$fill_diag()}}
\item \href{#method-fill_runif}{\code{gpumatR6$fill_runif()}}
\item \href{#method-fill_rnorm}{\code{gpumatR6$fill_rnorm()}}
\item \href{#method-diag}{\code{gpumatR6$diag()}}
\item \href{#method-antidiag}{\code{gpumatR6$antidiag()}}
\item \href{#method-scale}{\code{gpumatR6$scale()}}
\item \href{#method-rev_rows}{\code{gpumatR6$rev_rows()}}
\item \href{#method-rev_cols}{\code{gpumatR6$rev_cols()}}
\item \href{#method-get}{\code{gpumatR6$get()}}
\item \href{#method-set}{\code{gpumatR6$set()}}
\item \href{#method-get_row}{\code{gpumatR6$get_row()}}
\item \href{#method-get_col}{\code{gpumatR6$get_col()}}
\item \href{#method-dim}{\code{gpumatR6$dim()}}
\item \href{#method-nrows}{\code{gpumatR6$nrows()}}
\item \href{#method-ncols}{\code{gpumatR6$ncols()}}
\item \href{#method-get_card}{\code{gpumatR6$get_card()}}
\item \href{#method-data_ptr}{\code{gpumatR6$data_ptr()}}
\item \href{#method-get_type}{\code{gpumatR6$get_type()}}
\item \href{#method-get_type_str}{\code{gpumatR6$get_type_str()}}
\item \href{#method-get_class}{\code{gpumatR6$get_class()}}
\item \href{#method-to_robj}{\code{gpumatR6$to_robj()}}
\item \href{#method-from_robj}{\code{gpumatR6$from_robj()}}
\item \href{#method-clone}{\code{gpumatR6$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$new(card, nrows = 0, ncols = 0, type = "double")}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{card}}{A GPU card object; the return of \code{card()}. See \code{?card}.}

\item{\code{nrows, ncols}}{The dimension of the matrix.}

\item{\code{type}}{Storage type for the matrix. Should be one of 'int', 'float', or 'double'.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Class initializer. See also \code{?gpumat}.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-resize"></a>}}
\if{latex}{\out{\hypertarget{method-resize}{}}}
\subsection{Method \code{resize()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$resize(nrows, ncols)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{nrows, ncols}}{The new dimension.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Change the dimension of the matrix object.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-info"></a>}}
\if{latex}{\out{\hypertarget{method-info}{}}}
\subsection{Method \code{info()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$info()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Print one-line information about the matrix.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dupe"></a>}}
\if{latex}{\out{\hypertarget{method-dupe}{}}}
\subsection{Method \code{dupe()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$dupe()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Duplicate the matrix in a deep copy.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-print"></a>}}
\if{latex}{\out{\hypertarget{method-print}{}}}
\subsection{Method \code{print()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$print(ndigits = 4)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{ndigits}}{Number of decimal digits to print.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Print the data.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fill_zero"></a>}}
\if{latex}{\out{\hypertarget{method-fill_zero}{}}}
\subsection{Method \code{fill_zero()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$fill_zero()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Fill all entries with zero.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fill_val"></a>}}
\if{latex}{\out{\hypertarget{method-fill_val}{}}}
\subsection{Method \code{fill_val()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$fill_val(v)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{v}}{Value to set all entries to.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Fill all entries with supplied value.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fill_linspace"></a>}}
\if{latex}{\out{\hypertarget{method-fill_linspace}{}}}
\subsection{Method \code{fill_linspace()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$fill_linspace(start, stop)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{start, stop}}{Beginning/end of the linear spacing.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Fill the matrix (column-wise) with linearly-spaced values.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fill_eye"></a>}}
\if{latex}{\out{\hypertarget{method-fill_eye}{}}}
\subsection{Method \code{fill_eye()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$fill_eye()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Fill diagonal values to 1 and non-diagonal values to 0.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fill_diag"></a>}}
\if{latex}{\out{\hypertarget{method-fill_diag}{}}}
\subsection{Method \code{fill_diag()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$fill_diag(v)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{v}}{A gpuvec object.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Set diagonal entries of the matrix to those in the vector. If the vector
is smaller than the matrix diagonal, the vector will recycle until the
matrix diagonal is filled.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fill_runif"></a>}}
\if{latex}{\out{\hypertarget{method-fill_runif}{}}}
\subsection{Method \code{fill_runif()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$fill_runif(seed, min = 0, max = 1)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{seed}}{Seed for the generator. Can be left blank.}

\item{\code{min, max}}{Parameters for the generator.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Fill the matrix with random unifmorm data.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fill_rnorm"></a>}}
\if{latex}{\out{\hypertarget{method-fill_rnorm}{}}}
\subsection{Method \code{fill_rnorm()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$fill_rnorm(seed, mean = 0, sd = 1)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{seed}}{Seed for the generator. Can be left blank.}

\item{\code{mean, sd}}{Parameters for the generator.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Fill the matrix with random normal data.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-diag"></a>}}
\if{latex}{\out{\hypertarget{method-diag}{}}}
\subsection{Method \code{diag()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$diag(v)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{v}}{A gpuvec object.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Get diagonal entries of the matrix.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-antidiag"></a>}}
\if{latex}{\out{\hypertarget{method-antidiag}{}}}
\subsection{Method \code{antidiag()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$antidiag(v)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{v}}{A gpuvec object.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Get anti-diagonal entries of the matrix.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-scale"></a>}}
\if{latex}{\out{\hypertarget{method-scale}{}}}
\subsection{Method \code{scale()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$scale(s)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{s}}{Value to scale all entries by.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Scale all entries by the supplied value.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-rev_rows"></a>}}
\if{latex}{\out{\hypertarget{method-rev_rows}{}}}
\subsection{Method \code{rev_rows()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$rev_rows()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Reverse rows.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-rev_cols"></a>}}
\if{latex}{\out{\hypertarget{method-rev_cols}{}}}
\subsection{Method \code{rev_cols()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$rev_cols()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Reverse columns.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get"></a>}}
\if{latex}{\out{\hypertarget{method-get}{}}}
\subsection{Method \code{get()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$get(i, j)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{i, j}}{Indices (0-based).}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Get element from the matrix.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-set"></a>}}
\if{latex}{\out{\hypertarget{method-set}{}}}
\subsection{Method \code{set()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$set(i, j, v)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{i, j}}{Indices (0-based).}

\item{\code{v}}{Value.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Set element of the matrix.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_row"></a>}}
\if{latex}{\out{\hypertarget{method-get_row}{}}}
\subsection{Method \code{get_row()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$get_row(i, v)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{i}}{Index (0-based).}

\item{\code{v}}{A gpuvec object.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Get the specified row.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_col"></a>}}
\if{latex}{\out{\hypertarget{method-get_col}{}}}
\subsection{Method \code{get_col()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$get_col(j, v)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{j}}{Index (0-based).}

\item{\code{v}}{A gpuvec object.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Get the specified column.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dim"></a>}}
\if{latex}{\out{\hypertarget{method-dim}{}}}
\subsection{Method \code{dim()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$dim()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns number of rows and columns of the matrix.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-nrows"></a>}}
\if{latex}{\out{\hypertarget{method-nrows}{}}}
\subsection{Method \code{nrows()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$nrows()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns number of rows of the matrix.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ncols"></a>}}
\if{latex}{\out{\hypertarget{method-ncols}{}}}
\subsection{Method \code{ncols()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$ncols()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns number of columns of the matrix.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_card"></a>}}
\if{latex}{\out{\hypertarget{method-get_card}{}}}
\subsection{Method \code{get_card()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$get_card()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns the internal card object.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-data_ptr"></a>}}
\if{latex}{\out{\hypertarget{method-data_ptr}{}}}
\subsection{Method \code{data_ptr()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$data_ptr()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns the external pointer data. For developers only.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_type"></a>}}
\if{latex}{\out{\hypertarget{method-get_type}{}}}
\subsection{Method \code{get_type()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$get_type()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns the integer code for the underlying storage type. For developers only.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_type_str"></a>}}
\if{latex}{\out{\hypertarget{method-get_type_str}{}}}
\subsection{Method \code{get_type_str()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$get_type_str()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns the string code for the underlying storage type. For developers only.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_class"></a>}}
\if{latex}{\out{\hypertarget{method-get_class}{}}}
\subsection{Method \code{get_class()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$get_class()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns the integer code the class type, in this case CLASS_MAT.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-to_robj"></a>}}
\if{latex}{\out{\hypertarget{method-to_robj}{}}}
\subsection{Method \code{to_robj()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$to_robj()}\if{html}{\out{</div>}}
}

\subsection{Details}{
Returns an R matrix containing a copy of the class data.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-from_robj"></a>}}
\if{latex}{\out{\hypertarget{method-from_robj}{}}}
\subsection{Method \code{from_robj()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$from_robj(robj)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{robj}}{R matrix.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
Copies the values of the input to the class data. See also \code{?as_gpumat}.
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{gpumatR6$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
