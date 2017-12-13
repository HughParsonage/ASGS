#' Decode coordinates to Statistical Areas
#' 
#' @param lat,lon The latitude and longitude of the points.
#' @param to Which statistical areas (by default SA2) to map to.
#' @param yr The year of the statistical area series.
#' @param return Return the spatial data frame (\code{sp}) or a vector (\code{v}) of the ?
#' @param NAME If \code{TRUE} and return is \code{v}, the default, the \code{NAME} is returned; otherwise, the \code{MAIN} or \code{CODE} is returned.
#' If \code{to = SA1} then, as \code{NAME} is not available, the \code{MAIN} is returned without a warning.
#' @return A vector of the SAs mapped.
#' @export


latlon2SA <- function(lat,
                      lon, 
                      to = c("SA2", "SA1", "SA3", "SA4"),
                      yr = c("2016", "2011"),
                      return = c("v", "sp"),
                      NAME = TRUE) {
  # Could use NSE but can't be arsed:
  to <- match.arg(to)
  yr <- match.arg(yr)
  return <- match.arg(return)
  stopifnot(length(to) == 1,
            length(yr) == 1)
  
  shapefile <- get(paste0(to, "_", yr))
  if (!is(shapefile, "SpatialPolygonsDataFrame")) {
    stop("Attempted to retrieve `", paste0(to, "_", yr), "` internally ",
         "but that object is not a SpatialPolygonsDataFrame. Due to ",
         "limitations of this function, ensure that this object ", 
         "does not exist except as the shapefile from the ASGS package.")
  }
  points <- sp::SpatialPoints(coords = sp::coordinates(data.frame(x = lon, y = lat)),
                              proj4string = shapefile@proj4string)
  out <- sp::over(points, shapefile)

  if (return == "v") {
    if (NAME && to != "SA1") {
      suffix <- paste0("NAME", substr(yr, 3, 4))
      v_name <- paste0(to, "_", suffix)
    } else {
      suffix <- names(out)[grepl(to, names(out)) & !grepl("NAME", names(out))]
      v_name <- suffix[1]
    }
    out <- out[[v_name]]
  }
  out
}


