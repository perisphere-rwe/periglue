# Set the default rounding specification used by periglue functions

Stores a `rounding_specification` object as the session-wide default
used by
[`peri_glue()`](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md)
and
[`peri_value()`](https://perisphere-rwe.github.io/periglue/reference/peri_value.md)
when no `rspec` argument is supplied. This is an alternative to setting
individual `periglue.*` options by hand. Pass `NULL` to clear the stored
default and revert to factory settings.

## Usage

``` r
set_default_rounding_spec(rspec)
```

## Arguments

- rspec:

  a `rounding_specification` object created with
  [`round_spec()`](https://perisphere-rwe.github.io/periglue/reference/round_spec.md),
  or `NULL` to clear the current default.

## Value

invisibly returns the previous default rounding specification, or `NULL`
if none was set. This makes it easy to save and restore:
`old <- set_default_rounding_spec(new_spec)`.

## Examples

``` r

# Set a custom default
rspec <- round_spec() |> round_using_decimal(digits = 3)
set_default_rounding_spec(rspec)

# peri_* functions now use this spec without needing rspec = ...
peri_value(pi)
#> [1] "3.142"

# Clear the default to revert to factory settings
set_default_rounding_spec(NULL)

peri_value(pi)
#> [1] "3.1"
```
