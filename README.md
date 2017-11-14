# ASGS
An R package to store ABS geographic data structures

## Installation

**Don't install this repo**. GitHub is not suitable for such large data packages. For now, please install by running

```r
message("Attempting install of ASGS (700 MB) from Dropbox. This should take some minutes to download.")
tempf <- tempfile(fileext = ".tar.gz")
download.file(url = "https://dl.dropbox.com/s/zmggqb1wmmv7mqe/ASGS_0.4.0.tar.gz",
              destfile = tempf)
```

I've tested the above, but only using my computer. Please file an issue if you're unable to access the files, or if the zip file or tarball downloads successfully but the installation fails.

## NEWS

### 2017-11-13
- Add 2006 CD centroids

### 2017-08-21
- Add POA, LGA, DZN_2011 files

### 2017-08-15
- Add `grattan_leaflet` for grattan charts in the leaflet style.
