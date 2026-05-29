# Bracket helpers

If you have table values that take the form *point estimate (uncertainty
estimate)*, you can use these functions to access specific parts of the
table value.

## Usage

``` r
bracket_drop(x, bracket_left = "(", bracket_right = ")")

bracket_extract(
  x,
  bracket_left = "(",
  bracket_right = ")",
  drop_bracket = FALSE
)

bracket_insert_left(x, string, bracket_left = "(", bracket_right = ")")

bracket_insert_right(x, string, bracket_left = "(", bracket_right = ")")

bracket_point_estimate(x, bracket_left = "(", bracket_right = ")")

bracket_lower_bound(
  x,
  bracket_left = "(",
  separator = ",",
  bracket_right = ")"
)

bracket_upper_bound(
  x,
  bracket_left = "(",
  separator = ",",
  bracket_right = ")"
)
```

## Arguments

- x:

  a character vector where each value contains a point estimate and
  confidence limits.

- bracket_left:

  a character value specifying what symbol is used to bracket the left
  hand side of the confidence interval

- bracket_right:

  a character value specifying what symbol is used to bracket the right
  hand side of the confidence interval

- drop_bracket:

  a logical value (`TRUE` or `FALSE`). If `TRUE`, then the symbols on
  the left and right hand side of the interval will not be included in
  the returned value. If `FALSE`, these symbols will be included.

- string:

  a character value of a string that will be inserted into the left or
  right side of the bracket.

- separator:

  a character value specifying what symbol is used to separate the lower
  and upper bounds of the interval.

## Value

a character value with length equal to the length of `x`.

## Examples

``` r

tbl_value <- "12.1 (95% CI: 9.1, 15.1)"
bracket_drop(tbl_value)
#> [1] "12.1"
bracket_point_estimate(tbl_value)
#> [1] "12.1"
bracket_extract(tbl_value, drop_bracket = TRUE)
#> [1] "95% CI: 9.1, 15.1"
bracket_lower_bound(tbl_value)
#> [1] "9.1"
bracket_upper_bound(tbl_value)
#> [1] "15.1"
```
