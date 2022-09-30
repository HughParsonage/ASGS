library(sf)
setwd("~/Data/ABS/ASGS_2021_MAIN_STRUCTURE_GPKG_GDA2020/")
SA1_2021 <- st_read("ASGS_2021_Main_Structure_GDA2020.gpkg", layer = "SA1_2021_AUST_GDA2020")
SA2_2021 <- st_read("ASGS_2021_Main_Structure_GDA2020.gpkg", layer = "SA2_2021_AUST_GDA2020")
SA3_2021 <- st_read("ASGS_2021_Main_Structure_GDA2020.gpkg", layer = "SA3_2021_AUST_GDA2020")
SA4_2021 <- st_read("ASGS_2021_Main_Structure_GDA2020.gpkg", layer = "SA4_2021_AUST_GDA2020")
STE_2021 <- st_read("ASGS_2021_Main_Structure_GDA2020.gpkg", layer = "STE_2021_AUST_GDA2020")
MB_2021 <- st_read("ASGS_2021_Main_Structure_GDA2020.gpkg", layer = "MB_2021_AUST_GDA2020")
setwd("~/ASGS")
qs::qsave(SA1_2021, "~/ASGS/inst/extdata/SA1_2021.qs")
qs::qsave(SA2_2021, "~/ASGS/inst/extdata/SA2_2021.qs")
qs::qsave(SA3_2021, "~/ASGS/inst/extdata/SA3_2021.qs")
qs::qsave(SA4_2021, "~/ASGS/inst/extdata/SA4_2021.qs")

for (state in unique(MB_2021$STATE_CODE_2021)) {
  qs::qsave(dplyr::filter(MB_2021, STATE_CODE_2021 == state),
            paste0("~/ASGS/inst/extdata/MB", state, "_2021.qs"))
}

for (obj in ls(.getNamespaceInfo(asNamespace("ASGS"), "lazydata"))) {
  if (inherits(o <- get(obj), "SpatialPolygonsDataFrame")) {
    flush.console();
    cat(obj, "\r")
    qs::qsave(sf::st_as_sf(o), paste0("~/ASGS/inst/extdata/", obj, ".qs"))
  }
}
