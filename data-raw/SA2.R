library(rgdal)
library(rgeos)
library(dtplyr)
library(dplyr)
library(data.table)
library(magrittr)

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
