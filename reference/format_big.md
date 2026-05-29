# Format values left of decimal

Values to the left of the decimal are generally called 'big' since they
are larger than values to the right of the decimal. `format_big()` lets
you update the settings of a `rounding_specification` object (see
[round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md))
so that values left of the decimal will be printed with a specific
format (see examples).

## Usage

``` r
format_big(rspec, mark = ",", interval = 3L)
```

## Arguments

- rspec:

  a `rounding_specification` object (see
  [round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)).

- mark:

  a character value used to separate number groups to the left of the
  decimal point. See [prettyNum](https://rdrr.io/r/base/formatc.html)
  for more details on this. Set this input to ” to negate it's effect.

- interval:

  a numeric value indicating the size of number groups for numbers left
  of the decimal.

## Value

an object of class `rounding_specification`.

## Examples

``` r

big_x <- 1234567

rspec <- format_big(round_spec(), mark = '|', interval = 3)

peri_value(big_x, rspec) # returns "1|234|567"
#> [1] "1|234|567.0"
```
