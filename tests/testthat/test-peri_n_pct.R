
test_that("basic formatting works", {

  expect_equal(peri_n_pct(n = 123, pct = 0.452), "123 (45.2%)")
  expect_equal(peri_n_pct(n = 0,   pct = 0),     "0 (0.0%)")

})

test_that("vectorised input works", {

  result <- peri_n_pct(n = c(10, 20, 30), pct = c(0.1, 0.2, 0.3))
  expect_equal(result, c("10 (10.0%)", "20 (20.0%)", "30 (30.0%)"))

})

test_that("NA and NaN proportions are replaced with miss_replace", {

  result <- peri_n_pct(n = c(10, 0), pct = c(0.5, NaN))
  expect_equal(result[2], "0 (--)")

  result_na <- peri_n_pct(n = c(10, NA), pct = c(0.5, NA))
  expect_equal(result_na[2], "-- (--)")

})

test_that("counts are always whole numbers regardless of rspec", {

  rspec <- round_spec() |> round_using_decimal(digits = 3)
  result <- peri_n_pct(n = 123, pct = 0.452, rspec = rspec)
  # n should still be "123", not "123.000"
  expect_equal(result, "123 (45.200%)")

})

test_that("big_mark from rspec is applied to n", {

  rspec <- round_spec() |> format_big(mark = ",")
  expect_equal(peri_n_pct(n = 12345, pct = 0.678, rspec = rspec),
               "12,345 (67.8%)")

})

test_that("custom form works", {

  expect_equal(
    peri_n_pct(n = 123, pct = 0.452, form = "{n} [{pct}%]"),
    "123 [45.2%]"
  )

})

test_that("length mismatch throws an error", {

  expect_error(
    peri_n_pct(n = c(1, 2), pct = 0.5),
    "lengths.*do not match"
  )

})

test_that("pct out of bounds throws an error", {

  expect_error(peri_n_pct(n = 10, pct = 1.5), "should be <= 1")
  expect_error(peri_n_pct(n = 10, pct = -0.1), "should be >= 0")

})

test_that("invalid rspec throws an error", {

  expect_error(peri_n_pct(n = 10, pct = 0.5, rspec = "bad"),
               "rounding_specification")

})
