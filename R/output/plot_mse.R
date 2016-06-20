# plot mean squared error
plot_mse = function(mse){
  dirs()
  m = as.data.frame(do.call(rbind, mse))
  m$dataset = gsub("_[a-zA-Z]+", "", rownames(m))
  m$analysis = gsub("[a-zA-Z]+_", "", rownames(m))
  d = melt(m, id.vars = c("dataset", "analysis"))
  d$variable = as.character(d$variable)
  d$variable = gsub("_", "[", d$variable)
  d$variable = paste0(d$variable, "]")
  pl = ggplot(d) +
    geom_point(aes(x = analysis, y = value)) + 
    geom_line(aes(x = analysis, y = value, group = variable)) + 
    facet_grid(dataset~variable, labeller = label_parsed, scales = "free") + 
    xlab("normalization method") + 
    ylab("mean squared error") + 
    mytheme() + 
    theme(axis.text.x = element_text(angle = -80, hjust = 0))
  ggsave("fig/mse.pdf", pl, dpi = 1200, width = 9, height = 7)
}
