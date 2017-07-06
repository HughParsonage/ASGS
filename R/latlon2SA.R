#' Decode coordinates to Statistical Areas
#' 
#' @param lat,lon The latitude and longitude of the points.
#' @param to Which statistical areas (by default SA2) to map to.
#' @param return Return the spatial data frame or a vector?
#' @return A vector of the SAs mapped.
#' @export


latlon2SA <- function(lat, lon, to = c("SA2", "SA1", "SA3", "SA4"), return = c("sp", "v")) {
  # Could use NSE but can't be arsed:
  to <- match.arg(to)
  return <- match.arg(return)
  switch(to,
         "SA2" = {
           points <- sp::SpatialPoints(coords = sp::coordinates(data.frame(x = lon, y = lat)),
                                       proj4string = SA2_2011@proj4string)
           out <- sp::over(points, SA2_2011)
         }, 
         
         "SA1" = {
           points <- sp::SpatialPoints(coords = sp::coordinates(data.frame(x = lon, y = lat)),
                                       proj4string = SA1_2011@proj4string)
           out <- sp::over(points, SA1_2011)
         },
         
         "SA3" = {
           points <- sp::SpatialPoints(coords = sp::coordinates(data.frame(x = lon, y = lat)),
                                       proj4string = SA3_2011@proj4string)
           out <- sp::over(points, SA3_2011)
         },
         
         "SA4" = {
           points <- sp::SpatialPoints(coords = sp::coordinates(data.frame(x = lon, y = lat)),
                                       proj4string = SA4_2011@proj4string)
           out <- sp::over(points, SA4_2011)
         })
  if (return == "v") {
    out <- out[[paste0(to, "_NAME11")]]
  }
  out
}


