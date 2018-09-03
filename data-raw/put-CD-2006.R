library(magrittr)
library(data.table)
library(rgdal)
library(rgeos)
library(maptools)
library(raster)

states <- c("nsw", "vic", "qld", "wa", "sa", "act", "tas", "nt", "ot")

for (state in states) {
  setwd(paste0("~/../Downloads/1259030002_cd06a", state, "_shape"))
  
  polygon <- readOGR(".", layer = paste0("CD06a", toupper(state)))
  # new_polygon <- 
  #   spTransform(polygon,
  #               CRS("+init=epsg:3112"))
  # buffered <- gBuffer(new_polygon, byid = TRUE, width = 0)
  # buffered
  assign(paste0("cd06", state), polygon)
  assign(paste0("cd06", state, "_centroid"),
         cbind(as.data.table(polygon@data), 
               as.data.table(as.data.frame(gCentroid(polygon, byid = TRUE)))))
  
  sla_centroids <- 
    rbindlist(lapply(lapply(lapply(split(polygon,
                                         f = polygon@data$SLA_NAME06),
                                   gCentroid),
                            as.data.table),
                     identity),
              idcol = "id")
  
  assign(paste0("sla06", state, "_centroid"), sla_centroids)
}

all_cds <- lapply(paste0("cd06", states), get)

CD_2006 <- get(paste0("cd06", state[1]))
for (i in seq_along(states[-1])) {
  if (states[i] != "ot") {
    CD_2006 <- union(CD_2006,
                     get(paste0("cd06", states[i])))
  }
}

cat(paste0("use_data(cd06", states, "_centroid)"), sep = "\n")
use_data(cd06nsw_centroid)
use_data(cd06vic_centroid)
use_data(cd06qld_centroid)
use_data(cd06wa_centroid)
use_data(cd06sa_centroid)
use_data(cd06act_centroid)
use_data(cd06tas_centroid)
use_data(cd06nt_centroid)
use_data(cd06ot_centroid)

devtools::use_data(sla06act_centroid,
                   sla06nsw_centroid,
                   sla06nt_centroid,
                   sla06ot_centroid,
                   sla06qld_centroid,
                   sla06sa_centroid,
                   sla06tas_centroid,
                   sla06vic_centroid,
                   sla06wa_centroid)







