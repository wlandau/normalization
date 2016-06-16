mytheme = function(){
  theme_few() + 
  theme(
    axis.ticks = element_line(color = "black"), 
    panel.border = element_rect(color = "black", size = 1.2),
    strip.text = element_text(size = 16), 
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 12),
    legend.text = element_text(size = 14), 
    legend.title = element_text(size = 16),
    axis.title.x = element_text(margin = margin(t = 15)),
    axis.title.y = element_text(margin = margin(r = 15))
  )
}