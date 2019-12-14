library(memuse)
suppressMessages(library(fmlr))
set.seed(1234)

m = 100000
n = 250
howbig(m, n)
r = matrix(rnorm(m*n), m, n)

x_cpu = cpumat()
x_cpu$from_robj(r)

system.time({
  cp <- crossprod(r)
})

system.time({
  cp_gpu <- linalg_crossprod(x_cpu)
})



if (fml_gpu()){
  c = card()
  x_gpu = gpumat(c)
  x_gpu$from_robj(r)
  
  system.time({
    cp_gpu <- linalg_crossprod(x_gpu)
  })
}
