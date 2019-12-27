suppressMessages(library(fmlr))

if (fml_gpu()){

cmp = function(x, y) stopifnot(all.equal(x, y))

# initialize objects
m = 3
n = 2
g = grid()
x = mpimat(g, m, n)
x$fill_linspace(1, m*n)
r = x$to_robj()

# crossprod
test = linalg_crossprod(x)$to_robj()
truth = crossprod(r)
cmp(test[lower.tri(test, diag=TRUE)], truth[lower.tri(truth, diag=TRUE)])


} # end if (fml_gpu())
