
rspec <- round_spec()

test_that("unnamed inputs are caught", {

  expect_error(peri_glue("A", rspec, pi), 'non-character objects')

  x <- 1
  df <- data.frame(x = 2)

  expect_equal(peri_glue("x is {x}"), 'x is 1.0')
  expect_equal(peri_glue("x is {x}", .envir = df), 'x is 2.0')

})

test_that("peri_glue does not inject ..f into the calling environment", {

  check_no_leak <- function() {
    x <- 1.23456
    before <- ls(all.names = TRUE)
    peri_glue("{x}")
    after <- ls(all.names = TRUE)
    setdiff(after, before)
  }

  expect_false("..f" %in% check_no_leak())

})
