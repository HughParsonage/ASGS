library(sf)
setwd("~/Data/ABS/ASGS_Ed3_Non_ABS_Structures_GDA2020_GPKG_updated_2022/")
layers. <- st_layers("ASGS_Ed3_Non_ABS_Structures_GDA2020_updated_2022.gpkg")
layerz <- layers.$name
for (i in seq_along(layerz)) {
  qs::qsave(sf::read_sf("ASGS_Ed3_Non_ABS_Structures_GDA2020_updated_2022.gpkg", 
                        layer = layerz[i]), 
            paste0("~/ASGS/inst/extdata/", 
                   sub("^(.*_202[12]).*", "\\1", layerz[i]),
                   ".qs"))
}

