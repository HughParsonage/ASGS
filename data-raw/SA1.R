library(dtplyr)
library(dplyr)
library(magrittr)
library(data.table)
library(rgdal)
library(rgeos)

setwd("./data-raw/ABS-2011-ASGS/1270055001_sa1_2011_aust_shape/")
SA1_2011 <- readOGR(".", layer = "SA1_2011_AUST")

.SA1_2011_centroids <- 
  gCentroid(SA1_2011, byid = TRUE) %>% 
  as.data.frame %>%
  mutate(id = rownames(.)) %>%
  as.data.table

SA1_2011_centroids <- 
  SA1_2011@data %>%
  mutate(id = rownames(.)) %>%
  as.data.table %>%
  merge(.SA1_2011_centroids, by = "id") %>%
  select(SA1_MAIN11, SA2_MAIN11, lon = x, lat = y)

SA2_2011_weighted_centroids <-
  SA1_2011_centroids %>%
  .[, .(lon = mean(lon), 
        lat = mean(lat)), 
    by = SA2_MAIN11]

devtools::use_data(SA1_2011,
                   SA1_2011_centroids, 
                   SA2_2011_weighted_centroids)
