.onLoad <- function(libname = find.package("ASGS"), pkgname = "ASGS") {
 if (getRversion() >= "2.15.1") {
   utils::globalVariables(c(".", 
                            "SA1_2011", "SA1_2011_simple", "SA1_2016", "SA1_2016_simple", "SA2_2011",
                            "SA2_2011_simple", "SA2_2016", "SA2_2016_simple", "SA3_2011", "SA3_2011_simple",
                            "SA3_2016", "SA4_2011", "SA4_2016"))
 } 
}