# library(fbseq); source("../utils/globals.R")

# h_n constants set to zero
zero = function(s){
  con = Configs(iterations = globals("iterations"), 
    burnin = globals("burnin"), 
    thin = globals("thin"))
  ch = Chain(s, con)
  ch@h = rep(0, length(ch@h))
  fbseq(ch, backend = globals("backend"))
}
