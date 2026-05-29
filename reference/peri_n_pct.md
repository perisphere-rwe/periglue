# Format a count and percentage pair

`peri_n_pct()` formats a count (`n`) and a proportion (`pct`) together
as a character string in the form `"n (xx.x%)"`. This is the most common
cell format in demographic and summary tables.

## Usage

``` r
peri_n_pct(n, pct, rspec = NULL, form = "{n} ({pct}%)")
```

## Arguments

- n:

  a numeric vector of counts (non-negative integers).

- pct:

  a numeric vector of proportions, i.e., values in \[0, 1\]. These are
  multiplied by 100 before display.

- rspec:

  a `rounding_specification` object (see
  [round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md))
  used to format the percentage. Counts are always shown as whole
  numbers. If `NULL`, the current default rounding specification is
  used.

- form:

  a character string controlling how `n` and `pct` are combined. Use
  `{n}` and `{pct}` as placeholders. Defaults to `"{n} ({pct}%)"`.

## Value

a character vector the same length as `n` and `pct`.

## See also

Other table helpers:
[`peri_ester()`](https://perisphere-rwe.github.io/periglue/reference/peri_ester.md),
[`peri_glue()`](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md),
[`peri_pvalue()`](https://perisphere-rwe.github.io/periglue/reference/peri_pvalue.md),
[`peri_value()`](https://perisphere-rwe.github.io/periglue/reference/peri_value.md)

## Examples

``` r

peri_n_pct(n = 123, pct = 0.452)
#> [1] "123 (45.2%)"

# vectorised
peri_n_pct(n = c(123, 456, 0), pct = c(0.123, 0.456, 0))
#> [1] "123 (12.3%)" "456 (45.6%)" "0 (0.0%)"   

# NA proportions are replaced with miss_replace from the rounding spec
peri_n_pct(n = c(10, 0), pct = c(0.5, NaN))
#> [1] "10 (50.0%)" "0 (--)"    

# large counts respect the big_mark setting
rspec <- round_spec() |> format_big(mark = ",")
peri_n_pct(n = 12345, pct = 0.678, rspec = rspec)
#> [1] "12,345 (67.8%)"

# custom form
peri_n_pct(n = 123, pct = 0.452, form = "{n} [{pct}%]")
#> [1] "123 [45.2%]"
```
