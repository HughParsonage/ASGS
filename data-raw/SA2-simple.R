library(rgdal)
library(rgeos)
library(dtplyr)
library(dplyr)
library(data.table)
library(magrittr)
library(geojsonio)

setwd("~/../Downloads")
# mapshaper -o precision=0.0001 format=topojson 
# 326.1 Mb -> 309.7 Mb (i.e. not worth it)
# SA1_2016_simple <- geojsonio::geojson_read("SA1-simple0001.json", what = "sp")
# setwd("~/ASGS")

setwd("~/../Downloads/mapshaper/")
SA2_2011_simple <- geojsonio::geojson_read("SA2.json", what = "sp")

setwd("~/ASGS")
devtools::use_data(SA2_2011_simple, overwrite = TRUE)

SA2_2016_simple <- geojsonio::geojson_read("./data-raw/mapshaper/SA2_2016_AUST.json",
                                           what = "sp")
devtools::use_data(SA2_2016_simple).

# mapshaper SA2_2011_AUST -o format=topojson precision=0.0001
SA1_2011_simple <- geojson_read("~/../Downloads/SA1_2011_AUST.json",
                                what = "sp")

devtools::use_data(SA1_2011_simple)

SA3_2016_simple <- geojson_read("./data-raw/mapshaper/SA3_2016_AUST.json", 
                                what = "sp")

devtools::use_data(SA3_2016_simple)
