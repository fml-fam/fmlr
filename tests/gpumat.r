suppressMessages(library(fmlr))

if (fml_gpu()){
  m = 2
  n = 3
  c = card()
  x = gpumat(c, m, n)
  
  source("internals/common.r")
  source("internals/mat.r")
}
