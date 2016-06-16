globals = function(arg){
  if(scaling() == "down") {
    x = list(backend = "OpenMP",
      burnin = 30,
      genes = 30,
      iterations = 30,
      thin = 1)
  } else if(scaling() == "up"){
    x = list(backend = "CUDA",
      burnin = 1e5,
      genes = 3e4,
      iterations = 5000,
      thin = 20)
  } else {
    stop(paste0("illegal workflow scaling option, \"", scaling(), "\"."))
  }
  stopifnot(arg %in% names(x))
  x[[arg]]
}
