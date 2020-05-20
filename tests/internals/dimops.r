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



s = x$dupe()
dimops_scale(x=s)
test = s$to_robj()
truth = scale(xr, center=TRUE, scale=TRUE)
attr(truth, "scaled:center") = NULL
attr(truth, "scaled:scale") = NULL
cmp(test, truth)
