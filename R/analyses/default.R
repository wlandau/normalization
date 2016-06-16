# library(fbseq); source("../../config.R"); source("../utils/globals.R")

# h_n constants set in the default way using log-scale column means
default = function(s){
  con = Configs(iterations = globals("iterations"), 
    burnin = globals("burnin"), 
    thin = globals("thin"))
  ch = Chain(s, con)
  fbseq(ch, backend = globals("backend"))
}
