#' Decode coordinates to Statistical Areas
#' 
#' @param lat,lon The latitude and longitude of the points.
#' @param to Which statistical areas (by default SA2) to map to.
#' @param yr The year of the statistical area series.
#' @param return. Return the spatial data frame (\code{sp}) or a vector (\code{v}) of the ?
#' @param NAME If \code{TRUE} and return is \code{v}, the default, the \code{NAME} is returned; otherwise, the \code{MAIN} or \code{CODE} is returned.
#' If \code{to = SA1} then, as \code{NAME} is not available, the \code{MAIN} is returned without a warning.
#' @param crs An integer, the coordinate reference system argument passed to 
#' \code{sf::st_as_sf}. If \code{NULL}, the default, the CRS is assumed to be the same
#' as the spatial features object requested (e.g. `SA2_2021()` under the default 
#' arguments).
#' @return A vector or spatial feature object of the SAs mapped.
#' @export


latlon2SA <- function(lat, lon,
                      to = c("SA2", "SA1", "SA3", "SA4", "POA"),
                      yr = "2021",
                      return. = c("sf", "v"),
                      NAME = TRUE,
                      crs = NULL) {
  to <- match.arg(to)
  return. <- match.arg(return.)
  stopifnot(length(lat) == length(lon),
            is.numeric(lat),
            is.numeric(lon))
  
  # This package's object for the given area
  sa_ <- GET(paste0(to, "_", yr))
  crs_null <- is.null(crs)
  if (crs_null) {
    crs <- sf::st_crs(sa_)
  }
  pts <- data.frame(lat, lon)
  coo <- sf::st_as_sf(pts, coords = c("lon", "lat"), crs = crs)
  # Transform the coordinates (as likely to be small i.e. faster relative to the shapefile)
  if (!crs_null) {
    coo <- sf::st_transform(coo, sf::st_crs(sa_))
  }
  out <- sf::st_join(coo, sa_)
  if (return. == "sf") {
    return(out)
  }
  # nom is the name of the column from the sf so created
  # containing the vector requested
  nom <- paste0(to, if (NAME) "_NAME" else "_CODE", substr(as.character(yr), 3, 4))
  if (!hasName(out, nom)) {
    warning("Column ", nom, " not found in sf object so returning the sf object.")
    return(out)
  }
  .subset2(out, nom)
}


