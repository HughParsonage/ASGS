library(ggplot2)
library(ggthemes)
library(httr)
library(dtplyr)
library(dplyr)
library(data.table)
library(magrittr)
library(rgdal)
library(broom)
library(foreign)
library(sp)
library(leaflet)
library(maptools)

provide.dir <- function(directory) {
  dir.exists(directory) || dir.create(directory)
}

ensure_nrows <- function(DT, nrows) {
  stopifnot(nrow(DT) == nrows)
  DT
}

project_dir <- getwd()
provide.dir("./data-raw/Suburbs-Localities")
setwd("./data-raw/Suburbs-Localities")

if (!dir.exists("May-2017")) {
  if (!file.exists("May-2017.zip")) {
    GET(url = "http://data.gov.au/dataset/bdcf5b09-89bc-47ec-9281-6b8e9ee147aa/resource/d2c450e6-5ad3-45fc-a1da-b82cd30f2c47/download/suburbs---localities-may-2017.zip",
        write_disk("May-2017.zip"))
  }
  
  unzip("May-2017.zip", exdir = "May-2017")
}

setwd(dirname(dir(pattern = "\\.shp$", recursive = TRUE)[1]))

tidy_suburb_file <- function(file.shp) {
  layer <- tools::file_path_sans_ext(file.shp)
  State <- gsub("_.*$", "", layer)
  
  # Assumed to be 'ACT' in the following
  ACT <- readOGR(dsn = ".", layer = layer)
  
  LOC_PID_by_id <- 
    ACT@data %>%
    mutate(id = rownames(.)) %>%
    select(LOC_PID, id) %>%
    setDT
  
  ACT_LOCALITY <- read.dbf(paste0(State, "_LOCALITY_shp.dbf")) %>% setDT
  
  ACT_NAME_by_LOC_PID <- ACT_LOCALITY %>% select(LOC_PID, NAME)
  
  setDT(broom::tidy(ACT)) %>%
    LOC_PID_by_id[., on = "id"] %>%
    ACT_NAME_by_LOC_PID[., on = "LOC_PID"] %>%
    .[, STATE := State]
  
  
}

Suburbs_DT <- 
  dir(pattern = "\\.shp$") %>%
  lapply(tidy_suburb_file) %>%
  rbindlist(use.names = TRUE) %>%
  .[, group2 := paste0(STATE, ".", group)] %>% 
  select(LOC_PID, NAME, group = group2, lon = long, lat, order, hole)

setwd(project_dir)

for (nom in names(Suburbs_DT)) {
  v <- Suburbs_DT[[nom]]
  if (is.character(v)) {
    Suburbs_DT[, (nom) := as.factor(v)]
  }
}

use_data(Suburbs_DT, overwrite = TRUE)

  
  
  