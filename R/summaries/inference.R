new_colnames = function(x){
  x = gsub("parent_", "", x)
  x = gsub("B73xMo17_Mo17xB73|hybrids", "mean", x)
  x = gsub("B73xMo17|hybrid1", "H12", x)
  x = gsub("Mo17xB73|hybrid2", "H21", x)
  x
}

# calibration curve
calibration = function(probs, truth){
  index = order(probs)
  probs = probs[index]
  truth = as.numeric(truth[index])
  k = ksmooth(x = probs, y = truth, bandwidth = 0.1)
  fn = stepfun(x = k$x, y = c(0, k$y))
  xs = seq(from = 0, to = 1, length.out = 4e2)
  ys = fn(xs)
  list(probability = xs, proportion = ys, error = trapz(xs, abs(xs - ys)))
}

# roc curve
roc = function(probs, truth){
  probs[is.na(probs)] = 0
  truth = truth[order(probs, decreasing = T)]
  fp = cumsum(!truth)
  tp = cumsum(truth)
  fpr = fp/max(fp)
  tpr = tp/max(tp)
  tpr[!is.finite(tpr)] = 0
  fn = stepfun(x = fpr, y = c(0, tpr))
  xs = seq(from = 0, to = 1, length.out = 4e2)
  ys = fn(xs)
  out = list(fpr = xs, tpr = ys)
  out$auc = trapz(xs, ys)
  out
}

#' @param type can be "cal" or "roc".
inference = function(dataset, analysis, type = "calibration"){
  beta = as.numeric(as.matrix(dataset@supplement$truth$beta))
  ch = Chain(dataset)
  ch@betaPostMean = beta
  ch@betaPostMeanSquare = 2*beta^2
  ef = effect_sizes(ch)
  truth = ef > 0
  p = probs(analysis)
  colnames(p) = new_colnames(colnames(p))
  out = list()
  for(i in 1:ncol(p)){
    x = get(type)(p[,i], truth[,i])
    x$heterosis = gsub("-", " ", colnames(p)[i])
    out[[i]] = as.data.frame(x, stringsAsFactors = F)
  }
  do.call(rbind, out)
}
