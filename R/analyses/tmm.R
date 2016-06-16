# library(fbseq); source("../utils/globals.R")

# h_n constants set to zero
tmm = function(s){
  con = Configs(iterations = globals("iterations"), 
    burnin = globals("burnin"), 
    thin = globals("thin"))
  ch = Chain(s, con)
  dge = DGEList(counts = s@counts)
  dge = calcNormFactors(dge)
  ch@h = log(dge$samples$norm.factors)
  fbseq(ch, backend = globals("backend"))
}
