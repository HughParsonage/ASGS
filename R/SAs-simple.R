#' @title Simplified shapefiles
#' @name SA_simple
#' @description Simpler (less precision, fewer vertices) of the \code{SA[1-4]} shapefiles.
#' Smaller so more suitable for some plots.
#' 
NULL

#' @rdname SA_simple
#' @export
SA3_2011_simple <- function() GET("SA3_2011_simple")

#' @rdname SA_simple
#' @export
SA3_2016_simple <- function() GET("SA3_2016_simple")

#' @rdname SA_simple
#' @export
SA1_2011_simple <- function() GET("SA1_2011_simple")

#' @rdname SA_simple
#' @export
SA2_2011_simple <- function() GET("SA2_2011_simple")

#' @rdname SA_simple
SA2_2016_simple <- function() GET("SA2_2016_simple")

#' @rdname SA_simple
'SA3_2016_simple'