#' Draw leaflet charts in grattan style
#' @param DT A data frame whose first column is of the form \code{SA[1-4]_(CODE|NAME)(11|16)} as a key to join with ASGS shapefiles.
#' Other required names are \code{fillColor}, \code{labelTitle}, and \code{labelText}.
#' @param Year The year to which \code{DT} applies.
#' @param simple Use a simplified shapefile (if available)?
#' @param na.value \code{fillColor} to use for unmatched polygons.
#' @return A \code{leaflet} object; a map of Australia.
#' 
#' @examples 
#' \dontrun{
#' library(readxl)
#' library(data.table)
#' library(magrittr)
#' library(grattanCharts)
#' 
#' DT <- 
#'   read_excel(system.file("extdata", "unemp.xlsx", package = "ASGS")) %>%
#'   setDT %>%
#'   .[, .(SA2_NAME11 = `Statistical Area Level 2 (SA2)`,
#'         fillColor = gpal(7)[Breaks], 
#'         labelText = `Statistical Area Level 2 (SA2)`,
#'         labelTitle = "Unemployment")]
#'         
#' grattan_leaflet(DT, Year = "2011")
#' }
#' 
#' 
#' @export

grattan_leaflet <- function(DT,
                            Year = c("2011", "2016"),
                            simple = FALSE,
                            na.value = "#6A737B") {
  noms <- names(DT)
  nom1 <- noms[1]
  fillColor <- labelTitle <- labelText <- NULL
  stopifnot("fillColor" %in% noms,
            "labelTitle" %in% noms,
            "labelText" %in% noms)
  
  # First column must be the statistical geography
  asgs <- substr(nom1, 0, 3)
  
  
  if (grepl("NAME|CODE|MAIN", nom1, ignore.case = TRUE)) {
    CodeOrName <-  toupper(gsub("^.*(NAME|CODE|MAIN).*$", "\\1", nom1, ignore.case = TRUE))
  } else {
    stop("The name of DT's first column must contain 'NAME', 'MAIN', or 'CODE' to indicate how the join is to be performed.")
  }
  Year <- match.arg(Year)
  YearInNom <- as.integer(gsub("^.*(.{2})$", "\\1", nom1)) + 2000
  if (as.integer(Year) != YearInNom) {
    warning("Using Year = ", Year, ", but DT's first column is ", nom1, ".")
  }
  
  
  switch(Year,
         "2011" = {
           shapefile <- 
             switch(asgs,
                    "SA1" = SA1_2011,
                    "SA2" = SA2_2011,
                    "SA3" = SA3_2011,
                    "SA4" = SA4_2011,
                    stop("The name of DT's first column must start with SA[1-4] to indicate the geography."))
         },
         "2016" = {
             switch(asgs,
                    "SA1" = SA1_2016,
                    "SA2" = SA2_2016,
                    "SA3" = SA3_2016,
                    "SA4" = SA4_2016,
                    stop("The name of DT's first column must start with SA[1-4] to indicate the geography."))
         })
  
  data_slot <- setDT(slot(shapefile, "data"))
  data_slot_key <- 
    grep(paste0(asgs, ".*", CodeOrName), names(data_slot), value = TRUE)[1]
  
  slot(shapefile, "data") <- 
    DT[data_slot, on = paste0(nom1, "==", data_slot_key)] %>%
    # merge(data_slot, 
    #       DT,
    #       by.x = data_slot_key,
    #       by.y = nom1, 
    #       all.x = TRUE) %>%
    # as.data.table %>%
    setorderv(grep(paste0(asgs, ".*", "MAIN|CODE"), names(.), value = TRUE)[1]) %>%
    .[is.na(fillColor), fillColor := na.value] %>%
    .[]
  
  drawn_shapefile <- 
    if (simple) {
      switch(Year,
             "2011" = {
                 switch(asgs,
                        "SA1" = SA1_2011_simple,
                        "SA2" = SA2_2011_simple,
                        "SA3" = SA3_2011_simple,
                        "SA4" = shapefile)
             },
             "2016" = {
               shapefile <- 
                 switch(asgs,
                        "SA1" = SA1_2016_simple,
                        "SA2" = SA2_2016_simple,
                        "SA3" = shapefile,
                        "SA4" = shapefile)
             })
    } else {
      shapefile
    }
  
  drawn_shapefile %>%
    leaflet %>%
    addPolygons(stroke = TRUE,
                opacity = 0.5,
                weight = 0.75,  # the border thickness / pixels
                color = na.value,
                fillColor = shapefile@data[["fillColor"]], 
                fillOpacity = 1,
                label = lapply(paste0("<b>", 
                                      shapefile@data[["labelTitle"]], ":",
                                      "</b><br>",
                                      shapefile@data[["labelText"]]),
                               HTML),
                highlightOptions = leaflet::highlightOptions(weight = 2,
                                                             color = "white",
                                                             opacity = 1,
                                                             dashArray = "",
                                                             bringToFront = TRUE))
}


