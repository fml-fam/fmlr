suppressMessages(library(fmlr))

if (fml_gpu()){
  size = 5
  c = card()
  x = gpuvec(c, size)
  
  source("internals/common.r")
  source("internals/vec.r")
}
