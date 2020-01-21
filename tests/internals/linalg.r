# add
test = linalg_add(x=x, y=y)$to_robj()
truth = xr + yr
cmp(test, truth)

test = linalg_add(transx=TRUE, transy=TRUE, x=x, y=y)$to_robj()
truth = t(xr) + t(yr)
cmp(test, truth)



# matmult
test = linalg_matmult(transx=FALSE, transy=TRUE, x=x, y=y)$to_robj()
truth = xr %*% t(yr)
cmp(test, truth)

test = linalg_matmult(transx=TRUE, transy=FALSE, x=x, y=y)$to_robj()
truth = t(xr) %*% yr
cmp(test, truth)



# crossprod
test = linalg_crossprod(x)$to_robj()
truth = crossprod(xr)
cmp(test[lower.tri(test, diag=TRUE)], truth[lower.tri(truth, diag=TRUE)])



# xpose
test = linalg_xpose(x)$to_robj()
truth = t(xr)
cmp(test, truth)
