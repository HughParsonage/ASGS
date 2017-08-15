# ASGS
An R package to store ABS geographic data structures

## Installation

**Don't install this repo**. GitHub is not suitable for such large data packages. For now, please install by running

```r
if (!requireNamespace("ASGS", quietly = TRUE)) {
 DropboxInfo <- 
    if (Sys.getenv("OS") == "Windows_NT") {
      file.path(Sys.getenv("LOCALAPPDATA"), "Dropbox", "info.json")
    } else {
      "~/.dropbox/info.json"
    }
  if (file.exists(DropboxInfo)) {
    Path2Dropbox <- 
      jsonlite::fromJSON(DropboxInfo) %>%
      use_series("business") %>%
      use_series("path")
    
    Path2ASGS <-
      file.path(Path2Dropbox,
                "/Other/r-packages/ASGS_0.4.0.tar.gz")
    
    if (file.exists(Path2ASGS)) {
      install.packages(Path2ASGS, type = "source", repos = NULL)
    } else {
      message("Attempting install of ASGS (500 MB) from Dropbox. ",
              "This should take some minutes to download.")
      tempf <- tempfile(fileext = ".tar.gz")
      download.file(url = "https://dl.dropbox.com/s/zmggqb1wmmv7mqe/ASGS_0.4.0.tar.gz?dl=1",
                    destfile = tempf)
      install.packages(tempf, repos = NULL, type = "source")
    }
  }
}
```

If the above fails to work, you can try the (Windows) binary version:

```r
if (!requireNamespace("ASGS", quietly = TRUE)) {
 DropboxInfo <- 
    if (Sys.getenv("OS") == "Windows_NT") {
      file.path(Sys.getenv("LOCALAPPDATA"), "Dropbox", "info.json")
    } else {
      "~/.dropbox/info.json"
    }
  if (file.exists(DropboxInfo)) {
    Path2Dropbox <- 
      jsonlite::fromJSON(DropboxInfo) %>%
      use_series("business") %>%
      use_series("path")
    
    Path2ASGS <-
      file.path(Path2Dropbox,
                "/Other/r-packages/ASGS_0.4.0.zip")
    
    if (file.exists(Path2ASGS)) {
      install.packages(Path2ASGS, repos = NULL)
    } else {
      message("Attempting install of ASGS (500 MB) from Dropbox. ",
              "This should take some minutes to download.")
      tempf <- tempfile(fileext = ".tar.gz")
      download.file(url = "https://dl.dropbox.com/s/1z34bu7h8fyic9e/ASGS_0.4.0.zip?dl=1",
                    destfile = tempf)
      install.packages(tempf, repos = NULL, type = "source")
    }
  }
}
```

I've tested the above, but only using my computer. Please file an issue if you're unable to access the files, or if the zip file or tarball downloads successfully but the installation fails.

## NEWS

### 2017-08-15
- Add `grattan_leaflet` for grattan charts in the leaflet style.
