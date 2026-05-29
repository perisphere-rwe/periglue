# Set rules for rounding numbers

These functions update a `rounding_specification` object (see
[round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md))
so that a particular approach to rounding is applied:

- round to a dynamic decimal place based on magnitude of the rounded
  number (`round_using_magnitude()`)

- round to a specific number of significant digits
  (`round_using_signif()`)

- round to a specific decimal place (`round_using_decimal()`)

## Usage

``` r
round_using_magnitude(rspec, digits = c(2, 1, 0), breaks = c(1, 10, Inf))

round_using_signif(rspec, digits = 2)

round_using_decimal(rspec, digits = 1)
```

## Arguments

- rspec:

  a `rounding_specification` object (see
  [round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)).

- digits:

  for `round_using_decimal()` and `round_using_signif`, a numeric value
  specifying the number of decimal places and significant digits to
  round to, respectively. For `round_using_magnitude()`, `digits` should
  be a numeric vector of equal length to `breaks` that indicates how
  many decimals to round to in the numeric range designated by `breaks`.
  (see notes for example).

- breaks:

  (only relevant if rounding based on magnitude) a positive,
  monotonically increasing numeric vector designating rounding
  boundaries.

## Value

an object of class `rounding_specification`.

## Details

`digits` and `breaks` must be used in coordination with each other when
rounding based on magnitude. For example, using `breaks = c(1, 10, Inf)`
and `decimals = c(2, 1, 0)`,

- numbers whose absolute value is \< 1 are rounded to 2 decimal places,

- numbers whose absolute value is \>= 1 and \< 10 are rounding to 1
  decimal place, and

- numbers whose absolute value is \>= 10 are rounding to 0 decimal
  places. The use of magnitude to guide rounding rules is extremely
  flexible and can be used for many different applications (e.g., see
  [peri_pvalue](https://perisphere-rwe.github.io/periglue/reference/peri_pvalue.md)).
  Rounding by magnitude is similar in some ways to rounding to a set
  number of significant digits but not entirely the same (see examples).

## See also

Other rounding helpers:
[`round_half_up()`](https://perisphere-rwe.github.io/periglue/reference/round_half_up.md)

## Examples

``` r

x <- c(pi, exp(1))
x <- c(x, x*10, x*100, x*1000)

# make one specification using each rounding approach
specs <- list(
  magnitude = round_using_magnitude(round_spec()),
  decimal = round_using_decimal(round_spec()),
  signif = round_using_signif(round_spec())
)

# apply all three rounding specifications to x
# notice how the rounding specifications are in agreement
# for smaller values of x but their answers are different
# for larger values of x.

sapply(specs, function(rspec) peri_value(x, rspec))
#>      magnitude decimal   signif   
#> [1,] "3.1"     "3.1"     "3.1"    
#> [2,] "2.7"     "2.7"     "2.7"    
#> [3,] "31"      "31.4"    "31.0"   
#> [4,] "27"      "27.2"    "27.0"   
#> [5,] "314"     "314.2"   "310.0"  
#> [6,] "272"     "271.8"   "270.0"  
#> [7,] "3,142"   "3,141.6" "3,100.0"
#> [8,] "2,718"   "2,718.3" "2,700.0"

# output:
#  magnitude   decimal    signif
# [1,] "3.1"     "3.1"     "3.1"
# [2,] "2.7"     "2.7"     "2.7"
# [3,] "31"      "31.4"    "31.0"
# [4,] "27"      "27.2"    "27.0"
# [5,] "314"     "314.2"   "310.0"
# [6,] "272"     "271.8"   "270.0"
# [7,] "3,142"   "3,141.6" "3,100.0"
# [8,] "2,718"   "2,718.3" "2,700.0"
```
