simulation_simple = function(){
  libraries = 16
  genes = globals("genes")
  data(paschold)
  paschold = get("paschold")

  ns = 0:(libraries -1) %% ncol(paschold@counts) + 1
  group = (ns + (ns %% 2)) / 2
  design = paschold@design[ns,]

  beta = matrix(0, nrow = genes, ncol = ncol(design))
  colnames(beta) = colnames(design)
  rownames(beta) = paste0("gene_", 1:genes)
  
  const = 0.25
  beta[,1] = rnorm(genes, 4, 1)
  beta[,2] = sample(const * c(0, -1, 1), genes, prob = c(0.5, 0.25, 0.25), replace = T)
  beta[,3] = sample(const * c(0, -1, 1), genes, prob = c(0.5, 0.25, 0.25), replace = T)
  beta[,4] = sample(const * c(0, -1, 1), genes, prob = c(0.99, 0.005, 0.005), replace = T)
  beta[,5] = rnorm(genes, 0, 0.1)

  lambda = t(design %*% t(beta))
  disp = 0.01

  counts = matrix(rnbinom(n = prod(dim(lambda)), mu = exp(lambda), size = 1/disp), nrow = genes)

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
    beta = beta,
    lambda = lambda,
    disp = rep(disp, nrow(beta))
  )

  supplement = list(
    simulation = "simple",
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
