test = dimops_rowsums(x)$to_robj()
truth = rowSums(xr)
cmp(test, truth)

test = dimops_rowmeans(x)$to_robj()
truth = rowMeans(xr)
cmp(test, truth)

test = dimops_colsums(x)$to_robj()
truth = colSums(xr)
cmp(test, truth)

test = dimops_colmeans(x)$to_robj()
truth = colMeans(xr)
cmp(test, truth)
