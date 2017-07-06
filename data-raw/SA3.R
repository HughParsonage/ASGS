library(rgdal)
library(rgeos)
library(dtplyr)
library(dplyr)
library(data.table)
library(magrittr)

setwd("~/../Downloads/1270055001_sa3_2016_aust_shape/")
SA3_2016 <- readOGR(dsn = ".", layer = "SA3_2016_AUST")

devtools::use_data(SA3_2016)

setwd("~/../Downloads/1270055001_sa4_2016_aust_shape/")
SA4_2016 <- readOGR(dsn = ".", layer = "SA4_2016_AUST")

devtools::use_data(SA4_2016)
