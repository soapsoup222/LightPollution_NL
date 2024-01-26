# Functions 
library(tidyverse)
library(blackmarbler)
library(geodata)
library(sf)
library(raster)
library(ggplot2)
library(usmapdata)
library(magick)


#Function to create Night Time Lights (NTL) Raster file
get_NTLraster <- function(country, product_id, ymd, low.rm = FALSE, mask = FALSE){
  bearer <- "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbF9hZGRyZXNzIjoidi5uYXJla3VsaUB1Y3IubmwiLCJpc3MiOiJBUFMgT0F1dGgyIEF1dGhlbnRpY2F0b3IiLCJpYXQiOjE3MDU2NzI2OTQsIm5iZiI6MTcwNTY3MjY5NCwiZXhwIjoxODYzMzUyNjk0LCJ1aWQiOiJ2YXlvbmFuIiwidG9rZW5DcmVhdG9yIjoidmF5b25hbiJ9.RvDSDaToKGlvHRjQWFXoE-Yy8aRCA070LDSZUFOFWJE"
  roi_sf <-  gadm(country = country, level=1, path = tempdir()) |> st_as_sf()
  
  r <- bm_raster(roi_sf = roi_sf,
                 product_id = product_id,
                 date = as.character(ymd),
                 bearer = bearer,
                 check_all_tiles_exist = FALSE) 
  if (mask == TRUE){
    r <- r |> 
      mask(roi_sf) |>  
      rasterToPoints(spatial = TRUE) |> 
      as.data.frame()
  } else {
    r <- r |>
      rasterToPoints(spatial = TRUE) |> 
      as.data.frame()
  }
  names(r) <- c("value", "x", "y")
  if (low.rm == TRUE) {
    #remove low values
    r$value[r$value <= 2] <- 0
    #log to unskew
    r$value_adj <- log(r$value+1)
    return(r)
  } else {
    #log to unskew
    r$value_adj <- log(r$value+1)
    return(r)
  }
}

#Function to create maps of the raster based on themes
#Three themes: 
  # Nighttime
  # Yellowred
  # Neonheatmap
  # Pastel heatmap 

get_NTLmap <- function(raster, maptheme, year){
  if (maptheme == "Nighttime") {
    ggplot() +
      geom_raster(data = raster,
                aes(x = x, y = y,
                    fill = value_adj))+
      scale_fill_gradientn(colours = c("#070e34", "#ffe605", "white"),
                           values = c(0, 0.5, 1))+
      labs(fill = "Radiance/nW·cm-2·sr-1", 
           title = paste0("Light Pollution in the Netherlands ", year),
           subtitle = "Before Darkness Areas")+
      coord_quickmap() +
      theme_void() +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, colour = "lightyellow"),
            plot.subtitle = element_text(face = "bold", hjust = 0.5, colour = "lightyellow"),
            legend.position = "bottom",
            legend.title = element_text(face = "bold",vjust = 0.5, colour="lightyellow"),
            legend.text = element_text(colour="lightyellow"),
            plot.background = element_rect(fill = "#00011d", colour = "#00011d"),
            panel.background = element_rect(fill = "#00011d", colour = "#00011d"),
            plot.margin = margin(0.5, 2, 0.5, 2, "cm"))
  } 
  
  else if (maptheme == "Neonheatmap") {
    ggplot() +
      geom_raster(data = raster,
                  aes(x = x, y = y,
                      fill = value_adj))+
      scale_fill_gradientn(colours = c("grey5","#0d0d89","#0000ff","#00ffff", "#00b200", "#ffff00", "#d10000"),
                           values = c(0, 0.1, 0.2, 0.25, 0.3, 0.5, 1))+
      labs(fill = "Radiance/nW·cm-2·sr-1", 
           title = paste0("Light Pollution in the Netherlands ", year),
           subtitle = "Before Darkness Areas")+
      coord_quickmap() +
      theme_void() +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, colour = "lightblue"),
            plot.subtitle = element_text(face = "bold", hjust = 0.5, colour = "lightblue"),
            legend.position = "bottom",
            legend.title = element_text(face = "bold",vjust = 0.5, colour="lightblue"),
            legend.text = element_text(colour="lightblue"),
            plot.background = element_rect(fill = "#2f3132", colour = "#2f3132"),
            panel.background = element_rect(fill = "#2f3132", colour = "#2f3132"),
            plot.margin = margin(0.5, 2, 0.5, 2, "cm"))
  } 
  else if (maptheme == "Pastelheatmap") {
    ggplot() +
      geom_raster(data = raster,
                aes(x = x, y = y,
                    fill = value_adj))+
      scale_fill_gradientn(colours = c("#668ec2", "#b7deec", "#fbf8c4", "#fbb07a", "#d9534c", "#982fb5"),
                           values = c(0, 0.1, 0.2, 0.3, 0.5, 1))+
      labs(fill = "Radiance/nW·cm-2·sr-1", 
           title = paste0("Light Pollution in the Netherlands ", year),
           subtitle = "Before Darkness Areas")+
      coord_quickmap() +
      theme_void() +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, colour = "lightblue"),
            plot.subtitle = element_text(face = "bold", hjust = 0.5, colour = "lightblue"),
            legend.position = "bottom",
            legend.title = element_text(face = "bold",vjust = 0.5, colour="lightblue"),
            legend.text = element_text(colour="lightblue"),
            plot.background = element_rect(fill = "#2f3132", colour = "#2f3132"),
            panel.background = element_rect(fill = "#2f3132", colour = "#2f3132"),
            plot.margin = margin(0.5, 2, 0.5, 2, "cm"))
  } else {
    message("Not a valid theme. Choose from Nighttime, Neonheatmap, or Pastelheatmap")
  }
}



