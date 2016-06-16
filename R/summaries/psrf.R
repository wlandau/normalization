# Compute Gelman-Rubin potential scale reduction factors. 
# Only keep the important ones above 1.1.
#' @param obj list of fbseq::Chain objects
summary_psrf = function(obj){
  p = psrf(obj)
  p = p[is.finite(p)]
  p = p[p > 1.1]
  p = sort(p, decreasing = T)
  p = p[!grepl("epsilon", names(p))]
}
