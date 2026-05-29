# Make a rounding specification

`round_spec()` creates a rounding specification object with default
settings. The settings of a rounding specification object can be updated
using functions in the `round_` (see
[round_half_up](https://perisphere-rwe.github.io/periglue/reference/round_half_up.md),
[round_half_even](https://perisphere-rwe.github.io/periglue/reference/round_half_up.md),
[round_using_signif](https://perisphere-rwe.github.io/periglue/reference/round_using_magnitude.md),
[round_using_decimal](https://perisphere-rwe.github.io/periglue/reference/round_using_magnitude.md),
and
[round_using_magnitude](https://perisphere-rwe.github.io/periglue/reference/round_using_magnitude.md))
and `format_` (see
[format_missing](https://perisphere-rwe.github.io/periglue/reference/format_missing.md),
[format_big](https://perisphere-rwe.github.io/periglue/reference/format_big.md),
[format_small](https://perisphere-rwe.github.io/periglue/reference/format_small.md),
and
[format_decimal](https://perisphere-rwe.github.io/periglue/reference/format_decimal.md))
families.

## Usage

``` r
round_spec(force_default = FALSE)
```

## Arguments

- force_default:

  a logical value. If `TRUE`, then `round_spec()` ignores any stored
  default (see
  [set_default_rounding_spec](https://perisphere-rwe.github.io/periglue/reference/set_default_rounding_spec.md))
  and global options, returning factory default values. If `FALSE`,
  `round_spec()` first checks for a stored default, then falls back to
  `periglue.*` global options.

## Value

an object of class `rounding_specification`.

## Details

Rounding specifications are meant to be passed into the
[peri_glue](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md)
and
[peri_value](https://perisphere-rwe.github.io/periglue/reference/peri_value.md)
functions. A session-wide default specification can be stored with
[`set_default_rounding_spec()`](https://perisphere-rwe.github.io/periglue/reference/set_default_rounding_spec.md),
which `round_spec()` will use automatically when
`force_default = FALSE`.

The `round_spec()` function intentionally uses no input arguments. This
is to encourage users to develop rounding specifications using the
`round_` and `format_` families in conjunction with the pipe (`|>`)
operator.

## Examples

``` r

rspec <- round_spec()

peri_value(x = pi, rspec)
#> [1] "3.1"
```
