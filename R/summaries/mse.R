# calculate mean squared error
summary_mse = function(dataset, analysis){
  truth = dataset@supplement$truth$beta
  est = estimates(analysis)
  est = est[grep("beta", rownames(est)),]
  est = matrix(est$mean, ncol = ncol(dataset@design))
  apply(est-truth, 2, function(x){mean(x^2)})
}
