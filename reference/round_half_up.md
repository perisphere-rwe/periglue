# Set rules for rounding ties

Rounding a number x to the nearest integer requires some tie-breaking
rule for those cases when x is exactly half-way between two integers,
that is, when the fraction part of x is exactly 0.5. The
`round_half_up()` function implements a tie-breaking rule that
consistently rounds half units upward. Although this creates a slight
bias toward larger rounded outputs, it is widely used in many
disciplines. The `round_half_even()` function breaks ties by rounding to
the nearest even unit.

## Usage

``` r
round_half_up(rspec)

round_half_even(rspec)
```

## Arguments

- rspec:

  a `rounding_specification` object (see
  [round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)).

## Value

an object of class `rounding_specification`.

## See also

Other rounding helpers:
[`round_using_magnitude()`](https://perisphere-rwe.github.io/periglue/reference/round_using_magnitude.md)

## Examples

``` r

# note base R behavior rounds to even:
round(0.5) # --> 0
#> [1] 0
round(1.5) # --> 2
#> [1] 2
round(2.5) # --> 2
#> [1] 2

# make rspec that rounds up
rspec <- round_half_up(round_spec())
rspec <- round_using_decimal(rspec, digits = 0)

# check
peri_value(0.5, rspec) # --> 1
#> [1] "1"
peri_value(1.5, rspec) # --> 2
#> [1] "2"
peri_value(2.5, rspec) # --> 3
#> [1] "3"

# make rspec that rounds even
rspec <- round_half_even(round_spec())
rspec <- round_using_decimal(rspec, digits = 0)

# check
peri_value(0.5, rspec) # --> 0
#> [1] "0"
peri_value(1.5, rspec) # --> 2
#> [1] "2"
peri_value(2.5, rspec) # --> 2
#> [1] "2"
```
