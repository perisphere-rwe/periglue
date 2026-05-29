# Setting a default rounding specification

If you ever get tired of having to write
`peri_glue(..., rspec = your_rspec)` and would rather just write
`peri_glue(...)`, you should find this vignette helpful.

``` r

library(periglue)
```

## Setting a default with `set_default_rounding_spec()`

Build a rounding specification with
[`round_spec()`](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)
and the `round_`/`format_` helper families, then pass it to
[`set_default_rounding_spec()`](https://perisphere-rwe.github.io/periglue/reference/set_default_rounding_spec.md).
All subsequent calls to
[`peri_glue()`](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md)
and
[`peri_value()`](https://perisphere-rwe.github.io/periglue/reference/peri_value.md)
will use it automatically.

``` r

rspec <- round_spec() |>
  round_using_decimal(digits = 5)

set_default_rounding_spec(rspec)

peri_value(pi)
#> [1] "3.14159"
```

## Clearing the default

Pass `NULL` to revert to factory settings.

``` r

set_default_rounding_spec(NULL)

peri_value(pi)
#> [1] "3.1"
```

## Saving and restoring

[`set_default_rounding_spec()`](https://perisphere-rwe.github.io/periglue/reference/set_default_rounding_spec.md)
invisibly returns the *previous* default, which makes it straightforward
to save and restore around a block of code.

``` r

rspec <- round_spec() |> round_using_decimal(digits = 3)

old <- set_default_rounding_spec(rspec)
peri_value(pi)
#> [1] "3.142"

# Restore whatever was set before
set_default_rounding_spec(old)
peri_value(pi)
#> [1] "3.1"
```

## Factory defaults vs. stored defaults

`round_spec(force_default = TRUE)` bypasses both the stored default and
any `periglue.*` global options, always returning the factory settings.
This is useful if you need a clean baseline to build from regardless of
session state.

``` r

set_default_rounding_spec(round_spec() |> round_using_decimal(digits = 5))

# Ignores the stored default
round_spec(force_default = TRUE)$digits
#> [1] 1
```
