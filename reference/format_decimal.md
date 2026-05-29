# Format decimal symbol

`format_decimal()` lets you update the settings of a
`rounding_specification` object (see
[round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md))
so that the decimal is represented by a user-specified mark.

## Usage

``` r
format_decimal(rspec, mark = ".")
```

## Arguments

- rspec:

  a `rounding_specification` object (see
  [round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)).

- mark:

  a character value used to represent the decimal point.

## Value

an object of class `rounding_specification`.

## See also

Other formatting helpers:
[`format_small()`](https://perisphere-rwe.github.io/periglue/reference/format_small.md)

## Examples

``` r

small_x <- 0.1234567

rspec <- round_spec()
rspec <- round_using_decimal(rspec, digits = 7)
rspec <- format_decimal(rspec, mark = '*')

peri_value(small_x, rspec)
#> [1] "0*1234567"
```
