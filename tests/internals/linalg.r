# crossprod
test = linalg_crossprod(x)$to_robj()
truth = crossprod(r)
cmp(test[lower.tri(test, diag=TRUE)], truth[lower.tri(truth, diag=TRUE)])
