
# Always clear the stored default after each test file so tests
# don't interfere with each other.
teardown(set_default_rounding_spec(NULL))

test_that("set_default_rounding_spec stores a rspec and peri_value uses it", {

  on.exit(set_default_rounding_spec(NULL))

  rspec <- round_spec() |> round_using_decimal(digits = 5)
  set_default_rounding_spec(rspec)

  expect_equal(peri_value(pi), "3.14159")

})

test_that("set_default_rounding_spec returns the previous default invisibly", {

  on.exit(set_default_rounding_spec(NULL))

  rspec1 <- round_spec() |> round_using_decimal(digits = 1)
  rspec2 <- round_spec() |> round_using_decimal(digits = 4)

  set_default_rounding_spec(rspec1)
  old <- set_default_rounding_spec(rspec2)

  expect_equal(old, rspec1)

})

test_that("set_default_rounding_spec(NULL) clears the default", {

  rspec <- round_spec() |> round_using_decimal(digits = 5)
  set_default_rounding_spec(rspec)
  set_default_rounding_spec(NULL)

  # Should revert to factory default (decimal/1, not 5 decimals)
  expect_equal(peri_value(pi), "3.1")

})

test_that("force_default = TRUE bypasses the stored default", {

  on.exit(set_default_rounding_spec(NULL))

  rspec <- round_spec() |> round_using_decimal(digits = 5)
  set_default_rounding_spec(rspec)

  # round_spec(force_default = TRUE) should ignore the stored spec
  factory <- round_spec(force_default = TRUE)
  expect_equal(factory$round_using, "decimal")
  expect_equal(factory$digits, 1)

})

test_that("set_default_rounding_spec rejects non-rspec input", {

  expect_error(
    set_default_rounding_spec("not a spec"),
    "rounding_specification"
  )

})
