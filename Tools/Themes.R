library(tidyverse)

# Themes for Maps 

theme_yellowlightmap <- function (base_size = 11, base_family = "", base_line_size = base_size/22, 
                               base_rect_size = base_size/22) 
{
  half_line <- base_size/2
  t <- theme(line = element_blank(), rect = element_blank(),
             
             text = element_text(family = base_family, face = "plain", 
                                 colour = "black", size = base_size, lineheight = 0.9, 
                                 hjust = 0.5, vjust = 0.5, angle = 0, margin = margin(), 
                                 debug = FALSE), axis.text = element_blank(), axis.title = element_blank(),
             #Axis
             axis.ticks.length = unit(0, "pt"), axis.ticks.length.x = NULL, 
             axis.ticks.length.x.top = NULL, axis.ticks.length.x.bottom = NULL, 
             axis.ticks.length.y = NULL, axis.ticks.length.y.left = NULL, 
             axis.ticks.length.y.right = NULL, legend.box = NULL, 
             
             #legend
             legend.key.size = unit(1.2, "lines"), legend.position = "bottom", 
             legend.text = element_text(size = rel(0.8), colour="lightyellow"), legend.title = element_text(hjust = 0, colour="lightyellow"), 
             
             #Background
             strip.clip = "inherit", strip.text = element_text(size = rel(0.8)), 
             strip.switch.pad.grid = unit(half_line/2, "pt"), strip.switch.pad.wrap = unit(half_line/2, 
                                                                                           "pt"), panel.ontop = FALSE, panel.spacing = unit(half_line, 
                                                                                                                                          "pt"), plot.margin = unit(c(0, 0, 0, 0), "lines"),
             plot.background = element_rect(fill = "black", colour = "black"),
             panel.background = element_rect(fill = "black", colour = "black"),
             plot.margin = margin(0, 3, 0, 3, "cm")),
             
             
             plot.title = element_text(size = rel(1.2), hjust = 0.5, 
                                       vjust = 1, margin = margin(t = half_line)), plot.title.position = "panel", 
             plot.subtitle = element_text(hjust = 0.5, vjust = 1, margin = margin(t = half_line)), 
             plot.caption = element_text(size = rel(0.8), hjust = 1, 
                                         vjust = 1, margin = margin(t = half_line)), plot.caption.position = "panel", 
             plot.tag = element_text(size = rel(1.2), hjust = 0.5, 
                                     vjust = 0.5), plot.tag.position = "topleft", complete = TRUE)
  ggplot_global$theme_all_null %+replace% t
}

