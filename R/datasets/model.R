simulation_model = function(){
  libraries = 16
  genes = globals("genes")
  data(paschold)
  paschold = get("paschold")
  s = scenario_heterosis_model(genes, libraries)
  ns = 0:(libraries -1) %% ncol(paschold@counts) + 1
  s@supplement$group = (ns + (ns %% 2)) / 2
  s@supplement$simulation = "model"
  truth = s@supplement$truth
  beta = matrix(truth@beta, ncol = 5)
  gamma = truth@gamma
  s@supplement$truth = list(beta = beta, gamma = gamma, disp = gamma)
  s
}
