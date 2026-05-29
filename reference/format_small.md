# Format values right of decimal

Values to the right of the decimal are generally called 'small' since
they are smaller than values to the left of the decimal.
`format_small()` lets you update the settings of a
`rounding_specification` object (see
[round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md))
so that values right of the decimal will be printed with a specific
format (see examples).

## Usage

``` r
format_small(rspec, mark = "", interval = 5L)
```

## Arguments

- rspec:

  a `rounding_specification` object (see
  [round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)).

- mark:

  a character value used to separate number groups to the right of the
  decimal point. See [prettyNum](https://rdrr.io/r/base/formatc.html)
  for more details on this. Set this input to ” to negate it's effect.

- interval:

  a numeric value indicating the size of number groups for numbers left
  of the decimal.

## Value

an object of class `rounding_specification`.

## See also

Other formatting helpers:
[`format_decimal()`](https://perisphere-rwe.github.io/periglue/reference/format_decimal.md)

## Examples

``` r

small_x <- 0.1234567

rspec <- round_spec()
rspec <- round_using_decimal(rspec, digits = 7)
rspec <- format_small(rspec, mark = '*', interval = 1)

peri_value(small_x, rspec)
#> [1] "0.1*2*3*4*5*6*7"
```
