# add
test = linalg_add(x=x, y=y)$to_robj()
truth = xr + yr
cmp(test[lower.tri(test, diag=TRUE)], truth[lower.tri(truth, diag=TRUE)])

test = linalg_add(transx=TRUE, transy=TRUE, x=x, y=y)$to_robj()
truth = t(xr) + t(yr)
cmp(test[lower.tri(test, diag=TRUE)], truth[lower.tri(truth, diag=TRUE)])



# crossprod
test = linalg_crossprod(x)$to_robj()
truth = crossprod(xr)
cmp(test[lower.tri(test, diag=TRUE)], truth[lower.tri(truth, diag=TRUE)])
