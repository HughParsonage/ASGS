context("Lat-lon to SA")

test_that("Returns Goulburn given the centroid", {
  out <- latlon2SA(-34.75, 149.7195, to = "SA2", yr = "2011")
  expect_equal(as.character(out$SA2_MAIN11), "101011001")
  out <- latlon2SA(-34.75, 149.7195, to = "SA2", return = "v")
  expect_equal(out, "Goulburn")
})
