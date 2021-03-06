simulation_edgeR = function(){
  genes = globals("genes")
  libraries = 16
  data(paschold)
  paschold = get("paschold")
  if(scaling() == "down") paschold@counts = paschold@counts[1:genes,]
  fit = fit_edgeR(paschold@counts, paschold@design)

  beta = fit$estimates[,grep("beta_", colnames(fit$estimates))]
  gs = sample.int(nrow(paschold@counts), genes, replace = T)
  ns = 0:(libraries -1) %% ncol(paschold@counts) + 1
  group = (ns + (ns %% 2)) / 2

  beta = beta[gs,]
  disp = fit$dispersion[gs]
  norm_factors = fit$norm_factors[ns]

  norm_mat = matrix(rep(norm_factors, each = genes), nrow = genes)
  disp_mat = matrix(rep(disp, times = libraries), nrow = genes)

  design = paschold@design[ns,]
  lambda = t(design %*% t(beta)) + log(norm_mat)

  counts = matrix(rnbinom(n = prod(dim(lambda)), mu = exp(lambda), size = 1/disp_mat), nrow = genes)

  libnames = colnames(paschold@counts)
  libnames = gsub("B73xMo17_Mo17xB73", "hybrids", libnames)
  libnames = gsub("B73xMo17", "hybrid1", libnames)
  libnames = gsub("Mo17xB73", "hybrid2", libnames)
  libnames = gsub("B73", "parent1", libnames)
  libnames = gsub("Mo17", "parent2", libnames)
  libnames = gsub("_.*", "", libnames)
  libnames = paste0(libnames[ns], "_", 1:libraries)

  rownames(counts) = paste0("gene_", 1:genes)
  colnames(counts) = rownames(design) = libnames

  truth = list(
    fit = fit, 
    gs = gs,
    ns = ns,
    beta = beta,
    lambda = lambda,
    disp = disp,
    norm_factors = norm_factors
  )

  supplement = list(
    simulation = "edgeR",
    group = group,
    truth = truth
  )

  Scenario(
    counts = counts, 
    design = design, 
    contrasts = paschold@contrasts, 
    bounds = paschold@bounds, 
    propositions = paschold@propositions,
    supplement = supplement
  )
}
