#' Retrieve objects from the package directory
#' @description Objects are stored as files in this package. These functions
#' retrieve the files and keep them in the package environment.
#' 
#' @param nom The name of the object to retrieve.
#' @noRd
GET <- function(nom) {
  if (exists(nom, envir = ENV(), inherits = FALSE)) {
    return(get(nom, envir = ENV(), inherits = FALSE))
  }
  if (nom == "MB_2021") {
    L <-
      lapply(c(1:9, "Z"), function(m) {
        file.qs <- system.file("extdata",
                               paste0("MB", m, "_2021.qs"),
                               package = "ASGS")
        if (!file.exists(file.qs)) {
          stop(file.qs, "m = ", m)
        }
        qs::qread(file.qs)
      })
    ans <- dplyr::bind_rows(L)
    assign("MB_2021", value = ans, envir = ENV())
    return(ans)
  }
  file.qs <- system.file("extdata", paste0(nom, ".qs"), package = "ASGS")
  ans <- qs::qread(file.qs)
  assign(nom, value = ans, envir = ENV())
  ans
}

ENV <- function() {
  getOption("ASGS.env")
}

CLEAR_ENV <- function() {
  rm(list = ls(envir = getOption("ASGS.env")), envir = getOption("ASGS.env"))
}

MB_to_SA <- function(to = "SA2") {
  MB_2021 <- GET("MB_2021")
  
}


