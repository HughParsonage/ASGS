library(data.table)
library(rgdal)
library(devtools)

setwd("~/../Downloads/1270055003_poa_2016_aust_shape/")

Postcode <- readOGR(".", layer = "POA_2016_AUST")

devtools::use_data(Postcode)
