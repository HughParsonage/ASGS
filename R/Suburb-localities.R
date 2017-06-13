#' @title Boundaries of Australian suburbs
#' @description A (tidied) \code{data.table} containing the latitude and longitude of all verticles of the 
#' polygons enclosing suburbs and localities in Australia.
#' @format A \code{data.table} of 13,121,341 rows and 11 columns.
#' \describe{
#' \item{LOC_PID}{The internal locality identifier used in the ASGS.}
#' \item{NAME}{The ordinary name of the locality.}
#' \item{group}{The identifier for the polygon consisting of three dot-separated elements: the state, the intrastate locality id, and the piece.}
#' \item{lon}{The longitude of the vertex.}
#' \item{lat}{The latitude of the vertex.}
#' \item{order}{The order the vertices of the polygon are to be drawn.}
#' \item{hole}{Does the polygon contain a hole.}
#' }
"Suburbs_DT"