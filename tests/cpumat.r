suppressMessages(library(fmlr))

cmp = function(x, y) stopifnot(all.equal(x, y))

m = 2
n = 3
x = cpumat(m, n)

cmp(x$dim(), c(m, n))



# ------------------------------------------------------------------------------
# fill
# ------------------------------------------------------------------------------

x$fill_one()
test = x$to_robj()
truth = matrix(1, m, n)
cmp(test, truth)

x$fill_eye()
test = x$to_robj()
truth = diag(1, m, n)
cmp(test, truth)

x$fill_zero()
test = x$to_robj()
truth = matrix(0, m, n)
cmp(test, truth)

x$fill_val(3)
test = x$to_robj()
truth = matrix(3, m, n)
cmp(test, truth)

x$fill_linspace(1, m*n)
test = x$to_robj()
truth = matrix(1:(m*n), m, n)
cmp(test, truth)



# ------------------------------------------------------------------------------
# misc
# ------------------------------------------------------------------------------

x$fill_linspace(1, m*n)
x$rev_rows()
test = x$to_robj()
truth = matrix(1:(m*n), m, n)[m:1, ]
cmp(test, truth)

x$rev_cols()
test = x$to_robj()
truth = matrix(1:(m*n), m, n)[m:1, n:1]
cmp(test, truth)

x$fill_linspace(1, 6)
x$scale(1000)
test = x$to_robj()
truth = matrix(1:(m*n) * 1000, m, n)
cmp(test, truth)
