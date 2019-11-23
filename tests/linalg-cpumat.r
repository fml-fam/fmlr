suppressMessages(library(fmlr))

cmp = function(x, y) stopifnot(all.equal(x, y))

m = 3
n = 2
x = cpumat(m, n)
x$fill_linspace(1, m*n)
r = x$to_robj()

test = linalg_crossprod(x)$to_robj()
truth = crossprod(r)
cmp(test[lower.tri(test, diag=TRUE)], truth[lower.tri(truth, diag=TRUE)])
