library(rgdal)
library(rgeos)
library(dtplyr)
library(dplyr)
library(data.table)
library(magrittr)

proj_dir <- getwd()

setwd("./data-raw/ABS-2011-ASGS/1270055001_sa2_2011_aust_shape/")
SA2_2011 <- readOGR(".", layer = "SA2_2011_AUST")

use_data(SA2_2011)

.SA2_2011_centroids <- 
  gCentroid(SA2_2011, byid = TRUE) %>% 
  as.data.frame %>%
  mutate(id = rownames(.)) %>%
  as.data.table
  

SA2_2011_centroids <- 
  SA2_2011@data %>%
  mutate(id = rownames(.)) %>%
  as.data.table %>%
  merge(.SA2_2011_centroids, by = "id") %>%
  select(SA2_MAIN11, SA2_NAME11, lon = x, lat = y)

use_data(SA2_2011_centroids)

setwd("~/../Downloads/1270055001_sa2_2016_aust_shape")

SA2_2016 <- readOGR(".", layer = "SA2_2016_AUST")
devtools::use_data(SA2_2016)

SA_decoder <- fread("~/../Downloads/1270055001_sa2_2016_aust_shape/SA2_decoder.csv")
devtools::use_data(SA_decoder)

setwd("data-raw/1270055001_sa1_2016_aust_shape/")
SA1_2016 <- readOGR(".", layer = "SA1_2016_AUST")
devtools::use_data(SA1_2016)

.SA1_2016_centroids <- 
  gCentroid(SA1_2016, byid = TRUE) %>% 
  as.data.frame %>%
  mutate(id = rownames(.)) %>%
  as.data.table


SA1_2016_centroids <- 
  SA1_2016@data %>%
  mutate(id = rownames(.)) %>%
  as.data.table %>%
  merge(.SA1_2016_centroids, by = "id") %>%
  .[, .(SA1_MAIN16, lon = x, lat = y)]

devtools::use_data(SA1_2016_centroids)

setwd("~/../Downloads/1270055003_lga_2016_aust_shape/")
LGA_2016 <- readOGR(".", layer = "LGA_2016_AUST")
devtools::use_data(LGA_2016)

.LGA_2016_centroids <- 
  gCentroid(LGA_2016, byid = TRUE) %>% 
  as.data.frame %>%
  mutate(id = rownames(.)) %>%
  as.data.table

LGA_2016_centroids <- 
  LGA_2016@data %>%
  mutate(id = rownames(.)) %>%
  as.data.table %>%
  merge(.LGA_2016_centroids, by = "id") %>%
  .[, .(LGA_NAME16, lon = x, lat = y)]

devtools::use_data(LGA_2016_centroids)

setwd("~/../Downloads/1270055003_ced_2016_aust_shape/")
CED_2016 <- readOGR(".", layer = "CED_2016_AUST")
setwd("~/ASGS")
devtools::use_data(CED_2016)

.CED_2016_centroids <- 
  gCentroid(CED_2016, byid = TRUE) %>% 
  as.data.frame %>%
  mutate(id = rownames(.)) %>%
  as.data.table

CED_2016_centroids <- 
  CED_2016@data %>%
  mutate(id = rownames(.)) %>%
  as.data.table %>%
  merge(.CED_2016_centroids, by = "id") %>%
  .[, .(CED_NAME16, lon = x, lat = y)]

devtools::use_data(CED_2016_centroids)

setwd("~/../Downloads/1270055003_poa_2016_aust_shape/")
POA_2016 <- readOGR(".", layer = "POA_2016_AUST")
setwd("~/ASGS")
devtools::use_data(POA_2016)

.POA_2016_centroids <- 
  gCentroid(POA_2016, byid = TRUE) %>% 
  as.data.frame %>%
  mutate(id = rownames(.)) %>%
  as.data.table

POA_2016_centroids <- 
  POA_2016@data %>%
  mutate(id = rownames(.)) %>%
  as.data.table %>%
  merge(.POA_2016_centroids, by = "id") %>%
  .[, .(POA_NAME16, lon = x, lat = y)]

devtools::use_data(POA_2016_centroids)


# Destination zones:
setwd("~/../Downloads/80000_dzn_2011_aust_shape/")
DZN_2011 <- readOGR(".", layer = "DZN_2011_AUST")
setwd("~/ASGS")
devtools::use_data(DZN_2011)


