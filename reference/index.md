# Package index

## Format values

Functions for converting numeric vectors into formatted character
strings ready for table cells.

- [`peri_glue()`](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md)
  : Expressive rounding for table values
- [`peri_value()`](https://perisphere-rwe.github.io/periglue/reference/peri_value.md)
  : General rounding for tables
- [`peri_n_pct()`](https://perisphere-rwe.github.io/periglue/reference/peri_n_pct.md)
  : Format a count and percentage pair
- [`peri_pvalue()`](https://perisphere-rwe.github.io/periglue/reference/peri_pvalue.md)
  : Round p-values
- [`peri_ester()`](https://perisphere-rwe.github.io/periglue/reference/peri_ester.md)
  [`peri_estin()`](https://perisphere-rwe.github.io/periglue/reference/peri_ester.md)
  : Round estimates and their corresponding errors

## Rounding specifications

Build and configure a `rounding_specification` object that controls how
values are rounded and formatted.

- [`round_spec()`](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)
  : Make a rounding specification
- [`set_default_rounding_spec()`](https://perisphere-rwe.github.io/periglue/reference/set_default_rounding_spec.md)
  : Set the default rounding specification used by periglue functions
- [`round_using_magnitude()`](https://perisphere-rwe.github.io/periglue/reference/round_using_magnitude.md)
  [`round_using_signif()`](https://perisphere-rwe.github.io/periglue/reference/round_using_magnitude.md)
  [`round_using_decimal()`](https://perisphere-rwe.github.io/periglue/reference/round_using_magnitude.md)
  : Set rules for rounding numbers
- [`round_half_up()`](https://perisphere-rwe.github.io/periglue/reference/round_half_up.md)
  [`round_half_even()`](https://perisphere-rwe.github.io/periglue/reference/round_half_up.md)
  : Set rules for rounding ties
- [`format_big()`](https://perisphere-rwe.github.io/periglue/reference/format_big.md)
  : Format values left of decimal
- [`format_decimal()`](https://perisphere-rwe.github.io/periglue/reference/format_decimal.md)
  : Format decimal symbol
- [`format_missing()`](https://perisphere-rwe.github.io/periglue/reference/format_missing.md)
  : Format missing values
- [`format_small()`](https://perisphere-rwe.github.io/periglue/reference/format_small.md)
  : Format values right of decimal

## Bracket helpers

Extract or manipulate components of bracket-formatted strings such as
`"3.1 (2.0, 4.2)"`.

- [`bracket_drop()`](https://perisphere-rwe.github.io/periglue/reference/bracket_drop.md)
  [`bracket_extract()`](https://perisphere-rwe.github.io/periglue/reference/bracket_drop.md)
  [`bracket_insert_left()`](https://perisphere-rwe.github.io/periglue/reference/bracket_drop.md)
  [`bracket_insert_right()`](https://perisphere-rwe.github.io/periglue/reference/bracket_drop.md)
  [`bracket_point_estimate()`](https://perisphere-rwe.github.io/periglue/reference/bracket_drop.md)
  [`bracket_lower_bound()`](https://perisphere-rwe.github.io/periglue/reference/bracket_drop.md)
  [`bracket_upper_bound()`](https://perisphere-rwe.github.io/periglue/reference/bracket_drop.md)
  : Bracket helpers
- [`as_inline()`](https://perisphere-rwe.github.io/periglue/reference/as_inline.md)
  : Convert table data to inline list

## Data

- [`nhanes`](https://perisphere-rwe.github.io/periglue/reference/nhanes.md)
  : NHANES blood pressure data
