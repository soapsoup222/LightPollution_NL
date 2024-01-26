# Functions testing

#Getting a raster
raster_nolow <- get_NTLraster(country = "NLD", product_id = "VNP46A4", ymd = "2015", low.rm = TRUE, mask = FALSE)

raster_yeslow <- get_NTLraster(country = "NLD", product_id = "VNP46A4", ymd = "2015", low.rm = FALSE, mask = FALSE)

raster_yeslow_yesmask <- get_NTLraster(country = "NLD", product_id = "VNP46A4", ymd = "2015", low.rm = FALSE, mask = TRUE)

raster_nolow_yesmask <- get_NTLraster(country = "NLD", product_id = "VNP46A4", ymd = "2015", low.rm = TRUE, mask = TRUE)

#mapping rasters

get_NTLmap(raster = raster_nolow, maptheme = "Nighttime", year="2015")

get_NTLmap(raster = raster_nolow_yesmask, maptheme = "Nighttime", year="2015")

get_NTLmap(raster = raster_yeslow, maptheme = "Nighttime", year="2015") 

get_NTLmap(raster = raster_nolow, maptheme = "Neonheatmap", year="2015")

get_NTLmap(raster = raster_yeslow, maptheme = "Neonheatmap", year="2015")

get_NTLmap(raster = raster_nolow, maptheme = "Pastelheatmap", year="2015")

get_NTLmap(raster = raster_yeslow, maptheme = "Pastelheatmap", year="2015") 
  

get_NTLmap(raster = raster_yeslow, maptheme = "Pastelheatmap", year="2015") +coord_fixed(xlim = c(3.3, 4.5), ylim = c(51, 52.2)) 


#gif testing

save_NTLimages(maptheme="Pastelheatmap" , years = c(2015:2017), folderpath = "C:/Apprenticeship/LightPollution_NL/Tests/Testing_Images2")

