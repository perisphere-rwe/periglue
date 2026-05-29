# Round estimates and their corresponding errors

Though they are not easy to find in print, there are some general
conventions for rounding numbers. When rounding a summary statistic such
as the mean or median, the number of rounded digits shown should be
governed by the precision of the statistic. For instance, authors are
usually asked to present means plus or minus standard deviations in
published research, or regression coefficients plus or minus the
standard error. The convention applied here is to

1.  find the place of the first significant digit of the error

2.  round the estimate to that place

3.  round the error to 1 additional place

4.  present the combination in a form such as estimate (error) or
    estimate +/- error

## Usage

``` r
peri_ester(
  estimate,
  error,
  form = "{estimate} ± {error}",
  majority_rule = FALSE
)

peri_estin(
  estimate,
  lower,
  upper,
  form = "{estimate} ({lower}, {upper})",
  majority_rule = FALSE
)
```

## Arguments

- estimate:

  a numeric vector of estimate values.

- error:

  a numeric vector of error values. All errors should be \>0.

- form:

  a character value that indicates how the error and estimate should be
  formatted together. Users can specify anything they like as long as
  they use the terms `estimate` and `error` to refer to the estimate and
  error values, respectively, and encapsulate those terms inside of
  curly brackets, i.e., { } . For instance, if estimate = 1.23 and error
  = 0.45, then `form` = "{estimate} ({error})" will return "1.2 (0.45)",
  a common format used in presentation of the point and error
  combination. The default `form` gives output in the form of 1.2 +/-
  0.45.

- majority_rule:

  a logical value. If `TRUE`, then the most common digit used for
  rounding will be used to round every number given. Within a single
  table, consistency in saving digits may be desirable, so all numbers
  may be rounded to the place indicated by the majority of the numbers.
  Notably, if a user wants to exercise more control over the number of
  decimals shown, they should use
  [`peri_glue()`](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md)
  with a customized rounding specification (see
  [round_spec](https://perisphere-rwe.github.io/periglue/reference/round_spec.md)).

- lower:

  the lower-bound of an interval for the estimate.

- upper:

  the upper-bound of an interval for the estimate.

## Value

a character vector

## References

Blackstone, Eugene H. "Rounding numbers" (2016): *The Journal of
Thoracic and Cardiovascular Surgery*. DOI:
https://doi.org/10.1016/j.jtcvs.2016.09.003

## See also

Other table helpers:
[`peri_glue()`](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md),
[`peri_n_pct()`](https://perisphere-rwe.github.io/periglue/reference/peri_n_pct.md),
[`peri_pvalue()`](https://perisphere-rwe.github.io/periglue/reference/peri_pvalue.md),
[`peri_value()`](https://perisphere-rwe.github.io/periglue/reference/peri_value.md)

## Examples

``` r

# ---- examples are taken from Blackstone, 2016 ----

# Example 1: ----
# Mean age is 72.17986, and the standard deviation (SD) is 9.364132.
## Steps:
## - Nine is the first significant figure of the SD.
## - Nine is in the ones place. Thus...
##   + round the mean to the ones place (i.e., round(x, digits = 0))
##   + round the SD to the tenths place (i.e., round(x, digits = 1))
peri_ester(estimate = 72.17986, error = 9.364132)
#> [1] "72 ± 9.4"
# > [1] 72 +/- 9.4

# an estimated lower and upper bound for 95% confidence limits
lower <- 72.17986 - 1.96 * 9.364132
upper <- 72.17986 + 1.96 * 9.364132
peri_estin(estimate = 72.17986, lower = lower, upper = upper,
            form = "{estimate} (95% CI: {lower}, {upper})")
#> [1] "72 (95% CI: 54, 91)"
# > [1] "72 (95% CI: 54, 91)"

# Example 2: ----
# Mean cost is $72,347.23, and the standard deviation (SD) is $23,994.06.
## Steps:
## - Two is the first significant figure of the SD.
## - Nine is in the ten thousands place. Thus...
##   + round mean to the 10-thousands place (i.e., round(x, digits = -4))
##   + round SD to the thousands place (i.e., round(x, digits = -3))
peri_ester(estimate = 72347.23, error = 23994.06)
#> [1] "70,000 ± 24,000"
# > [1] "70,000 +/- 24,000"

# an estimated lower and upper bound for 95% confidence limits
lower <- 72347.23 - 1.96 * 23994.06
upper <- 72347.23 + 1.96 * 23994.06
peri_estin(estimate = 72347.23, lower = lower, upper = upper,
            form = "{estimate} (95% CI: {lower} - {upper})")
#> [1] "70,000 (95% CI: 30,000 - 120,000)"
# > [1] "70,000 (95% CI: 30,000 - 120,000)"

```
