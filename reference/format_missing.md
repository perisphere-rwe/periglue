# Format missing values

`format_missing()` updates a `rounding_specification` object so that
missing values are printed as the user specifies.

## Usage

``` r
format_missing(rspec, replace_na_with)
```

## Arguments

- rspec:

  a `rounding_specification` object (see
  [round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)).

- replace_na_with:

  a character value that replaces missing values.

## Value

an object of class `rounding_specification`.

## Examples

``` r

rspec <- round_spec()
rspec <- format_missing(rspec, 'oh no!')
peri_value(x = c(pi, NA), rspec)
#> [1] "3.1"    "oh no!"
```
