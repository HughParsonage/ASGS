# ASGS
An R package to store ABS geographic data structures

## Installation

**Don't install this repo**. GitHub is not suitable for such large data packages. For now, please install by running

```r
if (!requireNamespace("ASGS", quietly = TRUE)) {
  message("Attempting install of ASGS (200 MB) from Dropbox. ",
          "This may take some minutes to download.")
  tempf <- tempfile(fileext = ".tar.gz")
  download.file(url = "https://www.dropbox.com/s/ff815l1zkabfb3z/ASGS_0.0.1.tar.gz?dl=1",
                destfile = tempf)
  install.packages(tempf, type = "source", repos = NULL)
}
```
