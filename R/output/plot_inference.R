mycolors = c("black", "blue", "red", "green", "purple")

get_df = function(lst){
  for(x in names(lst)) lst[[x]]$name = x
  m = as.data.frame(do.call(rbind, lst))
  m$dataset = gsub("_[a-zA-Z]+", "", m$name)
  m$analysis = gsub("[a-zA-Z]+_", "", m$name)
  m
}

# plot calibration errors
plot_cal_error = function(cal){
  d = get_df(cal)
  normlab = "normalization method"
  ggplot(d) +
    geom_point(aes(x = analysis, y = error)) + 
    geom_line(aes(x = analysis, y = error, group = dataset)) + 
    facet_grid(dataset~heterosis, scales = "free") + 
    labs(color = normlab, linetype = normlab) +
    xlab(normlab) + 
    ylab("calibration error") + 
    mytheme() + 
    theme(axis.text.x = element_text(angle = -80, hjust = 0))
}

# plot areas under roc curves
plot_auc = function(roc){
  d = get_df(roc)
  normlab = "normalization method"
  ggplot(d) +
    geom_point(aes(x = analysis, y = auc)) + 
    geom_line(aes(x = analysis, y = auc, group = dataset)) + 
    facet_grid(dataset~heterosis, scales = "free") + 
    labs(color = normlab, linetype = normlab) +
    xlab(normlab) + 
    ylab("area under roc curve") + 
    mytheme() + 
    theme(axis.text.x = element_text(angle = -80, hjust = 0))
}

# plot calibration curves
plot_calibration = function(cal){
  d = get_df(cal)
  normlab = "normalization method"
  ggplot(d) +
    geom_line(aes(x = probability, y = proportion, 
      group = analysis, color = analysis, linetype = analysis)) + 
    facet_grid(dataset~heterosis, scales = "free") + 
    geom_abline(slope = 1, intercept = 0) +
    labs(color = normlab, linetype = normlab) +
    xlab("estimated posterior probability of heterosis") + 
    ylab("proportion of heterosis genes") + 
    scale_color_manual(name = "normalization method", 
      labels = unique(d$analysis), 
      values = mycolors[1:length(unique(d$analysis))]) +
    mytheme() + 
    theme(legend.position = "top") +
    theme(axis.text.x = element_text(angle = -80, hjust = 0))
}

# plot roc curves
plot_roc = function(roc){
  d = get_df(roc)
  normlab = "normalization method"
  ggplot(d) +
    geom_line(aes(x = fpr, y = tpr, group = analysis, color = analysis, linetype = analysis)) + 
    facet_grid(dataset~heterosis, scales = "free") + 
    labs(color = normlab, linetype = normlab) +
    xlab("false positive rate") + 
    ylab("true positive rate") + 
    scale_color_manual(name = "normalization method", 
      labels = unique(d$analysis), 
      values = mycolors[1:length(unique(d$analysis))]) +
    mytheme() + 
    theme(legend.position = "top") +
    theme(axis.text.x = element_text(angle = -80, hjust = 0))
}



