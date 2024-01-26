# Functions 

library(blackmarbler)
library(geodata)
library(sf)
library(raster)
library(ggplot2)
library(usmapdata)
library(magick)

save_NTLimages <- function(country = "NLD", 
                           product_id = "VNP46A4", 
                           years,
                           low.rm = FALSE, 
                           mask = FALSE, 
                           maptheme = "Nighttime",
                           folderpath){
  for (y in years) {
    year <- as.character(y)
    raster <- get_NTLraster(country = "NLD", product_id = "VNP46A4", ymd = year )
    
    NTLplot <- get_NTLmap(raster = raster, maptheme = maptheme, year = year)
    
    
    fp <- file.path(folderpath, paste0(y, ".png"))
    
    ggsave(plot = NTLplot, 
           filename = fp, 
           device = "png")
  }
  
  NTLgif <- list.files(folderpath, full.names = TRUE) |> 
    lapply(image_read) |>
    image_join() |> 
    image_animate(fp = 1)
  
  image_write(image = NTLgif,
              path = paste0(folderpath,"/NTL.gif"))
}




#loop to create and save images



