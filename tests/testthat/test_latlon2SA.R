context("Lat-lon to SA")

test_that("Returns Goulburn given the centroid", {
  out <- latlon2SA(-34.75, 149.7195, to = "SA2", yr = "2011")
  expect_equal(as.character(out$SA2_MAIN11), "101011001")
  out <- latlon2SA(-34.75, 149.7195, to = "SA2", return = "v", yr = "2011")
  expect_equal(as.character(out), "Goulburn")
})

test_that("Returns multiply", {
  out <- latlon2SA(lat = c(-33.8, -37.8), lon = c(151, 145), to = "SA3", yr = "2016")
  expect_equal(as.character(out$SA3_NAME16), c("Parramatta", "Yarra"))
  expect_equal(as.character(out$SA4_NAME16), c("Sydney - Parramatta", "Melbourne - Inner"))
  outv <- latlon2SA(lat = c(-33.8, -37.8), lon = c(151, 145), to = "SA3", yr = "2016",
                    return = "v")
  expect_equal(as.character(outv),  c("Parramatta", "Yarra"))
  
})

test_that("Returns correct close to boundary", {
  # From Slack with DM
  out <- latlon2SA(-37.7537, 144.9507, to = "SA2", yr = "2016", return. = "v")
  expect_equal(as.character(out), "Coburg")
  out <- latlon2SA(-37.7552, 144.9494, to = "SA2", yr = "2016", return. = "v", crs = 4202)
  expect_equal(as.character(out), "Coburg")
})

