#' Smooth a shapfile by nearest neighbourhood
#' @description Given a shapefile and a \code{data.frame} with a value for each polygon,
#' return a smoothed value of the values.
#' @param shapefile A shapefile (as from this package) containing an \code{as.data.frame} method.
#' @param data_by_id A \code{data.frame} containing a value for each polygon within \code{shapefile}.
#' @param id The key of \code{data_by_id} on which the shapefile may be merged with \code{shapefile}.
#' @param var2smooth A length-one character vector indicating which variable in \code{data_by_id} to smooth.
#' @param k Passed to \code{\link{spdep::knearneigh}}. 
#' @param coalesce.to A single value. If there are any missing values in \code{data_by_id[[id]]}, what should these be imputed as? Must
#' have the same storage mode as \code{data_by_id[[id]]}.
#' 
#' @return A vector of values representing the smoothed version of \code{data_by_id[[id]]}.
#' @export

smooth_shapefile <- function(shapefile, data_by_id, id, var2smooth, k = 10, coalesce.to = 0) {
  stopifnot(is.data.frame(data_by_id),
            id %in% names(data_by_id),
            var2smooth %in% names(data_by_id),
            identical(storage.mode(data_by_id[[id]]), 
                      storage.mode(coalesce.to)))
  
  
  shapefile_df <- as.data.frame(shapefile)
  coords <- sp::coordinates(shapefile)
  IDs <- row.names(shapefile_df)
  knn50 <- spdep::knn2nb(spdep::knearneigh(coords, k = k), row.names = IDs)
  knn50 <- spdep::include.self(knn50)
  
  x <- 
    shapefile_df %>%
    merge(data_by_id, by = id, all.x = TRUE, sort = FALSE) %>%
    .[[var2smooth]]
  
  spdep::localG(x = as.numeric(dplyr::coalesce(x, coalesce.to)),
                listw = spdep::nb2listw(knn50, style = "B"),
                zero.policy = TRUE)
}
