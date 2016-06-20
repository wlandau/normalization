library(workflowHelper)

sources = c("config.R", paste0("R/", list.files("R")))
packages = strings(edgeR, fbseq, ggplot2, ggthemes, pracma, reshape2)

datasets = commands(
  edgeR = simulation_edgeR(),
  model = simulation_model(),
  simple = simulation_simple()
)

analyses = commands(
  default = default(..dataset..),
  tmm = tmm(..dataset..),
  zero = zero(..dataset..)
)

summaries = commands(
  calibration = inference(..dataset.., ..analysis.., I("calibration")),
  mse = summary_mse(..dataset.., ..analysis..),
  psrf = summary_psrf(..analysis..),
  roc = inference(..dataset.., ..analysis.., I("roc"))
)

output = commands(
  "fig/calibration_error.pdf" = plot_cal_error(calibration),
  "fig/auc.pdf" = plot_auc(roc),
  "fig/calibration.pdf" = plot_calibration(calibration),
  "fig/mse.pdf" = plot_mse(mse),
  "fig/roc.pdf" = plot_roc(roc)
)

plan_workflow(sources = sources, packages = packages, datasets = datasets,
  analyses = analyses, summaries = summaries, output = output,
  clean = "rm -rf err.txt fig Makefile out.txt README.html remake.yml")
