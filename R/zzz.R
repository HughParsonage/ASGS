.onLoad <- function(libname = find.package("ASGS"), pkgname = "ASGS") {
  if (is.null(getOption("ASGS.env"))) {
    options("ASGS.env" = new.env(parent = emptyenv()))
  }
}