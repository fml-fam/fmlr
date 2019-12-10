suppressMessages(library(fmlr))

cmp = function(x, y) stopifnot(all.equal(x, y))

size = 5
x = cpuvec(size)

cmp(x$size(), size)



# ------------------------------------------------------------------------------
# fill
# ------------------------------------------------------------------------------

x$fill_val(1)
test = x$to_robj()
truth = rep(1, size)
cmp(test, truth)

x$fill_zero()
test = x$to_robj()
truth = rep(0, size)
cmp(test, truth)

x$fill_val(3)
test = x$to_robj()
truth = rep(3, size)
cmp(test, truth)

x$fill_linspace(1, size)
test = x$to_robj()
truth = 1:size
cmp(test, truth)



# ------------------------------------------------------------------------------
# misc
# ------------------------------------------------------------------------------

x$fill_linspace(1, size)
x$rev()
test = x$to_robj()
truth = size:1
cmp(test, truth)

x$fill_linspace(1, size)
x$scale(1000)
test = x$to_robj()
truth = 1:size * 1000
cmp(test, truth)
