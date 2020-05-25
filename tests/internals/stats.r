stats_pca(TRUE, TRUE, x, s)
test = s$to_robj()
truth = prcomp(xr, scale.=TRUE, retx=FALSE)$sdev
cmp(test, truth)
