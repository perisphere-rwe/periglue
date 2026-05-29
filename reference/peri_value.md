# General rounding for tables

`peri_value()` casts numeric vectors into character vectors. The main
purpose of `peri_value()` is to round and format numeric data for
presentation.

## Usage

``` r
peri_value(x, rspec = NULL)
```

## Arguments

- x:

  a vector of numeric values.

- rspec:

  a `rounding_specification` object. If no `rspec` is given, a default
  setting will round values to decimal places based on the magnitude of
  the values.

## Value

a vector of character values (rounded numbers).

## See also

Other table helpers:
[`peri_ester()`](https://perisphere-rwe.github.io/periglue/reference/peri_ester.md),
[`peri_glue()`](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md),
[`peri_n_pct()`](https://perisphere-rwe.github.io/periglue/reference/peri_n_pct.md),
[`peri_pvalue()`](https://perisphere-rwe.github.io/periglue/reference/peri_pvalue.md)

## Examples

``` r

peri_value(0.123)
#> [1] "0.1"
peri_value(1.23)
#> [1] "1.2"
peri_value(12.3)
#> [1] "12.3"

with(mtcars, peri_value(disp))
#>  [1] "160.0" "160.0" "108.0" "258.0" "360.0" "225.0" "360.0" "146.7" "140.8"
#> [10] "167.6" "167.6" "275.8" "275.8" "275.8" "472.0" "460.0" "440.0" "78.7" 
#> [19] "75.7"  "71.1"  "120.1" "318.0" "304.0" "350.0" "400.0" "79.0"  "120.3"
#> [28] "95.1"  "351.0" "145.0" "301.0" "121.0"
```
